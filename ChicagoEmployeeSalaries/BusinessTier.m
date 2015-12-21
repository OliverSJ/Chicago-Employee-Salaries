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
        
        // init base url
        _baseUrl = @"https://data.cityofchicago.org/resource/tt4n-kn4t.json?";
        
        // init json manager with base url for json database
        _dt = [[DataTier alloc]initWithBaseUrl:_baseUrl];
        
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
        _jsonResponse = [_dt executeQuery: _query];
        
        /** Store just the department strings in tempArray from _jsonResponse (which is an NSArray of NSDictionaries) */
        NSMutableArray* tempArray = [[NSMutableArray alloc] initWithArray:[_jsonResponse valueForKey:@"department"]];
        
        
        //The last object is nil.  Move it to the front so that the object will match up with an appropriate key
        //In this case, nil will match up with "(Leave Blank)"
        int size = ([tempArray count]-1);
        [tempArray removeObjectAtIndex: size];
        [tempArray insertObject:@"(Leave Blank)" atIndex:0];
        
        
        _departForBackEnd = [NSArray arrayWithArray:tempArray];
        
        //Reset the tempArray so that it can be reused for the _departForFrontEnd
        tempArray = nil;
        tempArray =[[NSMutableArray alloc]init];
        
        /* @discussion: The Chicago database misspells some department names (see below for examples).  
                        Directly using the names in the database for the front end would look bad, so
                        I identified the misspelled names and replaced them in the NSDictionary
         
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
        
        _departForFrontEnd = [NSArray arrayWithArray:tempArray];
        
        //Create the NSDictionary
        _departmentsWithCorrectSpelling = [[NSDictionary alloc] initWithObjects:_departForBackEnd forKeys:_departForFrontEnd];
        
        //init query string to nil
        _query = nil;
        
        //init array to nil
        _jsonResponse = nil;

    }
    return self;
}

-(NSString*)parseName:(NSString *)name{
    
    NSString* fullName;
    NSString* firstName = [name componentsSeparatedByString:@" "][0];
    NSString* lastName;
    
    @try{
        
        lastName = [name componentsSeparatedByString:@" "][1];
        
        fullName = [NSString stringWithFormat:@"%@,  %@", lastName, firstName];
        
    }
    @catch(NSException *exception){
        
        lastName = nil;
        
        fullName = firstName;
    }
    
    return fullName;
    
}


/** @brief: This method will query the database based on user input for employee name and department
    @param: (NSString*) name: Can be nil or blank
    @param: (NSString*) department: Can be nil or blank
 
    @return: Returns an NSArray of EmployeeObject
 
 */
- (NSArray*)getEmployees:(NSString*)name department:(NSString*)department{
    
    
    if([name length] > 0 && [department length] > 0) {
        
        name = [self parseName:name];
        
        _query = [NSString stringWithFormat:@"$where=name like '%%%@%%'&department=%@", name, department];
    }
    else if([name length] > 0){
        
        name = [self parseName:name];
        
        _query = [NSString stringWithFormat:@"$where=name like '%%%@%%'", name];
        
    }
    else if([department length] > 0){
        
        //Use NSDictionary to get the proper department name
        NSString *departmentQuery = [_departmentsWithCorrectSpelling objectForKey:department];
        
        //Replace any ampersands
        NSString *finalQuery = [departmentQuery stringByReplacingOccurrencesOfString:@"&" withString:@"AND&"];
        
        
        //_query = [NSString stringWithFormat:@"$where=department like '%%%@%%'", departmentQuery];
        _query = [NSString stringWithFormat:@"department=%@", finalQuery];
        
    }
    else{
        NSLog(@"Something went wrong");
        return nil;
    }
    
    
    _jsonResponse = [_dt executeQuery: _query];
    
    //Reset the tempArray
    _tempArray = nil;
    _tempArray = [[NSMutableArray alloc] init];
    
    //loop through the jsonResponse array, create a new Employee object, and add it to the NSMutableArray
    for(NSDictionary* dictionary in _jsonResponse)
    {
        //Iterate through the dictionary and grab all of the values associated with each key
        //We can't assume which order the keys will be in the dictionary, so double check
        for(id key in dictionary)
        {
            if([key caseInsensitiveCompare:@"department"] == NSOrderedSame) {
                _department = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"employee_annual_salary"] == NSOrderedSame) {
                _annualSalary = [dictionary objectForKey:key];
            }
            else if([key caseInsensitiveCompare:@"job_titles"] == NSOrderedSame) {
                _jobPosition = [dictionary objectForKey:key];
            }
            else {
                _name = [dictionary objectForKey:key];
            }
            
        }//end of for loop
        
        //Make the object
        _employee = [[EmployeeObject alloc] initWithValues:_name aPosition:_jobPosition aDepartment:_department aSalary:_annualSalary];
        
        //Add the object to the mutable array
        [_tempArray addObject:_employee];
        
       
    }
    
    //Sort the Array alphabetically by name and by department
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor *departmentDescriptor = [[NSSortDescriptor alloc] initWithKey:@"department" ascending:YES];
    NSArray *descriptors = @[nameDescriptor, departmentDescriptor];
    NSArray* returnArray = [_tempArray sortedArrayUsingDescriptors:descriptors];
    
    
    //Return the NSMutableArray as an immutable NSArray
    return returnArray;
    
}

/** @brief: This method returns the list of departments with correct spelling*/
- (NSArray*)getDepartments{
    
    return _departForFrontEnd;

}



@end
