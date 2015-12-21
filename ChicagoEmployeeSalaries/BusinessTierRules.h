//
//  BusinessTierRules.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/17/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BusinessTierRules



//Get list of employees.
- (NSArray*)getEmployees:(NSString*)name department:(NSString*)department;

// get array of current departments
- (NSArray*)getDepartments;

@end