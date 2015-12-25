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

- (void) testSearchByName {
    
    // select search by name
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name"] tap];
    
    // enter name
    XCUIElement *iERahmEmanuelTextField = app.textFields[@"i.e. RAHM EMANUEL"];
    [iERahmEmanuelTextField tap];
    [iERahmEmanuelTextField typeText:@"RAHM EMANUEL"];
    
    // click search button
    [[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"NameView"].buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // search by clicking toolbar search
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [app.tables.staticTexts[@"MAYOR'S OFFICE"] tap];
    
}

- (void) testSearchByDepartment {
    
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
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // search by clicking toolbar search
    [app.textFields[@"i.e. MAYOR'S OFFICE"] tap];
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
    
}

- (void) testSearchBySalary {
    
    // select search by salary
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Salary"] tap];
    
    // select min salary
    XCUIElement *iE100000TextField = app.textFields[@"i.e. 100000"];
    [iE100000TextField tap];
    [iE100000TextField typeText:@"10000"];
    
    // press next icon in toolbar
    XCUIElementQuery *toolbarsQuery = app.toolbars;
    [toolbarsQuery.buttons[@"NextIcon"] tap];
    
    // enter salary into max salary
    XCUIElement *iE120000TextField = app.textFields[@"i.e. 120000"];
    [iE120000TextField typeText:@"20000"];
    
    // press search button
    [[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"SalaryView"].buttons[@"Search"] tap];
    
    // select first result
    XCUIElement *abdullahLakenyaNStaticText = tablesQuery.staticTexts[@"ABDULLAH,  LAKENYA N"];
    [abdullahLakenyaNStaticText tap];
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // search using toolbar
    [iE120000TextField tap];
    [toolbarsQuery.buttons[@"Search"] tap];
    
    // view employee details again
    [abdullahLakenyaNStaticText tap];
    
}
- (void) testSearchByNameAndDepartment {
    
    // select search by name and department
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name and Department"] tap];
    
    // type in name
    XCUIElement *iERahmEmanuelTextField = app.textFields[@"i.e. RAHM EMANUEL"];
    [iERahmEmanuelTextField tap];
    [iERahmEmanuelTextField typeText:@"RAHM EMANUEL"];
    
    // use next toolbar button to select department
    XCUIElementQuery *toolbarsQuery = app.toolbars;
    [toolbarsQuery.buttons[@"NextIcon"] tap];
    [app.pickerWheels[@"(Leave Blank)"] tap];
    [app.pickers.pickerWheels.element adjustToPickerWheelValue:@"MAYOR'S OFFICE"];
    
    // use toolbar to search
    [toolbarsQuery.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // click search button
    [[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"NameAndDepartmentView"].buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];

    
}

- (void) testSearchByPosition {

}

- (void) testSearchByPositionAndDeparment {
    
}

- (void) testSearchBySalaryAndDeparment {
    
}

- (void) testSearchBySalaryAndPosition {
    
}

@end
