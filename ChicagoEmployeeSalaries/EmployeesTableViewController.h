//
//  EmployeesTableViewController.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/18/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessTier.h"

@interface EmployeesTableViewController : UITableViewController

@property (nonatomic) BusinessTier *currentBT;

@end
