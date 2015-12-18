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

- (void) performSearch {
    // TODO - search stuff here
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // user has pressed enter on the name text field
    if (textField == self.nameTextField) {
        [self.departmentTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
        [self performSearch]; // perform search
    }

    return YES;
}

- (IBAction)searchClicked:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.departmentTextField resignFirstResponder];
    
    [self performSearch]; // perform search
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // force all text fields to end editing
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
 
    
    self.departments = @[@"POLICE", @"MAYOR'S OFFICE", @"FONTANO'S", @"LAGUNITAS"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
