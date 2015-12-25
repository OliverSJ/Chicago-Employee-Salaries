//
//  ChicagoEmployeeSalariesUITests.m
//  ChicagoEmployeeSalariesUITests
//
//  Created by Oliver San Juan on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DepartmentViewController.h"

@interface ChicagoEmployeeSalariesUITests : XCTestCase

@property DepartmentViewController* pickerViewContents;

@end

@implementation ChicagoEmployeeSalariesUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetDepartments {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables.staticTexts[@"Department"] tap];
    [app.textFields[@"i.e. MAYOR'S OFFICE"] tap];
    [app.pickers.pickerWheels[@"(Leave Blank)"] tap];
    
    
    
    
}

@end
