//
//  ChicagoEmployeeSalariesTests.m
//  ChicagoEmployeeSalariesTests
//
//  Created by Oliver San Juan on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BusinessTier.h"

#define NUM_DEPARTMENTS 36 // received directly from query in terminal
@interface ChicagoEmployeeSalariesTests : XCTestCase

@property BusinessTier *businessTier;


@end

@implementation ChicagoEmployeeSalariesTests

- (void)setUp {
    [super setUp];
    
    self.businessTier = [[BusinessTier alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetDepartments {
    
    NSArray *departments = [self.businessTier getDepartments];
    XCTAssertEqual(departments.count-1, NUM_DEPARTMENTS); // subtract "(Leave Blank)" from count
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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
