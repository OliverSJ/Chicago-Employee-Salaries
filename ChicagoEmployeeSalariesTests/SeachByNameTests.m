//
//  seachByNameTests.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/27/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BusinessTier.h"

@interface SeachByNameTests : XCTestCase

@property BusinessTier *businessTier;

@end

@implementation SeachByNameTests

- (void)setUp {
    [super setUp];
    
    self.businessTier = [[BusinessTier alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFirstName {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.name = @"RAHM";
    self.businessTier.searchType = searchByName;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
    
}

- (void)testFirstNameLower {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.name = @"rahm";
    self.businessTier.searchType = searchByName;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testLastName {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.name = @"EMANUEL";
    self.businessTier.searchType = searchByName;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testLastNameLower {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.name = @"emanuel";
    self.businessTier.searchType = searchByName;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testFirstAndLastName {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.name = @"RAHM EMANUEL";
    self.businessTier.searchType = searchByName;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testFirstAndLastNameLower {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.name = @"rahm emanuel";
    self.businessTier.searchType = searchByName;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testFirstAndLastAndMiddleName {
    
    NSString *name = @"ZYRKOWSKI,  CARLO E";
    self.businessTier.name = @"CARLO E ZYRKOWSKI";
    self.businessTier.searchType = searchByName;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testFirstAndLastAndMiddleNameLower {
    
    NSString *name = @"ZYRKOWSKI,  CARLO E";
    self.businessTier.name = @"carlo e zyrkowski";
    self.businessTier.searchType = searchByName;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testNameWithApostrophe {
    
    NSString *name = @"COBB, D'VONNA C";
    self.businessTier.name = @"D'VONNA C COBB";
    self.businessTier.searchType = searchByName;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testPartialFirstName {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.name = @"R";
    self.businessTier.searchType = searchByName;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testPartialLastName {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.name = @"E";
    self.businessTier.searchType = searchByName;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
