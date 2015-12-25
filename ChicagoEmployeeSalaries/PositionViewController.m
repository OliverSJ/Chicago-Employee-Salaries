//
//  PositionViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/24/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "PositionViewController.h"
#import "BusinessTier.h"
#import "PrevNextSearchToolbarView.h"
#import "EmployeesTableViewController.m"

@interface PositionViewController ()

@property (strong, nonatomic) BusinessTier *bt;

@end

@implementation PositionViewController

//#pragma mark - Segue
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    EmployeesTableViewController *etvc = [segue destinationViewController];
//    self.bt.positionTitle = self.textField.text;
//    self.bt.searchType = searchByPosition;
//    etvc.currentBT = self.bt;
//}

- (void)initDataTier {
    
    self.bt = [[BusinessTier alloc]init];
}

- (void)configureView {
    
    [self initDataTier];
    
    self.segueID = @"PositionResults";
    self.label.text = @"Search by Position";
    self.textField.placeholder = @"i.e. Mayor";
    self.backgroundImageName = @"chicago_6.png";
    
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
