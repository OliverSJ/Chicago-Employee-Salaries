//
//  SearchByPositionTests.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/27/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BusinessTier.h"

@interface SearchByPositionTests : XCTestCase

@property BusinessTier *businessTier;

@end

@implementation SearchByPositionTests

- (void)setUp {
    [super setUp];
    
    self.businessTier = [[BusinessTier alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPosition {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.positionTitle = @"MAYOR";
    self.businessTier.searchType = searchByPosition;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testPositionLower {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.positionTitle = @"mayor";
    self.businessTier.searchType = searchByPosition;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testPositionPartial {
    
    NSString *name = @"EMANUEL,  RAHM";
    self.businessTier.positionTitle = @"M";
    self.businessTier.searchType = searchByPosition;
    
    NSArray *employees = [self.businessTier getEmployees];
    
    for (EmployeeObject *emp in employees) {
        if ([emp.name isEqualToString:name]) {
            XCTAssertTrue(YES, "Object found with name match");
            return;
        }
    }
    
    XCTAssertTrue(NO, "Expected object with name match");
}

- (void)testPositionApostrophe {
    
    NSString *name = @"DILLON,  EOIN S";
    self.businessTier.positionTitle = @"STUDENT INTERN - MAYOR'S FELLOWS";
    self.businessTier.searchType = searchByPosition;
    
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
