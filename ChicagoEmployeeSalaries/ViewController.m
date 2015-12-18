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

@end

@implementation ViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // user has pressed enter on the name text field
    if (textField == self.nameTextField) {
        [self.departmentTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    // DO SEARCH HERE
    
    return YES;
}

- (IBAction)performSearch:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.departmentTextField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // force all text fields to end editing
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //When launching the app for the first time, these labels should be hidden
    _nameLabel.hidden = YES;
    _positionLabel.hidden = YES;
    _departmentLabel.hidden = YES;
    _salaryLabel.hidden = YES;
    
    self.departments = @[@"POLICE", @"MAYOR'S OFFICE", @"FONTANO'S", @"LAGUNITAS"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButton:(UIButton *)sender {
    
    /* TODO:
     
     Implement actions for when the user hits the search button.  
     It should take the data from the two text fields and pass that to the Data Tier classes
     
     */
    
    //Grab the information from the text fields
    NSString *firstName = _firstNameTextField.text;
    NSString *lastName = _lastNameTextField.text;
    
    //TODO:
    //Check to see if either field is empty
    
    //TODO:
    //Launch the SQLite query
    
    
    //NSString *fullName = [NSString stringWithFormat:@"%@ %@",firstName, lastName];
    //Unhide the labels and then set their texts
    _nameLabel.hidden = NO;
   // _nameLabel.text = fullName;
    
    
    
    
}





@end
