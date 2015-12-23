//
//  EmployeeTableViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "EmployeeTableViewController.h"

@interface EmployeeTableViewController()

@property (weak, nonatomic) IBOutlet UITableViewCell *salaryCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *positionCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *departmentCell;

@end

@implementation EmployeeTableViewController

/*************************************************
 TABLE VIEW
 *************************************************/

#pragma mark - Table View Methods

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.currentEmployee.name;
            break;
            
        default:
            break;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = sectionTitle;
    
    
    // Get the length of the current section in pixels
    CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
    CGFloat strikeWidth = textSize.width;
    
    // Set size of label dynamically
    label.frame = CGRectMake(20, 6, strikeWidth, 30);

    
    // Create header view and add label as a subview
    CGRect frame = CGRectMake(0, 0, tableView.bounds.size.width, UITableViewAutomaticDimension);
    frame.origin.x = 100;
    UIView *view = [[UIView alloc]initWithFrame:frame];
    [view addSubview:label];
    
    return view;
}

/*************************************************
 VIEWS
 *************************************************/

#pragma mark - View Methods

-(void)viewDidLoad {
    
    //convert string to decimal
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
    
    // fill cell contents with employee details
    self.salaryCell.detailTextLabel.text = formattedString;
    self.positionCell.detailTextLabel.text = self.currentEmployee.jobPosition;
    self.departmentCell.detailTextLabel.text = self.currentEmployee.department;
}

@end
