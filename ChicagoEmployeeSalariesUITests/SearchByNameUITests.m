//
//  SearchByNameUITests.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/25/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SearchByNameUITests : XCTestCase

@end

@implementation SearchByNameUITests

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

- (void) testAllSearchButtons {
    
    // select search by name
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name"] tap];
    
    // enter name
    XCUIElement *textField = app.textFields[@"i.e. RAHM EMANUEL"];
    [textField tap];
    [textField typeText:@"RAHM EMANUEL"];
    
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
    
}

- (void) testFirstName {
    
    // select search by name
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name"] tap];
    
    // enter name
    XCUIElement *textField = app.textFields[@"i.e. RAHM EMANUEL"];
    
    // select name field and type name
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [textField typeText:@"RAHM"];
    
    // search
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
}

- (void) testFirstNameLower {
    
    // select search by name
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name"] tap];
    
    // enter name
    XCUIElement *textField = app.textFields[@"i.e. RAHM EMANUEL"];
    
    // select name field and type name with lower case
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [textField typeText:@"rahm"];
    
    // search
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
}

- (void) testLastName {
    
    // select search by name
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name"] tap];
    
    // enter name
    XCUIElement *textField = app.textFields[@"i.e. RAHM EMANUEL"];
    
    // select name field and type name
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [textField typeText:@"EMANUEL"];
    
    // search
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
}

- (void) testLastNameLower {
    
    // select search by name
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name"] tap];
    
    // enter name
    XCUIElement *textField = app.textFields[@"i.e. RAHM EMANUEL"];
    
    // select name field and type name with lower case
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [textField typeText:@"emanuel"];
    
    // search
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
}

- (void) testFirstAndLastName {
    
    // select search by name
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name"] tap];
    
    // enter name
    XCUIElement *textField = app.textFields[@"i.e. RAHM EMANUEL"];
    
    // select name field and type name
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [textField typeText:@"RAHM EMANUEL"];
    
    // search
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];

}

- (void) testFirstAndLastNameLower {
    
    // select search by name
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name"] tap];
    
    // enter name
    XCUIElement *textField = app.textFields[@"i.e. RAHM EMANUEL"];
    
    // select name field and type name with lower case
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [textField typeText:@"rahm emanuel"];
    
    // search
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"EMANUEL,  RAHM"] tap];
    
}

- (void) testFirstAndLastAndMiddleName {
    // select search by name
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name"] tap];
    
    // enter name
    XCUIElement *textField = app.textFields[@"i.e. RAHM EMANUEL"];
    
    // select name field and type name
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [textField typeText:@"CARLO E ZYRKOWSKI"];
    
    // search
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"ZYRKOWSKI, CARLO E"] tap];
}

- (void) testFirstAndLastAndMiddleNameLower {
    // select search by name
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name"] tap];
    
    // enter name
    XCUIElement *textField = app.textFields[@"i.e. RAHM EMANUEL"];
    
    // select name field and type name
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [textField typeText:@"carlo e zyrkowski"];
    
    // search
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"ZYRKOWSKI, CARLO E"] tap];
}

- (void) testNameWithApostrophe {
    
    // select search by name
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Name"] tap];
    
    // enter name
    XCUIElement *textField = app.textFields[@"i.e. RAHM EMANUEL"];
    
    // select name field and type name with lower case
    [app.textFields[@"i.e. RAHM EMANUEL"] tap];
    [textField typeText:@"D'VONNA COBB"];
    
    // search
    [app.toolbars.buttons[@"Search"] tap];
    
    // view employee details
    [tablesQuery.staticTexts[@"COBB, D'VONNA C"] tap];
}

@end
