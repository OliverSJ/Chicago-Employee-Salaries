//
//  GetDepartmentsTests.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/27/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BusinessTier.h"
#define NUM_DEPARTMENTS 36 // received directly from query in terminal

@interface GetDepartmentsTests : XCTestCase

@property BusinessTier *businessTier;

@end

@implementation GetDepartmentsTests

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

@end
