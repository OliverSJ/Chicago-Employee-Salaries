//
//  EmployeesTableViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/18/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "EmployeesTableViewController.h"
#import "EmployeeTableViewController.h"

@interface EmployeesTableViewController()

@property (nonatomic) NSArray *employees;
@property (nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic) BOOL noResultsFound;

@end

@implementation EmployeesTableViewController

- (NSString*) setDetailTextLabel:(int)index {
    if (self.currentBT.nameSearch) {
        return [self.employees[index] department];
    }
    
    else if (self.currentBT.salarySearch) {
        return [self.employees[index] annualSalary];
    }
    
    else {
        return [self.employees[index] jobPosition];
    }
}

/*************************************************
 SEGUES
 *************************************************/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EmployeeTableViewController *etvc = [segue destinationViewController];
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    etvc.currentEmployee = self.employees[path.row];
}

/*************************************************
 EVENTS
 *************************************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // no results returned by user's search query
    if (self.employees.count <= 0) {
        return 1;
    }
    
    return self.employees.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (self.employees.count > 0) {
        cell.textLabel.text = [self.employees[indexPath.row] name]; // array index of current values
        cell.detailTextLabel.text = [self.employees[indexPath.row] department]; // array index of details
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // add arrow
        cell.selectionStyle = UITableViewCellSelectionStyleDefault; // make appearance clickable
        cell.userInteractionEnabled = YES; // enable user interaction
    }
    else if (self.noResultsFound){
        cell.textLabel.text = @"No Results Found"; // array index of current values
        cell.detailTextLabel.text = @""; // array index of details
        cell.accessoryType = UITableViewCellAccessoryNone; // remove arrow
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // make appearance unclickable
        cell.userInteractionEnabled = NO; // disable user interaction
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
        // get deep copy array of employees
        self.employees = [[self.currentBT getEmployees:self.currentBT.name department:self.currentBT.department] copy];
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