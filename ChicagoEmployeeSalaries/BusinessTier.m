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
    
    //Variables to create the dictionary that will communicate  between the front end and the back end
    NSDictionary* departmentsWithCorrectSpelling;
    NSArray* departForBackEnd;
    NSArray* departForFrontEnd;
    
    //Class variables that will be reused for different queries
    long minimumSalary;
    long maximumSalary;
    NSString* firstNameForParsing;
    NSString* lastNameForParsing;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // init dataTier with base url for sqlite database
        dt = [[DataTier alloc] initWithDatabaseFilename:@"chicago_employee_salaries_2015_db.sql"];
        
        //Set public variables that are reused to nil
        _name = nil;
        _department = nil;
        _minSalary = nil;
        _maxSalary = nil;
        _positionTitle = nil;
        
        departmentQuery = nil;
                
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
        
        /*    
            The Chicago database misspells some department names (see below for examples).
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

-(void)convertSalariesForQuery{
    
    minimumSalary = [_minSalary integerValue];
    maximumSalary = [_maxSalary integerValue];
    
}

-(void)parseName{
    
    //Convert string to all uppercase
    _name = [_name uppercaseString];
    _name = [_name stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    
    //Split the name up by spaces
    NSArray* nameArray = [_name componentsSeparatedByString:@" "];
    
    firstNameForParsing = nameArray[0];
    
    if([nameArray count] == 2){
      
        lastNameForParsing = nameArray[1];
    }
    else if([nameArray count] == 3){
        
        //Combine the first and middle names together
        firstNameForParsing = [NSString stringWithFormat:@"%@ %@", firstNameForParsing, nameArray[1]];
        
        lastNameForParsing = nameArray[2];
    }

    
}

-(void) preparePositionTitleForQuery{
    
    //Convert any lower case characters to uppercase
    _positionTitle = [_positionTitle uppercaseString];
    
    //Convert single apostrophes to double apostrophes for the sqlite query
    _positionTitle = [_positionTitle stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    
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
                annualSalary = [NSString stringWithFormat:@"%@",[dictionary objectForKey:key]];
            }
            else if([key caseInsensitiveCompare:@"PositionTitle"] == NSOrderedSame) {
                jobPosition = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"FirstName"] == NSOrderedSame) {
                firstName = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"LastName"] == NSOrderedSame) {
                lastName = [dictionary objectForKey:key];
                
            }
            
        }//end of inner for loop
        
        //Concatenate the names:
        nameForObject = [NSString stringWithFormat:@"%@,  %@", lastName, firstName];
        
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

- (NSArray*)getEmployees{
    
    
    if(_searchType == searchByNameAndDepartment){
        
        results = nil;
        
        //Get the appropriate department name
        //This method will change the class variable departmentQuery
        [self createDepartmentQuery:_department];
        
        //Parse the names provided
        [self parseName];
        
        //Query the database based on user input
        if([firstNameForParsing length] > 0 && [lastNameForParsing length] > 0)
        {
            query = [NSString stringWithFormat:@"SELECT * FROM Employees WHERE Department= '%@' AND FirstName LIKE '%%%@%%' AND LastName LIKE '%%%@%%';",departmentQuery, firstNameForParsing, lastNameForParsing];
        }
        //Query the database with the "first" name acting as both the first and last names in order to get
        // a more complete list
        else
        {
            query = [NSString stringWithFormat:@"SELECT * FROM Employees WHERE Department= '%@' AND (FirstName LIKE '%%%@%%' OR LastName LIKE '%%%@%%');",departmentQuery, firstNameForParsing, firstNameForParsing];
        }
        
        
    }
    else if(_searchType == searchByName){
        
        //Parse the names provided
        [self parseName];
        
        //Query the database based on user input
        if([firstNameForParsing length] > 0 && [lastNameForParsing length] > 0)
        {
            query = [NSString stringWithFormat:@"SELECT* FROM Employees WHERE FirstName LIKE '%%%@%%' AND LastName LIKE'%%%@%%';",firstNameForParsing, lastNameForParsing];

        }
        //Query the database with the "first" name acting as both the first and last names in order to get
        // a more complete list
        else
        {
            query = [NSString stringWithFormat:@"SELECT* FROM Employees WHERE FirstName LIKE '%%%@%%' OR LastName LIKE '%%%@%%';",firstNameForParsing, firstNameForParsing];
        }
        
        
    }
    else if(_searchType == searchByDepartment)
    {
        
       //Create the appropriate department query
        [self createDepartmentQuery:_department];
        
        query = [NSString stringWithFormat:@"SELECT * FROM Employees WHERE Department='%@';", departmentQuery];
        
        
    }
    else if(_searchType == searchBySalary){
        
        //Convert the salaries to an integer
        [self convertSalariesForQuery];
        
        query = [NSString stringWithFormat:@"SELECT * FROM Employees WHERE EmployeeAnnualSalary>=%li AND EmployeeAnnualSalary<=%li;",minimumSalary, maximumSalary];
        
    }
    else if(_searchType == searchBySalaryAndDepartment){
        
        //Convert the salaries to an integer
        [self convertSalariesForQuery];
        
        //Create the appropriate department query
        [self createDepartmentQuery:_department];
        
        query = [NSString stringWithFormat:@"SELECT * FROM Employees WHERE Department='%@' AND EmployeeAnnualSalary>='%li' AND EmployeeAnnualSalary<='%li';", departmentQuery,minimumSalary,maximumSalary];
        
    }
    else if(_searchType == searchBySalaryAndPosition){
        
        //Convert the salaries to an integer
        [self convertSalariesForQuery];
        
        [self preparePositionTitleForQuery];
        
        query = [NSString stringWithFormat:@"SELECT * FROM Employees WHERE PositionTitle LIKE'%%%@%%' AND EmployeeAnnualSalary>='%li' AND EmployeeAnnualSalary<='%li';", _positionTitle,minimumSalary,maximumSalary];
        
    }
    else if(_searchType == searchByPosition){
        
        [self preparePositionTitleForQuery];
        
        query = [NSString stringWithFormat:@"SELECT * FROM Employees WHERE PositionTitle LIKE'%%%@%%';", _positionTitle];
    }
    else if(_searchType == searchByPositionAndDepartment){
        
        //Create the appropriate department query
        [self createDepartmentQuery:_department];
        
        [self preparePositionTitleForQuery];
        
        query = [NSString stringWithFormat:@"SELECT * FROM Employees WHERE PositionTitle LIKE'%%%@%%' AND Department='%@';", _positionTitle, departmentQuery];
    }
    
    else{
        NSLog(@"Something went wrong");
        return nil;
    }
    

    results = [[NSArray alloc] initWithArray:[dt loadDataFromDB:query]];
    
    return [self createEmployeeObjectsArray];
}


@end
