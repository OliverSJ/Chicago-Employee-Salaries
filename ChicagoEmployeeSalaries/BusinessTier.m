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

@implementation BusinessTier

- (instancetype)init
{
    self = [super init];
    if (self) {
                
        // init dataTier with base url for sqlite database
        _dt = [[DataTier alloc] initWithDatabaseFilename:@"chicago_employee_salaries_db.sql"];
        
        //init the tempArray
        _tempArray = [[NSMutableArray alloc] init];
        
        //Set class variables that are reused to nil
        _name = nil;
        _department = nil;
        _annualSalary = nil;
        _jobPosition = nil;
        _employee = nil;
        
        //Set BOOL values to NO as default
        _nameSearch = NO;
        _departmentSearch = NO;
        _nameAndDepartmentSearch = NO;
        _salarySearch = NO;
        
        _query = @"$select=department&$group=department";
        
        //Query the database for the list of departments
        _results = [[NSArray alloc] initWithArray:[_dt loadDataFromDB:@"SELECT DISTINCT(Department) FROM Employees ORDER BY Department ASC;"]];
        
        NSArray* results = [[NSArray alloc] initWithArray:[_dt loadDataFromDB:@"SELECT* FROM Employees;"]];
        
        /** Store just the department strings in tempArray from results (which is an NSArray of NSDictionaries) */
        NSMutableArray* tempArray = [[NSMutableArray alloc] initWithArray:[_results valueForKey:@"Department"]];
        
        
        //First option for selecting a department will be "(Leave Blank)"
        [tempArray insertObject:@"(Leave Blank)" atIndex:0];
        
        
        _departForBackEnd = [NSArray arrayWithArray:tempArray];
        
        //Reset tempArray so that it can be reused to build the NSArray for the front end
        tempArray = nil;
        tempArray = [[NSMutableArray alloc]init];
        
        /* @discussion: The Chicago database misspells some department names (see below for examples).  
                        Directly using the names in the database for the front end would look bad, so
                        I identified the misspelled names and replaced them in the NSDictionary.
         
         */
        for(NSString* tempString in _departForBackEnd)
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
        _departForFrontEnd = [NSArray arrayWithArray:tempArray];
        
        //Create the NSDictionary that will be used to as a reference between the front end and the back end
        _departmentsWithCorrectSpelling = [[NSDictionary alloc] initWithObjects:_departForBackEnd forKeys:_departForFrontEnd];
        
        //init query string to nil
        _query = nil;
        

    }
    return self;
}

//-(NSString*)parseName:(NSString *)name{
//    
//    NSString* fullName;
//    NSString* firstName = [name componentsSeparatedByString:@" "][0];
//    NSString* lastName;
//    
//    @try{
//        
//        lastName = [name componentsSeparatedByString:@" "][1];
//        
//        fullName = [NSString stringWithFormat:@"%@,  %@", lastName, firstName];
//        
//    }
//    @catch(NSException *exception){
//        
//        lastName = nil;
//        
//        fullName = firstName;
//    }
//    
//    return fullName;
//    
//}

/** @brief: This method returns the list of departments with correct spelling*/
- (NSArray*)getDepartments{
    
    return _departForFrontEnd;
    
}

#pragma mark Getting and creating Employee Objects

-(NSArray*)createEmployeeObjectsArray{
    
    //Reset the tempArray
    _tempArray = nil;
    _tempArray = [[NSMutableArray alloc] init];
    
    NSString* firstName;
    NSString* lastName;
    
    //loop through the jsonResponse array, create a new Employee object, and add it to the NSMutableArray
    for(NSDictionary* dictionary in _results)
    {
        //Iterate through the dictionary and grab all of the values associated with each key
        //We can't assume which order the keys will be in the dictionary, so double check
        for(id key in dictionary)
        {
            if([key caseInsensitiveCompare:@"Department"] == NSOrderedSame) {
                _department = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"EmployeeAnnualSalary"] == NSOrderedSame) {
                _annualSalary = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"PositionTitle"] == NSOrderedSame) {
                _jobPosition = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"FirstName"] == NSOrderedSame) {
                firstName = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"LastName"] == NSOrderedSame) {
                lastName = [dictionary objectForKey:key];
                
                //Concatenate the names:
                _name = [NSString stringWithFormat:@"%@,  %@", lastName, firstName];
                
            }
            
        }//end of inner for loop
        
        //Make the object
        _employee = [[EmployeeObject alloc] initWithValues:_name aPosition:_jobPosition aDepartment:_department aSalary:_annualSalary];
        
        //For debugging purposes
