//
//  BusinessTier.h
//  ChicagoEmployeeSalaries
//
//  Created by Oliver San Juan on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessTierRules.h"
#import "DataTier.h"
#import "EmployeeObject.h"

@interface BusinessTier : NSObject <BusinessTierRules>

@property NSString* baseUrl;
@property DataTier* dt;
@property NSString* query;
@property NSArray *jsonResponse;
@property NSMutableArray *tempArray;

@property NSString* name;
@property NSString* department;
@property NSString* position;
@property NSString* annualSalary;

@property EmployeeObject* employee;
@property NSDictionary* departmentsWithCorrectSpelling;
@property NSArray* departForFrontEnd;
@property NSArray* departForBackEnd;

- (NSArray*)getEmployees:(NSString*)name department:(NSString*)department;
- (NSArray*)getDepartments;

@end
