//
//  BusinessTierRules.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/17/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BusinessTierRules

// Specify the type of search performed by using this set of enums.
typedef NS_ENUM(NSInteger, SearchType)
{
    BTSearchByName,
    BTSearchByDepartment,
    BTSearchBySalary,
    BTSearchByPosition,
    BTSearchByNameAndDepartment,
    BTSearchByPositionAndDepartment,
    BTSearchBySalaryAndDepartment,
    BTSearchBySalaryAndPosition
    //add more search enums here..
};

// Get list of employees.
- (NSArray*)getEmployees;

// Get array of current departments
- (NSArray*)getDepartments;

@end