//
//  DepartmentViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/23/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "PositionAndDepartmentResultsViewController.h"
#import "BusinessTier.h"
#import "EmployeesTableViewController.h"
#import "PrevNextSearchToolbarView.h"

@interface PositionAndDepartmentResultsViewController ()

@property (strong, nonatomic) BusinessTier *bt;

@end

@implementation PositionAndDepartmentResultsViewController

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EmployeesTableViewController *etvc = [segue destinationViewController];
    self.bt.positionTitle = self.textField.text;
    self.bt.department = self.textFieldTwo.text;
    self.bt.searchType = searchByPositionAndDepartment;
    etvc.currentBT = self.bt;
}

- (void)initDataTier {
    
    self.bt = [[BusinessTier alloc]init];
}

- (void)configureView {
    
    [self initDataTier];
    
    self.segueID = @"PositionAndDepartmentResults";
    self.label.text = @"Enter a Position";
    self.labelTwo.text = @"Select a Department";
    self.textField.placeholder = @"i.e. MAYOR";
    self.textFieldTwo.placeholder = @"i.e. MAYOR'S OFFICE";
    self.backgroundImageName = @"chicago_8.png";
    self.pickerViewContents = [self.bt getDepartments];
    
    [super addPickerView:self.textFieldTwo]; // add picker view to the second text field
    [super addToolbars]; // add toolbars to both text fields
    [super configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self initDataTier];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
