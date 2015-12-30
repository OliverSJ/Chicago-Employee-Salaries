//
//  DepartmentViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/23/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "SalaryViewController.h"
#import "BusinessTier.h"
#import "EmployeesTableViewController.h"
#import "PrevNextSearchToolbarView.h"
#import "GoogleAnalytics.h"

@interface SalaryViewController ()

@property (strong, nonatomic) BusinessTier *bt;

@end

@implementation SalaryViewController

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EmployeesTableViewController *etvc = [segue destinationViewController];
    self.bt.minSalary = self.textField.text;
    self.bt.maxSalary = self.textFieldTwo.text;
    self.bt.searchType = searchBySalary;
    etvc.currentBT = self.bt;
}

- (void)initDataTier {
    
    self.bt = [[BusinessTier alloc]init];
}

- (void)configureView {
    
    [self initDataTier];
    
    self.segueID = @"SalaryResults";
    self.label.text = @"Enter a Minimum Salary";
    self.labelTwo.text = @"Enter a Maximum Salary";
    self.textField.placeholder = @"i.e. 100000";
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldTwo.placeholder = @"i.e. 120000";
    self.textFieldTwo.keyboardType = UIKeyboardTypeNumberPad;
//    self.backgroundImageName = @"chicago_2.png";
    
    [super addToolbars]; // add toolbars to both text fields
    [super configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self initDataTier];
    
    [self.view addGoogleAnalytics:@"Salary"];
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
