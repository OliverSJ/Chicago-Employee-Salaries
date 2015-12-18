//
//  ViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Oliver San Juan on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //When launching the app for the first time, these labels should be hidden
    _nameLabel.hidden = YES;
    _positionLabel.hidden = YES;
    _departmentLabel.hidden = YES;
    _salaryLabel.hidden = YES;
    

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
