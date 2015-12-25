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

// round tableview cells
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 20.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.85f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}

/*************************************************
 VIEWS
 *************************************************/

#pragma mark - View Methods

-(void)viewDidLoad {
    
    // add image to background
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chicago_flag.png"]];
    backgroundView.alpha = 0.5f;
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
    // fill cell contents with employee details
    self.salaryCell.detailTextLabel.text = self.currentEmployee.annualSalary;
    self.positionCell.detailTextLabel.text = self.currentEmployee.jobPosition;
    self.departmentCell.detailTextLabel.text = self.currentEmployee.department;
    
}

@end
