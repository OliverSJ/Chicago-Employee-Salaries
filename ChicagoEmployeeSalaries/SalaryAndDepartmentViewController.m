//
//  SalaryAndDepartmentViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/23/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "SalaryAndDepartmentViewController.h"
#import "BusinessTier.h"
#import "EmployeesTableViewController.h"
#import "PrevNextSearchToolbarView.h"

@interface SalaryAndDepartmentViewController ()

@property (strong, nonatomic) BusinessTier *bt;

@end

@implementation SalaryAndDepartmentViewController

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EmployeesTableViewController *etvc = [segue destinationViewController];
    self.bt.minSalary = self.textField.text;
    self.bt.maxSalary = self.textFieldTwo.text;
    self.bt.department = self.textFieldThree.text;
    self.bt.searchType = searchBySalaryAndDepartment;
    etvc.currentBT = self.bt;
}

- (void)initDataTier {
    
    self.bt = [[BusinessTier alloc]init];
}

- (void)configureView {
    
    [self initDataTier];
    
    self.segueID = @"SalaryAndDepartmentResults";
    self.label.text = @"Enter a Minimum Salary";
    self.labelTwo.text = @"Enter a Maximum Salary";
    self.labelThree.text = @"Select a Department";
    self.textField.placeholder = @"i.e. 100000";
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldTwo.placeholder = @"i.e. 120000";
    self.textFieldTwo.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldThree.placeholder = @"i.e. MAYOR'S OFFICE";
    self.backgroundImageName = @"chicago_9.png";
    self.pickerViewContents = [self.bt getDepartments];
    
    [super addPickerView:self.textFieldThree]; // add picker view to the third text field
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
