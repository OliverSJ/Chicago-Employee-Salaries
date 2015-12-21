//
//  SalaryViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "SalaryViewController.h"
#import "EmployeesTableViewController.h"
#import "BusinessTier.h"
#import "UIView+FormScroll.h"

@interface SalaryViewController ()

/** Field for entering a name. */
@property (weak, nonatomic) IBOutlet UITextField *minSalaryTextField;
/** Field for entering a department */
@property (weak, nonatomic) IBOutlet UITextField *maxSalaryTextField;
/** Indicates warnings. */
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
/** Holds scrollable GUI components (UITextField's, UILabel's, etc.). */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** Instruction for minSalaryTextField */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** Instruction for maxSalaryTextField */
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

@implementation SalaryViewController

/*************************************************
 HELPER FUNCTIONS
 *************************************************/
- (BOOL)textIsValidValue:(NSString*)value{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^[$]?[0-9]+([.][0-9]{2})?$"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    if ([regex numberOfMatchesInString:value options:0 range:NSMakeRange(0, value.length)]) {
        NSLog(@"Success");
    }
    
    return YES;
}

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
 SEGUE
 *************************************************/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    EmployeesTableViewController *etvc = [segue destinationViewController];
//    self.currentBT.minSalary = self.minSalaryTextField.text;
//    self.currentBT.maxSalary = self.maxSalaryTextField.text;
//    self.currentBT.salarySearch = YES;
//    etvc.currentBT = self.currentBT; // pass business tier to next view controller
}

/*************************************************
 EVENTS
 *************************************************/

- (IBAction)textFieldValueDidChange:(id)sender {
    UITextField *textField = (UITextField*)sender;
    
    textField.backgroundColor = [UIColor whiteColor];
}

/**
 @brief Triggered upon completion of pressing the search button
 @sender "Search" on keyboard or "Search" UIButton
 */
- (IBAction)searchButtonPressed:(id)sender {
    
    BOOL doReturn = NO;
    
    // 3 possible cases where user doesn't provide input
    if (self.minSalaryTextField.text.length <= 0 &&
        self.maxSalaryTextField.text.length > 0) {
        self.minSalaryTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        doReturn = YES;
    }
    
    if (self.maxSalaryTextField.text.length <= 0 &&
        self.minSalaryTextField.text.length > 0) {
        self.maxSalaryTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        doReturn = YES;
    }
    
    if (self.maxSalaryTextField.text.length <= 0 &&
        self.minSalaryTextField.text.length <= 0) {
        self.minSalaryTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        self.maxSalaryTextField.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        doReturn = YES;
    }
    
    if (doReturn) {
        return;
    }
    
    // close keyboard
    [self.view.window endEditing:YES];
    
    // check if segue can be performed
    [self performSegueWithIdentifier:@"SalaryResults" sender:nil];
}

- (IBAction)nextButtonPressed:(id)sender {
    
    [self.minSalaryTextField resignFirstResponder];
    
    [self.maxSalaryTextField becomeFirstResponder];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // force all text fields to end editing
}

/**
 @brief Sends user to previous textField
 */
- (void)backButtonPressed:(id)sender {
    [self.maxSalaryTextField resignFirstResponder];
    
    [self.minSalaryTextField becomeFirstResponder];
}

/*************************************************
 DEFAULT FUNCTIONS
 *************************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self textIsValidValue:@"$100.00"];
    
    // instantiate BusinessTierObject
    self.currentBT = [[BusinessTier alloc]init];
    
    // add search and x buttons to keyboard
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
    self.maxSalaryTextField.inputAccessoryView = toolBar;
    
    // add search and x buttons to minSalaryTextField keyboard
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
    self.minSalaryTextField.inputAccessoryView = nameToolBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
