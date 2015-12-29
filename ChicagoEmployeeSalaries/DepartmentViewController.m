//
//  DepartmentViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/23/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "DepartmentViewController.h"
#import "BusinessTier.h"
#import "EmployeesTableViewController.h"
#import "PrevNextSearchToolbarView.h"
#import "GoogleAnalytics.h"

@interface DepartmentViewController ()

@property (strong, nonatomic) BusinessTier *bt;

@end

@implementation DepartmentViewController

- (void)initDataTier {
    
    self.bt = [[BusinessTier alloc]init];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EmployeesTableViewController *etvc = [segue destinationViewController];
    self.bt.department = self.textField.text;
    self.bt.searchType = searchByDepartment;
    etvc.currentBT = self.bt;
}

- (void)configureView {
    
    [self initDataTier];
    
    self.segueID = @"DepartmentResults";
    self.label.text = @"Search by Department";
    self.textField.placeholder = @"i.e. MAYOR'S OFFICE";
//    self.backgroundImageName = @"chicago_3.png";
    self.pickerViewContents = [self.bt getDepartments];
    
    // configure toolbar for picker view
    PrevNextSearchToolbarView *toolBar = [[PrevNextSearchToolbarView alloc]initWithSelectors:nil nextSelector:nil searchSelector:@selector(buttonPressed:)];
    
    self.textField.inputAccessoryView = toolBar;
    
    [super addPickerView];
    [super configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self initDataTier];
    
    [self.view addGoogleAnalytics:@"Department"];
    
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
