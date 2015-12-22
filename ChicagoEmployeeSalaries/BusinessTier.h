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

/** Serves as the baseURL. The query will be concatenated at the end of this.*/
@property NSString* baseUrl;

/** This DataTier object will hold the methods used to execute the database queries.*/
@property DataTier* dt;

/** Class variable that is used to store the query string */
@property NSString* query;

@property NSArray *jsonResponse;
@property NSMutableArray *tempArray;

@property NSString* name;
@property NSString* department;
@property NSString* jobPosition;
@property NSString* annualSalary;

@property EmployeeObject* employee;
@property NSDictionary* departmentsWithCorrectSpelling;
@property NSArray* departForFrontEnd;
@property NSArray* departForBackEnd;

- (NSArray*)getEmployees:(NSString*)name department:(NSString*)department;
-(NSArray*)getEmployeesBySalary:(NSString*) minSalary maximumRange: (NSString*) maxSalary;
- (NSArray*)getDepartments;

@property BOOL nameSearch;
@property BOOL departmentSearch;
@property BOOL nameAndDepartmentSearch;
@property BOOL salarySearch;

-(NSString*)parseName: (NSString*) name;
-(NSArray*)createEmployeeObjectsArray;


@end
