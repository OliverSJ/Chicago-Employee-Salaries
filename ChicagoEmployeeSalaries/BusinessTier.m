//
//  BusinessTier.m
//  ChicagoEmployeeSalaries
//
//  Created by Oliver San Juan on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "BusinessTier.h"
#import "EmployeeObject.h"
#import "DataTier.h"

@implementation BusinessTier{
    
    @private
    
    //Object used to execute queries
    DataTier* dt;
    
    //Queries that change from method to method
    NSString* departmentQuery;
    NSString* query;
    
    NSMutableArray *tempArray;
    NSArray *results;
    
    //Variables to create the dictionary that will communicate between the front end and the back end
    NSDictionary* departmentsWithCorrectSpelling;
    NSArray* departForBackEnd;
    NSArray* departForFrontEnd;
    

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // init dataTier with base url for sqlite database
        dt = [[DataTier alloc] initWithDatabaseFilename:@"chicago_employee_salaries_db.sql"];
        
        //Set class variables that are reused to nil
        //employee = nil;
        _name = nil;
        _department = nil;
        
        departmentQuery = nil;
        
        //Set BOOL values to NO as default
        _nameSearch = NO;
        _departmentSearch = NO;
        _nameAndDepartmentSearch = NO;
        _salarySearch = NO;
        
        //Query the database for the list of departments
        results = [[NSArray alloc] initWithArray:[dt loadDataFromDB:@"SELECT DISTINCT(Department) FROM Employees ORDER BY Department ASC;"]];
        
        /** Store just the department strings in tempArray from results (which is an NSArray of NSDictionaries) */
        tempArray = [[NSMutableArray alloc] initWithArray:[results valueForKey:@"Department"]];
        
        //First option for selecting a department will be "(Leave Blank)"
        [tempArray insertObject:@"(Leave Blank)" atIndex:0];
        
        
        departForBackEnd = [NSArray arrayWithArray:tempArray];
        
        //Reset tempArray so that it can be reused to build the NSArray for the front end
        tempArray = nil;
        tempArray = [[NSMutableArray alloc]init];
        
        /* @discussion: The Chicago database misspells some department names (see below for examples).  
                        Directly using the names in the database for the front end would look bad, so
                        I identified the misspelled names and replaced them in the NSDictionary.
         
         */
        for(NSString* tempString in departForBackEnd)
        {
            if(![tempString isEqual:[NSNull null]])
            {
                if([tempString caseInsensitiveCompare:@"ANIMAL CONTRL"] == NSOrderedSame){
                    [tempArray addObject: @"ANIMAL CONTROL"];
                }
                
                else if([tempString caseInsensitiveCompare:@"TRANSPORTN"] == NSOrderedSame){
                    [tempArray addObject:@"TRANSPORTATION"];
                }
                else if([tempString caseInsensitiveCompare:@"ADMIN HEARNG"] == NSOrderedSame){
                    [tempArray addObject:@"ADMIN HEARING"];
                }
                else{
                    [tempArray addObject:tempString];
                }
                
            }//end of outer if statement

        }//end of for loop
        
        // This variable will be accessed by the front end. Convert it to an immutable NSArray
        departForFrontEnd = [NSArray arrayWithArray:tempArray];
        
        //Create the NSDictionary that will be used to as a reference between the front end and the back end
        departmentsWithCorrectSpelling = [[NSDictionary alloc] initWithObjects:departForBackEnd forKeys:departForFrontEnd];
        
        //init query string to nil
        query = nil;
        
    }
    return self;
}


/** @brief: This method returns the list of departments with correct spelling*/
- (NSArray*)getDepartments{
    
    return departForFrontEnd;
    
}


