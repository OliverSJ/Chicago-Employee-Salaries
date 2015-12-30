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


@property NSString* name;
@property NSString* department;
@property NSString* minSalary;
@property NSString* maxSalary;
@property NSString* positionTitle;

/**
    @brief This method will query the database based on user input for employee name and department
    @param name: Can be nil or blank
    @param department: Can be nil or blank
 
    @return Returns an NSArray of EmployeeObject
 
 */
- (NSArray*)getEmployees;

/**
    @brief This method returns the list of departments with correct spelling
    @return NSArray of Strings
 
 */
- (NSArray*)getDepartments;


/** @brief Variable set by the front end to tell the back end what query should be made*/
@property searchType searchType;





@end
