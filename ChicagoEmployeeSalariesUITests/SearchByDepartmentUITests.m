//
//  SearchByDepartmentUITests.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/25/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SearchByDepartmentUITests : XCTestCase

@end

@implementation SearchByDepartmentUITests

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

- (void)testAllSearchButtons {
    // select search by department
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Department"] tap];
    
    // select department
    [app.textFields[@"i.e. MAYOR'S OFFICE"] tap];
    [app.pickers.pickerWheels[@"(Leave Blank)"] tap];
    [app.pickers.pickerWheels.element adjustToPickerWheelValue:@"MAYOR'S OFFICE"];
    
    // click search button
    [[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"DepartmentView"].buttons[@"Search"] tap];
    
    // navigate back
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // touch toolbar search
    [app.textFields[@"i.e. MAYOR'S OFFICE"] tap];
    [app.toolbars.buttons[@"Search"] tap];
}

- (void)testDepartment {
    
    // select search by department
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Department"] tap];
    
    // select department
    [app.textFields[@"i.e. MAYOR'S OFFICE"] tap];
    [app.pickers.pickerWheels[@"(Leave Blank)"] tap];
    [app.pickers.pickerWheels.element adjustToPickerWheelValue:@"MAYOR'S OFFICE"];
    
    // click search button
    [[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"DepartmentView"].buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
    
}


@end
