//
//  EmployeeTableViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "EmployeeTableViewController.h"

@interface EmployeeTableViewController()

@property (nonatomic) NSMutableArray *employeeDetails;

@end

@implementation EmployeeTableViewController

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.text = @"";
            cell.textLabel.text = [cell.textLabel.text stringByAppendingString:self.employeeDetails[0]];
            cell.textLabel.font  = [ UIFont fontWithName: @"Arial" size: 18.0 ];
            break;
            
        case 1:
            cell.textLabel.text = @"POSITION: ";
            cell.textLabel.text = [cell.textLabel.text stringByAppendingString:self.employeeDetails[1]];
            break;
            
        case 2:
            cell.textLabel.text = @"DEPARTMENT: ";
            cell.textLabel.text = [cell.textLabel.text stringByAppendingString:self.employeeDetails[2]];
            break;
            
        case 3:
            cell.textLabel.text = @"ANNUAL SALARY: ";
            
            cell.textLabel.text = [cell.textLabel.text stringByAppendingString:self.employeeDetails[3]];
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.employeeDetails.count;
}

-(void)viewDidLoad {
    
    self.tableView.estimatedRowHeight = 89;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // convert string to decimal
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *salary = [f numberFromString:self.currentEmployee.annualSalary];
    
    // convert decimal string to currency string
    // i.e. 1535.00 -> $1,535
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setUsesGroupingSeparator:YES];
    NSString *formattedString = [formatter stringFromNumber:salary];
    
    // build array for table view
    self.employeeDetails = [[NSMutableArray alloc]init];
    [self.employeeDetails addObject:self.currentEmployee.name];
    [self.employeeDetails addObject:self.currentEmployee.job_position];
    [self.employeeDetails addObject:self.currentEmployee.department];
    [self.employeeDetails addObject:formattedString];
}

@end
