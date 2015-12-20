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

//Class constructor
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
        
        _name = nil;
        
        _department = nil;
        
        _annualSalary = nil;
        
        _position = nil;
        
        _employee = nil;
        
        //Create the departmentsWithCorrectSpelling.  This is so that the department names look good on the GUI
        _query = @"$select=department&$group=department";
        
        _jsonResponse = [_dt executeQuery: _query];
        
        
        //_departForBackEnd = [_jsonResponse valueForKey:@"department"];
        
        
        //WORKS, but testing a different method
        //NSMutableArray* tempArray = [[NSMutableArray alloc]init];
        //tempArray = [_jsonResponse valueForKey:@"department"];
        
        NSMutableArray* tempArray = [[NSMutableArray alloc] initWithArray:[_jsonResponse valueForKey:@"department"]];
        
        
        NSLog(NSStringFromClass([tempArray class]));
        
        //The last object is nil.  Move it to the front so that the object will match up with an appropriate key
        //In this case, nil will match up with "(Leave Blank)"
        int size = ([tempArray count]-1);
        [tempArray removeObjectAtIndex: 35];
        [tempArray insertObject:@"(Leave Blank)" atIndex:0];
        
        
        _departForBackEnd = [NSArray arrayWithArray:tempArray];
        
        //Reset the tempArray so that it can be reused for the _departForFrontEnd
        tempArray = nil;
        tempArray =[[NSMutableArray alloc]init];
        
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
                
                //NSLog(@"%@", tempString);
            }//end of outer if statement

        }//end of for loop
        
        _departForFrontEnd = [NSArray arrayWithArray:tempArray];
        
        //For Debugging purposes only
//        NSLog(@"%lu", (unsigned long)[_departForFrontEnd count]);
//        NSLog(@"%lu", (unsigned long)[_departForBackEnd count]);
        
        //Create the NSDictionary
        _departmentsWithCorrectSpelling = [[NSDictionary alloc] initWithObjects:_departForBackEnd forKeys:_departForFrontEnd];
        
        //init query string to nil
        _query = nil;
        
        //init array to nil
        _jsonResponse = nil;

    }
    return self;
}


// search by name and department
- (NSArray*)getEmployees:(NSString*)name department:(NSString*)department{
    
    /*TODO:
     
     -Check to see what the GUI is giving me. Depending on the values, I'll then change the query
     
     
     */
    
    if([name length] > 0 && [department length] > 0) {
        
        _query = [NSString stringWithFormat:@"$where=name like '%%%@%%'&department=%@", name, department];
    }
    else if([name length] > 0){
        
        _query = [NSString stringWithFormat:@"$where=name like '%%%@%%'", name];
    }
    else if([department length] > 0){
        
        //Use NSDictionary to get the proper department name
        NSString *departmentQuery = [_departmentsWithCorrectSpelling objectForKey:department];
        
        _query = [NSString stringWithFormat:@"$where=department like '%%%@%%'", departmentQuery];
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
                _position = [dictionary objectForKey:key];
            }
            else {
                _name = [dictionary objectForKey:key];
            }
            
        }//end of for loop
        
        //Make the object
        _employee = [[EmployeeObject alloc] initWithValues:_name aPosition:_position aDepartment:_department aSalary:_annualSalary];
        
        //Add the object to the mutable array
        [_tempArray addObject:_employee];
        
       
    }
    
    //Return the NSMutableArray as an immutable NSArray
    return [NSArray arrayWithArray:_tempArray];
    
}

// get array of current departments
- (NSArray*)getDepartments{
    
    return _departForFrontEnd;

}

@end
