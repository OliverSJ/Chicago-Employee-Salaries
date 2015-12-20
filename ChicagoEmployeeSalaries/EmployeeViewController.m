//
//  EmployeeViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/18/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "EmployeeViewController.h"

@interface EmployeeViewController()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *salaryLabel;

@end

@implementation EmployeeViewController

-(void)viewDidLoad {
    self.nameLabel.text = self.currentEmployee.name;
    //self.nameLabel.text = self.currentEmployee.position;
    //self.nameLabel.text = self.currentEmployee.department;
    //self.nameLabel.text = self.currentEmployee.annualSalary;
}

@end
