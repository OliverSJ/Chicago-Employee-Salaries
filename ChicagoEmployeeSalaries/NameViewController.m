//
//  NameViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "NameViewController.h"
#import "UIView+FormScroll.h"
#import "BusinessTier.h"
#import "EmployeesTableViewController.h"
#import "UIView+FormScroll.h"

@interface NameViewController ()

/** Displays departments */
@property (nonatomic) UIPickerView *departmentsPickerView;
/** Businsess tier class */
@property (nonatomic) BusinessTier *currentBT;
/** Name value used in query */
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
/** Holds text fields in center of the screen */
@property (weak, nonatomic) IBOutlet UIView *centerView;

@end

@implementation NameViewController

/*************************************************
 TEXT FIELDS
 *************************************************/

#pragma mark - Text Field Methods

- (IBAction)textFieldDidBeginEditing:(id)sender {
    
    UITextField *textField = (UITextField*)sender;
    
    [self.view scrollToView:textField];
}

- (IBAction)textFieldDidEndEditing:(id)sender {
    
    [self.view scrollToY:0];
}

- (IBAction)textFieldValueDidChange:(id)sender {
    self.nameTextField.backgroundColor = [UIColor whiteColor];
}

/*************************************************
 SEGUE
 *************************************************/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EmployeesTableViewController *etvc = [segue destinationViewController];
    self.currentBT.name = [self.nameTextField.text copy];
    self.currentBT.nameAndDepartmentSearch = NO;
    self.currentBT.nameSearch = YES;
    self.currentBT.departmentSearch = NO;
    self.currentBT.salarySearch = NO;
    etvc.currentBT = self.currentBT;
}

/*************************************************
 BUTTONS
 *************************************************/

#pragma mark - Button Methods

- (IBAction)searchButtonPressed:(id)sender {
    
    if (self.nameTextField.text.length <= 0) {
        self.nameTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
        return;
    }
    
    // close keyboard
    [self.view.window endEditing:YES];
    
    [self performSegueWithIdentifier:@"NameResults" sender:sender];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // force all text fields to end editing
}

/*************************************************
 VIEWS
 *************************************************/

#pragma mark - View Methods

- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // round center view
    self.centerView.layer.cornerRadius = 20;
    self.centerView.layer.masksToBounds = YES;
    self.centerView.layer.opacity = 0.97f;
    
    // add image to backround
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chicago_4.png"]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
    // instantiate BusinessTierObject
    self.currentBT = [[BusinessTier alloc]init];
    
    // add search and x buttons to nameTextField keyboard
    UIToolbar *nameToolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [nameToolBar setBarStyle:UIBarStyleDefault];
    
    // space before search button
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    // search button
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                  target:self
                                                                                  action:@selector(searchButtonPressed:)];
    
    nameToolBar.items = @[flex, searchButton];
    self.nameTextField.inputAccessoryView = nameToolBar;
}

@end