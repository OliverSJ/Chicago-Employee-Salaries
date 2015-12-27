//
//  SearchByDepartmentTests.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/27/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BusinessTier.h"

@interface SearchByDepartmentTests : XCTestCase

@property BusinessTier *businessTier;

@end

@implementation SearchByDepartmentTests

- (void)setUp {
    [super setUp];
    
    self.businessTier = [[BusinessTier alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDepartment {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.department = @"MAYOR'S OFFICE";
    self.businessTier.searchType = searchByDepartment;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
    
}

@end