//        NSLog(@"%@", [_employee name]);
//        NSLog(@"Department: %@", [_employee department]);
//        NSLog(@"Job Position: %@", [_employee jobPosition]);
//        NSLog(@"Annual Salary: %@", [_employee annualSalary]);
        
        
        //Add the object to the mutable array
        [_tempArray addObject:_employee];
        
        
    }
    
    //Sort the Array alphabetically by name and by department
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor *departmentDescriptor = [[NSSortDescriptor alloc] initWithKey:@"department" ascending:YES];
    NSArray *descriptors = @[nameDescriptor, departmentDescriptor];
    NSArray* returnArray = [_tempArray sortedArrayUsingDescriptors:descriptors];
    
    //For Debugging purposes
//    for(EmployeeObject* employee in returnArray)
//    {
//        NSLog(@"Name:%@", [employee name]);
//        NSLog(@"Department: %@", [employee department]);
//        NSLog(@"Job Position: %@", [employee jobPosition]);
//        NSLog(@"Annual Salary: %@", [employee annualSalary]);
//        
//    }
    
    
    
    //Return the NSMutableArray as an immutable NSArray
    return returnArray;

}


/** @brief: This method will query the database based on user input for employee name and department
    @param: (NSString*) name: Can be nil or blank
    @param: (NSString*) department: Can be nil or blank
 
    @return: Returns an NSArray of EmployeeObject
 
 */
- (NSArray*)getEmployees:(NSString*)name department:(NSString*)department{
    
    
    //TODO: Fix all of the if statements to have the correct queries
    
    
    if([name length] > 0 && [department length] > 0) {
        
        //TODO: Fix this
        
        _results = nil;
        
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
            _query = [NSString stringWithFormat:@"SELECT* FROM Employees WHERE Department= '%@' AND FirstName LIKE '%%%@%%' AND LastName LIKE '%%%@%%'",department, firstName, lastName];
        }
        
        //_query = [NSString stringWithFormat:@"SELECT* FROM Employees WHERE Department= '%@' ",department];
        
        
        
        //Grab the results from the database based on the query
        _results = [[NSArray alloc] initWithArray:[_dt loadDataFromDB:_query]];
    }
    else if([name length] > 0){
        
        //FIX THIS
        
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
            _query = [NSString stringWithFormat:@"SELECT* FROM Employees WHERE FirstName LIKE '%%%@%%' AND LastName='%@';",firstName, lastName];
//            NSLog(@"First Name: %@",firstName);
//            NSLog(@"Last Name: %@", lastName);
//            NSLog(_query);
        }
        
        //Grab the results from the database based on the query
        _results = [[NSArray alloc] initWithArray:[_dt loadDataFromDB:_query]];
        
    }
    else if([department length] > 0){
        
        //FIX THIS
        
        //Use NSDictionary to get the proper department name
        NSString *departmentQuery = [_departmentsWithCorrectSpelling objectForKey:department];
        
        //Replace any ampersands
        NSString *finalQuery = [departmentQuery stringByReplacingOccurrencesOfString:@"&" withString:@"AND&"];
        
        
        _query = [NSString stringWithFormat:@"department=%@", finalQuery];
        
    }
    else{
        NSLog(@"Something went wrong");
        return nil;
    }
    

    return [self createEmployeeObjectsArray];
}

-(NSArray*)getEmployeesBySalary: (NSString*) minSalary maximumRange: (NSString*) maxSalary{
    
    _query = [NSString stringWithFormat:@"$where=employee_annual_salary>=%@ AND employee_annual_salary<=%@", minSalary,maxSalary];
    
    
    return [self createEmployeeObjectsArray];
}



@end
