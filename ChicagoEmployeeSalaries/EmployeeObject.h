//
//  BusinessTierObjects.h
//  ChicagoEmployeeSalaries
//
//  Created by Oliver San Juan on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmployeeObject : NSObject

@property NSString* name;
@property NSString* position;
@property NSString* department;
@property NSString* annualSalary;

-(instancetype) initWithValues: (NSString*) name
                     aPosition: (NSString*) position
                    aDepartment: (NSString*) department
                       aSalary: (NSString*) annualSalary;

@end