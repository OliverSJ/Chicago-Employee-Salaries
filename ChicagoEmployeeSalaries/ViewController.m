//
//  ViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Oliver San Juan on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "ViewController.h"
#import "EmployeesTableViewController.h"
#import "BusinessTier.h"

@interface ViewController ()

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

/**
 @brief Checks for correct formatting of a string.
 @param string String to be checked.
 @returns BOOL YES if string is the in correct format. NO otherwise.
 */
- (BOOL)textIsValidValue:(NSString*)string;

/**
 @details Event called when a search button is pressed.
 */
-(void)searchButtonPressed:(id)sender;

@end

@implementation ViewController

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
 SEGUE
 *************************************************/

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    // prevent segue if user did not specify any search criteria
    if (self.nameTextField.text.length <= 0 && self.departmentTextField.text.length <= 0){
        self.warningLabel.text = @"Please provide some search criteria.";
        self.warningLabel.hidden = NO;
        self.nameTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
        self.departmentTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
        return NO;
    }
    
    // prevent segue if user did not provide valid search strings
    else if ([self textIsValidValue:self.nameTextField.text] == NO) {
        self.warningLabel.text = @"Name must be blank or contain only letters.";
        self.warningLabel.hidden = NO;
        self.nameTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
        return NO;
    }
    
    // user provided valid input, ready to segue
    else {
        return YES;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EmployeesTableViewController *etvc = [segue destinationViewController];
    self.currentBT.name = self.nameTextField.text;
    self.currentBT.department = self.departmentTextField.text;
    etvc.currentBT = self.currentBT; // pass business tier to next view controller
}

/*************************************************
 EVENTS
 *************************************************/

/**
 @brief Triggered upon editing a text field.
 @param sender UITextField object
 */
- (IBAction)editTextField:(id)sender {
    
    // capture the sender
    UITextField *textField = (UITextField*)sender;
    
    // reset text fields
    self.warningLabel.hidden = YES;
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    self.departmentTextField.backgroundColor = [UIColor whiteColor];
    
    // auto scroll to allow space for keyboard
    // scroll to top of nameTextField
    if (textField == self.nameTextField){
        [self.scrollView setContentOffset:CGPointMake(0,self.nameLabel.frame.origin.y) animated:YES];
    }
    
    // scroll to top of departmentTextField
    else if (textField == self.departmentTextField){
        [self.scrollView setContentOffset:CGPointMake(0,self.departmentLabel.frame.origin.y) animated:YES];
    }
}

/**
 @brief Triggered upon completion of editing a text field.
 @param sender UITextField object
 */
- (IBAction)finishedEditingTextField:(id)sender {
    
    // set scrollview back to default position
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
}

/**
 @brief Triggered upon completion of pressing the search button
 @sender "Search" on keyboard or "Search" UIButton
 */
- (IBAction)searchButtonPressed:(id)sender {
    
    // close keyboard
    [self.nameTextField resignFirstResponder];
    [self.departmentTextField resignFirstResponder];
    
    // no need to check if segue can be performed
    // it's called automatically this UIBUtton object
    if (sender == self.searchButton) {
        return;
    }
    
    // check if segue can be performed
    if ([self shouldPerformSegueWithIdentifier:@"PerformSearch" sender:nil]) { [self performSegueWithIdentifier:@"PerformSearch" sender:nil]; }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // user has pressed "next" on the name text field
    if (textField == self.nameTextField) {
        [self.departmentTextField becomeFirstResponder];
    }
    // user has pressed search on the name of the text field
    else if (textField == self.departmentTextField) {
        [textField resignFirstResponder];
        
        // segue to table view controller
        // first check if user inputted data in either
        // text field
        if ([self shouldPerformSegueWithIdentifier:@"PerformSearch" sender:nil]) { [self performSegueWithIdentifier:@"PerformSearch" sender:nil]; }
    }
    
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // force all text fields to end editing
    // hide any warnings
    //self.warningLabel.hidden = YES;
}

/**
 @brief Called when the user performs a single tap in the GUI interface.
 */
- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES]; // force all text fields to end editing
}

- (void)nextButtonPressed:(id)sender {
    [self.nameTextField resignFirstResponder];
    
    [self.departmentTextField becomeFirstResponder];
}

/**
 @brief Sends user to previous textFiedl
 */
- (void)backButtonPressed:(id)sender {
    [self.departmentTextField resignFirstResponder];
    
    [self.nameTextField becomeFirstResponder];
}

/*************************************************
 HELPER FUNCTIONS
 *************************************************/
- (BOOL)textIsValidValue:(NSString*)string{
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "];
    
    s = [s invertedSet];
    
    NSRange r = [string rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
        return NO;
    }
    
    return YES;
}


/*************************************************
 DEFAULT FUNCTIONS
 *************************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // setup touch recognizer for scrollView
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.scrollView addGestureRecognizer:singleTap];
    
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
