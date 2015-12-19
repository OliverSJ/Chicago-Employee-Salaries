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
    
    //Create GUI objects here
    
    //They will have to be added to the NSMutableArray, which will then be returned.
    
    //Make an NSArray equal to NSMutableArray
    
    //FIX THIS:
    return _jsonResponse;
    
}

// get array of current departments
- (NSArray*)getDepartments{
    
    //FIX THIS:
    return _jsonResponse;
}

@end
