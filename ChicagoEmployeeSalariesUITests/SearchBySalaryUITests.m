//
//  SearchBySalary.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/25/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SearchBySalaryUITests : XCTestCase

@end

@implementation SearchBySalaryUITests

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
    [[[[app.navigationBars[@"EmployeesTableView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    // search using toolbar
    [iE120000TextField tap];
    [toolbarsQuery.buttons[@"Search"] tap];
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
}

@end
