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

@end

@implementation EmployeesTableViewController

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
    return self.employees.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (self.employees.count > 0) {
        cell.textLabel.text = [self.employees[indexPath.row] name]; // array index of current values
        cell.detailTextLabel.text = [self.employees[indexPath.row] department]; // array index of details
    }
    else {
        cell.textLabel.text = @""; // array index of current values
        cell.detailTextLabel.text = @""; // array index of details
    }
    
    return cell;
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.employees = [[NSArray alloc]init];
    
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
        dispatch_sync(dispatch_get_main_queue(), ^{
            // getEmployees has finished
            [self.activityView stopAnimating];
            [self.tableView reloadData];
        });
    });
}

@end