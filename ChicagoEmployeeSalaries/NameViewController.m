//
//  DepartmentViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/23/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "NameViewController.h"
#import "BusinessTier.h"
#import "EmployeesTableViewController.h"
#import "PrevNextSearchToolbarView.h"

@interface NameViewController ()

@property (strong, nonatomic) BusinessTier *bt;

@end

@implementation NameViewController

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EmployeesTableViewController *etvc = [segue destinationViewController];
    self.bt.name = self.textField.text;
    self.bt.searchType = searchByName;
    etvc.currentBT = self.bt;
}

- (void)initDataTier {
    
    self.bt = [[BusinessTier alloc]init];
}

- (void)configureView {
    
    [self initDataTier];
    
    self.segueID = @"NameResults";
    self.label.text = @"Search by Name";
    self.textField.placeholder = @"i.e. RAHM EMANUEL";
    self.backgroundImageName = @"chicago_4.png";
    
    // configure toolbar for picker view
    PrevNextSearchToolbarView *toolBar = [[PrevNextSearchToolbarView alloc]initWithSelectors:nil nextSelector:nil searchSelector:@selector(buttonPressed:)];
    
    self.textField.inputAccessoryView = toolBar;
    
    [super configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self initDataTier];
}

- (void)viewDidLoad {
    
    //[super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
