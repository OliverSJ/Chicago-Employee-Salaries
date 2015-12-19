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
        
        
        _departForBackEnd = [_jsonResponse valueForKey:@"department"];
        
        _departForFrontEnd = @[@"Admin Hearing", @"Animal Control",
                               @"Aviation", @"Board of Elections",
                               @"Board of Ethics", @"Budget and Management",
                               @"Buildings", @"Business Affairs",
                               @"City Clerk", @"City Council",
                               @"Community Development", @"Cultural Affairs",
                               @"Disabilities", @"DoIT",
                               @"Family and Support", @"Finance",
                               @"Fire",@"General Services",
                               @"Health",@"Human Relations",
                               @"Human Resources", @"Inspector General",
                               @"IPRA",@"Law",
                               @"License Appl Comm",@"Mayor's Office",
                               @"OEMC",@"Police",
                               @"Police Board",@"Procurement",
                               @"Public Library",@"Streets and Sanitation",
                               @"Transportation",@"Treasurer",
                               @"Water Management"];
        
        
        //init query string to nil
        _query = nil;
        
        //init array to nil
        _jsonResponse = nil;

    }
    return self;
}


// serach by name only
- (NSArray*)getEmployeesByName:(NSString*)name {
    
    //TODO
    
    //FIX THIS:
    return _jsonResponse;
}

// search by department only
- (NSArray*)getEmployeesByDepartment:(NSString*)department{
    
    //TODO
    
    //FIX THIS:
    return _jsonResponse;
    
}
 
 

// search by name and department
- (NSArray*)getEmployeesByNameAndDepartment:(NSString*)name department:(NSString*)department{
    
    _query = [NSString stringWithFormat:@"$where=name like '%%%@%%'&department=%@", name, department];
    
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
 
    /*
    _query= nil;
    _query = @"$select=department&$group=department";
    
    _jsonResponse = [_dt executeQuery: _query];
    
    NSArray* returnArray = [_jsonResponse valueForKey:@"department"];
    
    //Iterate through returnArray, ensuring that only the first letter of each word is capitalized.
    
    return returnArray;
     
     */
    
    return _departForFrontEnd;

}

@end
