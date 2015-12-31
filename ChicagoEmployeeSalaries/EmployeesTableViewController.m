//
//  EmployeesTableViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/18/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "EmployeesTableViewController.h"
#import "EmployeeTableViewController.h"
#import "GoogleAnalytics.h"

// allow for hex input color
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface EmployeesTableViewController()

/** Contains EmployeeObjects */
@property (nonatomic) NSArray *employees;
/** Indicate to user that content is loading */
@property (nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic) BOOL noResultsFound;

@end

@implementation EmployeesTableViewController

/*************************************************
 HELPERS
 *************************************************/

- (NSString*) convertCurrencyStringtoDecimalString:(NSString*)currencyString {
    NSString *decimalString;
    
    // atempt to remove $ if it exists
    @try {
        decimalString = [currencyString stringByReplacingOccurrencesOfString:@"$"   withString:@""];
    }
    @catch (NSException *exception) {
        // do nothing
    }
    
    // atempt to remove comma if it exists
    @try {
        decimalString = [decimalString stringByReplacingOccurrencesOfString:@","   withString:@""];
    }
    @catch (NSException *exception) {
        // do nothing
    }
    
    return decimalString;
}

-(NSString*)convetToCurrencyString:(NSString*)string {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *number = [f numberFromString:string];
    return [formatter stringFromNumber:number];
}

/*************************************************
 TEXT LABELS
 *************************************************/

#pragma mark - Text Label Methods

/**
 @brief Sets the detail text label of a table cell to the
 appropriate stirng value.
 
 @description This method is smart in the sense that it
 chooses which label to display depending on the
 user's search query.
 
 @param index The index where the given employee exists.
 */
- (NSString*) setDetailTextLabel:(int)index {
    
    //    // display department in cell details
    if (self.currentBT.searchType == searchByName) {
        return [self.employees[index] department];
    }
    
    // display salary in cell details
    else if (self.currentBT.searchType == searchBySalary
             || self.currentBT.searchType == searchByPositionAndDepartment
             || self.currentBT.searchType == searchByPositionAndDepartment) {
        
        return [self convetToCurrencyString:[self.employees[index] annualSalary]];
    }
    
    // display job position in cell details
    else {
        return [self.employees[index] jobPosition];
    }
    return nil;
}

/*************************************************
 SEGUES
 *************************************************/

#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EmployeeTableViewController *etvc = [segue destinationViewController];
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    etvc.currentEmployee = self.employees[path.row];
}

/*************************************************
 TALBE VIEW
 *************************************************/

#pragma mark - Table View Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *name = cell.textLabel.text;
    
    // send google analytics info about which type of search being performed
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"Employees"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"employee_details"
                                                           label:name
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
    
    //Change the selected background view of the cell.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // no results returned by user's search query
    if (self.employees.count <= 0) {
        return 1;
    }
    
    return self.employees.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (self.noResultsFound){
        cell.textLabel.text = @"No Results Found"; // array index of current values
        cell.detailTextLabel.text = @""; // array index of details
        cell.accessoryType = UITableViewCellAccessoryNone; // remove arrow
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // make appearance unclickable
        cell.userInteractionEnabled = NO; // disable user interaction
    }
    
    else if (self.employees.count > 1 && indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%tu results found", self.employees.count]; // array index of current values
        cell.detailTextLabel.text = @""; // array index of details
        cell.accessoryType = UITableViewCellAccessoryNone; // remove arrow
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // make appearance unclickable
        cell.userInteractionEnabled = NO; // disable user interaction
        cell.imageView.image = nil;
    }
    
    else if (self.employees.count > 0) {
        cell.textLabel.text = [self.employees[indexPath.row] name]; // array index of current values
        cell.detailTextLabel.text = [self setDetailTextLabel:(int)indexPath.row]; // array index of details
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // add arrow
        cell.selectionStyle = UITableViewCellSelectionStyleDefault; // make appearance clickable
        cell.userInteractionEnabled = YES; // enable user interaction
        cell.selectedBackgroundView = [UIView new]; // create new view in cell
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xB3DDF2); // color selection chicago blue
        
        NSString *decimalString = [self convertCurrencyStringtoDecimalString:[self.employees[indexPath.row]annualSalary]];
        
        
        
        // select image to give user information about the employees salary
        if ([decimalString integerValue] < 60000) {
            cell.imageView.image = [UIImage imageNamed:@"dollar_circle_1.png"]; // add image to each cell
        }
        else if ([decimalString integerValue] < 90000) {
            cell.imageView.image = [UIImage imageNamed:@"dollar_circle_2.png"]; // add image to each cell
        }
        else if ([decimalString integerValue] < 150000) {
            cell.imageView.image = [UIImage imageNamed:@"dollar_circle_3.png"]; // add image to each cell
        }
        else {
            cell.imageView.image = [UIImage imageNamed:@"dollar_circle_4.png"]; // add image to each cell
        }
        
        
    }
    
    else {
        cell.textLabel.text = @""; // array index of current values
        cell.detailTextLabel.text = @""; // array index of details
        cell.accessoryType = UITableViewCellAccessoryNone; // remove arrow
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // make appearance unclickable
        cell.userInteractionEnabled = NO; // disable user interaction
    }
    
    return cell;
}

/*************************************************
 VIEWS
 *************************************************/

#pragma mark - View Methods

-(void)viewWillAppear:(BOOL)animated {
    
    [self.view addGoogleAnalytics:@"Employees"];
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.employees = [[NSArray alloc]init];
    self.noResultsFound = NO;
    
    // create UIActivityIndicator
    self.activityView = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center=self.view.center;
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    
    // asnyc call for getEmployees
    // shows ActivityIndicator while waiting for response
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.employees = [self.currentBT getEmployees];
        if (self.employees.count <= 0) {
            self.noResultsFound = YES;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            // getEmployees has finished
            [self.activityView stopAnimating];
            [self.tableView reloadData];
        });
    });
}

@end