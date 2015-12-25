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

- (void)initDataTier {
    
    self.bt = [[BusinessTier alloc]init];
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EmployeesTableViewController *etvc = [segue destinationViewController];
    self.bt.name = [self.textField.text copy];
    self.bt.searchType = searchByName; // <--Enum used to differentiate which type of search I want. This will allow us to wrap the "getEmployees" method by using a series of conditionals that check which enum I specified.
    /* For example, the body of getEmployees may look something like this:
        if (self.searchType == BTSearchByName)
            [self searchByName]
        else if (self.searchType == BTSearchByDepartment)
            [self searchByDepartment] */
    etvc.currentBT = self.bt;
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
