//
//  EmployeesTableViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/18/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "EmployeesTableViewController.h"

@implementation EmployeesTableViewController

/*************************************************
 EVENTS
 *************************************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // TODO set as size of dataset retreived from BusinessTier
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = @"Rahm Emanuel"; // array index of current values
    cell.detailTextLabel.text = @"Mayor's Office"; // array index of details
    
    return cell;
}

-(void)viewDidLoad {
    // do something here
}

@end