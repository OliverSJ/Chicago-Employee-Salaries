//
//  BusinessTierRules.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/17/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BusinessTierRules

// serach by name only
- (NSArray*)getEmployeesByName:(NSString*)name;

// search by department only
- (NSArray*)getEmployeesByDepartment:(NSString*)department;

// search by name and department
- (NSArray*)getEmployeesByNameAndDepartment:(NSString*)name department:(NSString*)department;

// get array of current departments
- (NSArray*)getDepartments;

@end