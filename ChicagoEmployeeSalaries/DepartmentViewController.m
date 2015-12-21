//
//  DepartmentViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "DepartmentViewController.h"
#import "UIView+FormScroll.h"
#import "BusinessTier.h"
#import "EmployeesTableViewController.h"

@interface DepartmentViewController ()

@property (nonatomic) UIPickerView *departmentsPickerView;
@property (nonatomic) BusinessTier *currentBT;
@property (nonatomic) NSArray *departments;
@property (weak, nonatomic) IBOutlet UITextField *departmentTextField;

@end

@implementation DepartmentViewController

/*************************************************
 SCROLLER
 *************************************************/

- (IBAction)textFieldDidBeginEditing:(id)sender {

    UITextField *textField = (UITextField*)sender;

    [self.view scrollToView:textField];
}

- (IBAction)textFieldDidEndEditing:(id)sender {

    [self.view scrollToY:0];
}

/*************************************************
 PICKER VIEW
 *************************************************/

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.departments.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.departments[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (self.departmentTextField.text.length <= 0) {
        self.departmentTextField.backgroundColor = [UIColor whiteColor];
    }
    
    // user has selected (leave blank), "blank out" departmentsTextField
    if (row == 0) {
        self.departmentTextField.text = @"";
        return;
    }
    // user selected department
    else {
        self.departmentTextField.text = self.departments[row];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EmployeesTableViewController *etvc = [segue destinationViewController];
    self.currentBT.department = [self.departmentTextField.text copy];
    self.currentBT.nameAndDepartmentSearch = NO;
    self.currentBT.nameSearch = NO;
    self.currentBT.departmentSearch = YES;
    self.currentBT.salarySearch = NO;
    etvc.currentBT = self.currentBT;
}

- (IBAction)searchButtonPressed:(id)sender {
    
    // check the that user made a selection
    if (self.departmentTextField.text.length <= 0) {
        self.departmentTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        
        return;
    }
    
    // close all search windows
    [self.view.window endEditing:YES];
    
    [self performSegueWithIdentifier:@"DepartmentResults" sender:sender];
}

- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // instantiate BusinessTierObject
    self.currentBT = [[BusinessTier alloc]init];
    
    
    // Make asynchronous request for department names
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.departments = [self.currentBT getDepartments];
        });
    });
    
    // create pickerview for departments
    self.departmentsPickerView = [[UIPickerView alloc] init];
    self.departmentsPickerView.dataSource = self;
    self.departmentsPickerView.delegate = self;
    self.departmentTextField.inputView = self.departmentsPickerView;
    
    // add toolbar to hold search button
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    
    // middle space between left and right buttons
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    // search button
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                  target:self
                                                                                  action:@selector(searchButtonPressed:)];
    
    toolBar.items = @[flex, searchButton];
    self.departmentTextField.inputAccessoryView = toolBar;
    
    // add search button to nameTextField keyboard
    UIToolbar *nameToolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [nameToolBar setBarStyle:UIBarStyleDefault];
}

@end
