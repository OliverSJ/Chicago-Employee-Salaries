//
//  BusinessTierObjects.m
//  ChicagoEmployeeSalaries
//
//  Created by Oliver San Juan on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "EmployeeObject.h"

@implementation EmployeeObject

- (instancetype)initWithValues: (NSString*) name
                     aPosition: (NSString*) position
                   aDepartment: (NSString*) department
                    aSalary: (NSString*) annualSalary
{
    self = [super init];
    if (self) {
        _name = name;
        _position = position;
        _department = department;
        _annualSalary = annualSalary;
        
    }
    return self;
}



@end
