//
//  ViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Oliver San Juan on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property NSArray *departments;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *departmentTextField;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    // prevent segue if user did not specify any search criteria
    if (self.nameTextField.text.length <= 0 && self.departmentTextField.text.length <= 0){
        self.warningLabel.hidden = NO;
        return NO;
    }
    
    return YES;
}

- (IBAction)editTextField:(id)sender {
    self.warningLabel.hidden = YES;
    
    // Place Scroll Code here
    UITextField *textField = (UITextField*)sender;
    [self.scrollView setContentOffset:CGPointMake(0,textField.frame.origin.y) animated:YES]; animated:YES;
}

- (IBAction)finishedEditingTextField:(id)sender {
    
        // set scrollview back to default position
        [self.scrollView setContentOffset:
         CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
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

- (IBAction)searchClicked:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.departmentTextField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // force all text fields to end editing
    // hide any warnings
    self.warningLabel.hidden = YES;
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES]; // force all text fields to end editing
    // hide any warnings
    self.warningLabel.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // setup touch recognizer for scrollView
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.scrollView addGestureRecognizer:singleTap];
    
    self.departments = @[@"POLICE", @"MAYOR'S OFFICE", @"FONTANO'S", @"LAGUNITAS"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
