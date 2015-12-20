//
//  EmployeesTableViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/18/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "EmployeesTableViewController.h"
#import "EmployeeViewController.h"

@interface EmployeesTableViewController()

@property (nonatomic) NSArray *employees;
@property (nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end

@implementation EmployeesTableViewController

/*************************************************
 SEGUES
 *************************************************/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EmployeeViewController *evc = [segue destinationViewController];
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    //evc.currentEmployee = employees[path.row];
}

/*************************************************
 EVENTS
 *************************************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // TODO set as size of dataset retreived from BusinessTier
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //cell.textLabel.text = @"Rahm Emanuel"; // array index of current values
    //cell.detailTextLabel.text = @"Mayor's Office"; // array index of details
    cell.textLabel.text = @""; // array index of current values
    cell.detailTextLabel.text = @""; // array index of details
    
    return cell;
}

-(void)viewDidLoad {
    self.activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.activityView.center=self.view.center;
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // No explicit autorelease pool needed here.
        // The code runs in background, not strangling
        // the main run loop.
        //[self doSomeLongOperation];
        //employees = [self.currentBT getEmployees:self.currentBT.name byDepartment:self.currentBT.department]
        dispatch_sync(dispatch_get_main_queue(), ^{
            // This will be called on the main thread, so that
            // you can update the UI, for example.
            //[self longOperationDone];
            [self.activityView stopAnimating];
            [self.tableView reloadData];
        });
    });
}

@end