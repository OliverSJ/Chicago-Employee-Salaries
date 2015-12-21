//
//  NameAndDepartmentViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "NameAndDepartmentViewController.h"
#import "EmployeesTableViewController.h"
#import "BusinessTier.h"
#import "UIView+FormScroll.h"

@interface NameAndDepartmentViewController ()

/** City of chicago's current departments. */
@property NSArray *departments;
/** Contains department names a row values. */
@property UIPickerView *departmentsPickerView;
/** Field for entering a name. */
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
/** Field for entering a department */
@property (weak, nonatomic) IBOutlet UITextField *departmentTextField;
/** Indicates warnings. */
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
/** Holds scrollable GUI components (UITextField's, UILabel's, etc.). */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** Instruction for nameTextField */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** Instruction for departmentTextField */
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
/** Performs a search */
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
/** Class for holding all employee information and search results. */
@property (nonatomic) BusinessTier *currentBT;
/** Options provided on the TableView. */
@property (nonatomic) NSArray *tableViewCells;
/** Table view for displaying contents.*/
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 @details Event called when a search button is pressed.
 */
-(void)searchButtonPressed:(id)sender;

@end

@implementation NameAndDepartmentViewController

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
/*************************************************
 TABLE VIEW
 *************************************************/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableViewCells.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.tableViewCells[indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    switch (indexPath.row) {
            
        case 0:
            cell.textLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
            
        case 1:
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
            
        default:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 2:
            [self performSegueWithIdentifier:@"SearchByName" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"SearchByDepartment" sender:self];
            break;
        case 4:
            [self performSegueWithIdentifier:@"SearchByNameAndDepartment" sender:self];
            break;
        case 5:
            [self performSegueWithIdentifier:@"SearchBySalary" sender:self];
            break;
    }
    
}

/*************************************************
 SEGUE
 *************************************************/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EmployeesTableViewController *etvc = [segue destinationViewController];
    self.currentBT.name = self.nameTextField.text;
    self.currentBT.department = self.departmentTextField.text;
    self.currentBT.nameAndDepartmentSearch = YES;
    etvc.currentBT = self.currentBT; // pass business tier to next view controller
}

/*************************************************
 EVENTS
 *************************************************/

- (IBAction)textFieldValueDidChange:(id)sender {
    UITextField *textField = (UITextField*)sender;
    
    textField.backgroundColor = [UIColor whiteColor];
}

/**
 @brief Triggered upon completion of editing a text field.
 @param sender UITextField object
 */
- (IBAction)finishedEditingTextField:(id)sender {
    
    // set scrollview back to default position
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    
    // reset pickerview to first position if empty
    if (self.departmentTextField.text.length <= 0)
        [self.departmentsPickerView selectRow:0 inComponent:0 animated:YES];
}

/**
 @brief Triggered upon completion of pressing the search button
 @sender "Search" on keyboard or "Search" UIButton
 */
- (IBAction)searchButtonPressed:(id)sender {
    
    BOOL doReturn = NO;
    
    // 3 possible cases where user doesn't provide input
    if (self.nameTextField.text.length <= 0 &&
        self.departmentTextField.text.length > 0) {
        self.nameTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        doReturn = YES;
    }
    
    if (self.departmentTextField.text.length <= 0 &&
        self.nameTextField.text.length > 0) {
        self.departmentTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        doReturn = YES;
    }
    
    if (self.departmentTextField.text.length <= 0 &&
             self.nameTextField.text.length <= 0) {
        self.nameTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        self.departmentTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        doReturn = YES;
    }
    
    if (doReturn) {
        return;
    }
    
    // close keyboard
    [self.view.window endEditing:YES];
    
    // check if segue can be performed
    [self performSegueWithIdentifier:@"NameAndDepartmentResults" sender:nil];
}

- (IBAction)nextButtonPressed:(id)sender {
    
    [self.nameTextField resignFirstResponder];
    
    [self.departmentTextField becomeFirstResponder];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // force all text fields to end editing
}

/**
 @brief Sends user to previous textFiedl
 */
- (void)backButtonPressed:(id)sender {
    [self.departmentTextField resignFirstResponder];
    
    [self.nameTextField becomeFirstResponder];
}

/*************************************************
 DEFAULT FUNCTIONS
 *************************************************/

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
    
    // add search and x buttons to picker view
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    
    // previous button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"BackIcon"]
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(backButtonPressed:)];
    
    // next button
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"NextIcon"]
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(nextButtonPressed:)];
    
    // don't allow to press next button
    nextButton.enabled = NO;
    
    // middle space between left and right buttons
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    // search button
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                  target:self
                                                                                  action:@selector(searchButtonPressed:)];
    
    toolBar.items = @[backButton, nextButton, flex, searchButton];
    self.departmentTextField.inputAccessoryView = toolBar;
    
    // add search and x buttons to nameTextField keyboard
    UIToolbar *nameToolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [nameToolBar setBarStyle:UIBarStyleDefault];
    
    // previous button
    UIBarButtonItem *nameBackButton = [[UIBarButtonItem alloc]
                                       initWithImage:[UIImage imageNamed:@"BackIcon"]
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(backButtonPressed:)];
    
    // next button
    UIBarButtonItem *nameNextButton = [[UIBarButtonItem alloc]
                                       initWithImage:[UIImage imageNamed:@"NextIcon"]
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(nextButtonPressed:)];
    
    // allow user to press next button
    nameNextButton.enabled = YES;
    
    // don't allow user to press back button
    nameBackButton.enabled = NO;
    
    nameToolBar.items = @[nameBackButton, nameNextButton, flex];
    self.nameTextField.inputAccessoryView = nameToolBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
