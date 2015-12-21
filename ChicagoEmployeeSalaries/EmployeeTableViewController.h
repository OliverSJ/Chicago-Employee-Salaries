//
//  EmployeeTableViewController.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployeeObject.h"

@interface EmployeeTableViewController : UITableViewController

@property (nonatomic) EmployeeObject *currentEmployee;

@end
