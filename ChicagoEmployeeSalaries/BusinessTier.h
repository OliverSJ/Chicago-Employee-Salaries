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

//Used by the front end to set the name and department
@property NSString* name;
@property NSString* department;


- (NSArray*)getEmployees;
-(NSArray*)getEmployeesBySalary:(NSString*) minSalary maximumRange: (NSString*) maxSalary;
- (NSArray*)getDepartments;


@property BOOL nameSearch;
@property BOOL departmentSearch;
@property BOOL nameAndDepartmentSearch;
@property BOOL salarySearch;

@property NSInteger searchType;





@end
