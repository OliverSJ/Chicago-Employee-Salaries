//
//  BusinessTierRules.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/17/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BusinessTierRules

typedef NS_ENUM(NSInteger, searchType){
    
    searchByName = 0,
    searchByDepartment,
    searchByNameAndDepartment,
    searchBySalary,
    searchBySalaryAndDepartment,
    searchBySalaryAndPosition,
    searchByPosition,
    searchByPositionAndDepartment
    
};

//Get list of employees.
- (NSArray*)getEmployees;

// get array of current departments
- (NSArray*)getDepartments;

@end