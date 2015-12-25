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
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // search by button in text field
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [app.keyboards.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    /****************************************************************************************
     TEST FOR LOWER CASE USER INPUT
     ****************************************************************************************/
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // select name field and type name with lower case
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [app.buttons[@"Clear text"] tap];
    [iERahmEmanuelTextField typeText:@"rahm emanuel"];
    
    // search
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
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
    
    // touch toolbar search
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
    
    /****************************************************************************************
     TEST ALL SEARCH BUTTONS WITH PERFECT INPUT
     ****************************************************************************************/
    
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
    
    // select mayors office from picker wheel
    [app.pickerWheels[@"(Leave Blank)"] tap];
    [app.pickers.pickerWheels.element adjustToPickerWheelValue:@"MAYOR'S OFFICE"];
    
    // use toolbar to search
    [toolbarsQuery.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // tap search button
    [[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"NameAndDepartmentView"].buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    /****************************************************************************************
     TEST WITH LOWERCASE INPUT
     ****************************************************************************************/
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // select name field and type name with lower case
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [app.buttons[@"Clear text"] tap];
    [iERahmEmanuelTextField typeText:@"rahm emanuel"];
    
    // tap search button
    [[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"NameAndDepartmentView"].buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    /****************************************************************************************
     TEST WITH PARTIAL AND LOWERCASE INPUT
     ****************************************************************************************/
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // select name field and type name with lower case
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [app.buttons[@"Clear text"] tap];
    [iERahmEmanuelTextField typeText:@"rahm"];
    
    // tap search button
    [[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"NameAndDepartmentView"].buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
}

- (void) testSearchByPosition {
    
    /****************************************************************************************
     TEST ALL SEARCH BUTTONS WITH PERFECT INPUT
     ****************************************************************************************/
    
    // select search by position
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables.staticTexts[@"Postition"] tap];
    
    // select text field and enter rahm emanuel
    XCUIElement *iEMayorTextField = app.textFields[@"i.e. MAYOR"];
    [iEMayorTextField tap];
    [iEMayorTextField typeText:@"MAYOR"];
    
    // search by button
    [[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"PositionView"].buttons[@"Search"] tap];
    
    // select rahm from results
    [app.tables.staticTexts[@"EMANUEL,  RAHM"] tap];

    // navigate back
    XCUIElement *backButton2 = [[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0];
    [backButton2 tap];
    XCUIElement *backButton = [[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0];
    [backButton tap];

    // search by button in toolbar
    [iEMayorTextField tap];
    [app.toolbars.buttons[@"Search"] tap];
    
    // select rahm from results
    [app.tables.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    // navigate back
    [backButton2 tap];
    [backButton tap];
    
    // search by button in text field
    [iEMayorTextField tap];
    [app.keyboards.buttons[@"Search"] tap];
    
    // select rahm from results
    [app.tables.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    /****************************************************************************************
     TEST WITH LOWERCASE USER INPUT
     ****************************************************************************************/
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // select name field and type name with lower case
    [app.textFields[@"i.e. MAYOR"] tap];
    [app.buttons[@"Clear text"] tap];
    [iEMayorTextField typeText:@"mayor"];
    
    // tap search button
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [app.tables.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    /****************************************************************************************
     TEST WITH PARTIAL AND LOWERCASE INPUT
     ****************************************************************************************/
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // select name field and type name with lower case
    [app.textFields[@"i.e. MAYOR"] tap];
    [app.buttons[@"Clear text"] tap];
    [iEMayorTextField typeText:@"may"];
    
    // tap search button
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [app.tables.staticTexts[@"EMANUEL,  RAHM"] tap];

}

- (void) testSearchByPositionAndDeparment {
    
    /****************************************************************************************
     TEST ALL SEARCH BUTTONS WITH PERFECT INPUT
     ****************************************************************************************/
    
    // select search by position and department
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables.staticTexts[@"Position and Department"] tap];
    
    // enter mayor for position
    XCUIElement *iEMayorTextField = app.textFields[@"i.e. MAYOR"];
    [iEMayorTextField tap];
    [iEMayorTextField typeText:@"MAYOR"];
    
    // use next icon and select mayors office from pickerwheel
    XCUIElementQuery *toolbarsQuery = app.toolbars;
    [toolbarsQuery.buttons[@"NextIcon"] tap];
    [app.pickerWheels[@"(Leave Blank)"] tap];
    [app.pickers.pickerWheels.element adjustToPickerWheelValue:@"MAYOR'S OFFICE"];
    
    // touch search button
    XCUIElement *searchButton = [app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"PositionAndDepartmentResultsView"].buttons[@"Search"];
    [searchButton tap];
    
    // select rahm from results
    [app.tables.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    // navigate back
    XCUIElement *backButton = [[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0];
    [backButton tap];
    [backButton tap];
    
    // search by toolbar
    XCUIElement *iEMayorSOfficeTextField = app.textFields[@"i.e. MAYOR'S OFFICE"];
    [iEMayorSOfficeTextField tap];
    [toolbarsQuery.buttons[@"Search"] tap];
    
    // select rahm from results
    [app.tables.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    /****************************************************************************************
     TEST WITH LOWERCASE USER INPUT
     ****************************************************************************************/
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // select name field and type name with lower case
    [app.textFields[@"i.e. MAYOR"] tap];
    [app.buttons[@"Clear text"] tap];
    [iEMayorTextField typeText:@"mayor"];
    
    // tap search button
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [app.tables.staticTexts[@"EMANUEL,  RAHM"] tap];
    
    /****************************************************************************************
     TEST WITH PARTIAL AND LOWERCASE INPUT
     ****************************************************************************************/
    
    // navigate back to search window
    [[[[app.navigationBars[@"EmployeeTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // select name field and type name with lower case
    [app.textFields[@"i.e. MAYOR"] tap];
    [app.buttons[@"Clear text"] tap];
    [iEMayorTextField typeText:@"may"];
    
    // tap search button
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [app.tables.staticTexts[@"EMANUEL,  RAHM"] tap];

}

- (void) testSearchBySalaryAndDeparment {
    
}

- (void) testSearchBySalaryAndPosition {
    
}

@end
