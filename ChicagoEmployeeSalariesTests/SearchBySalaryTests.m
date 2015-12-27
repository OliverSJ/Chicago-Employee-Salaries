//
//  SearchBySalaryTests.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/27/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BusinessTier.h"

@interface SearchBySalaryTests : XCTestCase

@property BusinessTier *businessTier;

@end

@implementation SearchBySalaryTests

- (void)setUp {
    [super setUp];
    
    self.businessTier = [[BusinessTier alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSalary {
    
    self.businessTier.maxSalary = @"250000";
    self.businessTier.minSalary = @"200000";
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.searchType = searchBySalary;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES);
            return;
        }
    }
    
    // no object found with correct name
    XCTAssertTrue(NO, "No employee object found");
}

- (void)testSalaryReversedBounds {
    
    self.businessTier.maxSalary = @"200000";
    self.businessTier.minSalary = @"250000";
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.searchType = searchBySalary;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES);
            return;
        }
    }
    
    // no object found with correct name
    XCTAssertTrue(NO, "No employee object found");
}

@end