-(void)createDepartmentQuery: (NSString*) department{
    
    //Clear the previous query
    departmentQuery = nil;
    
    //Get the appropriate department name
    departmentQuery = [departmentsWithCorrectSpelling objectForKey:department];
    
    //Replace any apostrophes with a double apostrophe to ensure a working query
    departmentQuery = [departmentQuery stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

#pragma mark Getting and creating Employee Objects

-(NSArray*)createEmployeeObjectsArray{
    
    //Method variables:
    NSString* firstName;
    NSString* lastName;
    NSString* nameForObject;
    NSString* departmentForObject;
    NSString* jobPosition;
    NSString* annualSalary;
    EmployeeObject* employee;
    
    //Reset the tempArray
    tempArray = nil;
    tempArray = [[NSMutableArray alloc] init];
    
    
    //loop through the jsonResponse array, create a new Employee object, and add it to the NSMutableArray
    for(NSDictionary* dictionary in results)
    {
        //Iterate through the dictionary and grab all of the values associated with each key
        //We can't assume which order the keys will be in the dictionary, so double check
        for(id key in dictionary)
        {
            if([key caseInsensitiveCompare:@"Department"] == NSOrderedSame) {
                departmentForObject = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"EmployeeAnnualSalary"] == NSOrderedSame) {
                annualSalary = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"PositionTitle"] == NSOrderedSame) {
                jobPosition = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"FirstName"] == NSOrderedSame) {
                firstName = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"LastName"] == NSOrderedSame) {
                lastName = [dictionary objectForKey:key];
                
                //Concatenate the names:
                nameForObject = [NSString stringWithFormat:@"%@,  %@", lastName, firstName];
                
            }
            
        }//end of inner for loop
        
        //Make the object
        employee = [[EmployeeObject alloc] initWithValues:nameForObject aPosition:jobPosition aDepartment:departmentForObject aSalary:annualSalary];
        
        //Add the object to the mutable array
        [tempArray addObject:employee];
        
        
    }
    
    //Sort the Array alphabetically by name and by department
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor *departmentDescriptor = [[NSSortDescriptor alloc] initWithKey:@"department" ascending:YES];
    NSArray *descriptors = @[nameDescriptor, departmentDescriptor];
    NSArray* returnArray = [tempArray sortedArrayUsingDescriptors:descriptors];
    
    //Return the NSMutableArray as an immutable NSArray
    return returnArray;

}


/** @brief: This method will query the database based on user input for employee name and department
    @param: (NSString*) name: Can be nil or blank
    @param: (NSString*) department: Can be nil or blank
 
    @return: Returns an NSArray of EmployeeObject
 
 */
- (NSArray*)getEmployees:(NSString*)name department:(NSString*)department{
    
    
    if([name length] > 0 && [department length] > 0) {
        
        results = nil;
        
        NSString* firstName = [name componentsSeparatedByString:@" "][0];
        NSString* lastName;
        
        //Check to see if there is a last name provided
        @try{
            
            lastName = [name componentsSeparatedByString:@" "][1];
            
        }
        @catch(NSException *exception){
            
            lastName = nil;
            
        }
        
        //Get the appropriate department name
        //This method will change the class variable departmentQuery
        [self createDepartmentQuery:department];
        
        //Query the database based on user input
        if([firstName length] > 0 && [lastName length] > 0)
        {
            query = [NSString stringWithFormat:@"SELECT * FROM Employees WHERE Department= '%@' AND FirstName LIKE '%%%@%%' AND LastName LIKE '%%%@%%'",departmentQuery, firstName, lastName];
        }
        //Query the database with the "first" name acting as both the first and last names in order to get
        // a more complete list
        else
        {
            query = [NSString stringWithFormat:@"SELECT * FROM Employees WHERE Department= '%@' AND (FirstName LIKE '%%%@%%' OR LastName LIKE '%%%@%%')",departmentQuery, firstName, firstName];
        }
        
        //Grab the results from the database based on the query
        results = [[NSArray alloc] initWithArray:[dt loadDataFromDB:query]];
    }
    else if([name length] > 0){
        
        NSString* firstName = [name componentsSeparatedByString:@" "][0];
        NSString* lastName;
        
        //Check to see if there is a last name provided
        @try{
            
            lastName = [name componentsSeparatedByString:@" "][1];
            
        }
        @catch(NSException *exception){
            
            lastName = nil;
            
        }
        
        //Query the database based on user input
        if([firstName length] > 0 && [lastName length] > 0)
        {
            query = [NSString stringWithFormat:@"SELECT* FROM Employees WHERE FirstName LIKE '%%%@%%' AND LastName='%@';",firstName, lastName];

        }
        //Query the database with the "first" name acting as both the first and last names in order to get
        // a more complete list
        else
        {
            query = [NSString stringWithFormat:@"SELECT* FROM Employees WHERE FirstName LIKE '%%%@%%' OR LastName LIKE '%%%@%%'",firstName, firstName];
        }
        
        //Grab the results from the database based on the query
        results = [[NSArray alloc] initWithArray:[dt loadDataFromDB:query]];
        
    }
    else if([department length] > 0){
        
       //Create the appropriate department query
        [self createDepartmentQuery:department];
        
        query = [NSString stringWithFormat:@"SELECT * FROM Employees WHERE Department='%@'", departmentQuery];
        
        //Grab the results from the database based on the query
        results = [[NSArray alloc] initWithArray:[dt loadDataFromDB:query]];
        
    }
    else{
        NSLog(@"Something went wrong");
        return nil;
    }
    

    return [self createEmployeeObjectsArray];
}

-(NSArray*)getEmployeesBySalary: (NSString*) minSalary maximumRange: (NSString*) maxSalary{
    
    query = [NSString stringWithFormat:@"$where=employee_annual_salary>=%@ AND employee_annual_salary<=%@", minSalary,maxSalary];
    
    return [self createEmployeeObjectsArray];
}


@end
