//
//  ViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Oliver San Juan on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "ViewController.h"
#import "EmployeesTableViewController.h"
#import "BusinessTier.h"
#import "GoogleAnalytics.h"

// allow for hex input color
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface ViewController ()

/** Options provided on the TableView. */
@property (nonatomic) NSArray *tableViewCells;
/** Table view for displaying contents.*/
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** Holds app title and search options in center of the screen */
@property (weak, nonatomic) IBOutlet UIView *centerView;

@end

@implementation ViewController

/*************************************************
 TABLE VIEW
 *************************************************/

#pragma mark - Table View Methods

-(void)searchButtonPressed:(NSString*)buttonText {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"Home"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"build_search"
                                                           label:buttonText
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tableViewCells.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.tableViewCells[indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.backgroundColor = [UIColor clearColor];
  
    switch (indexPath.row) {
            
        default:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5f];
            cell.selectedBackgroundView = [UIView new];
            cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xB3DDF2);
            cell.imageView.image = [UIImage imageNamed:@"star.png"];
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Send button pressed to Google Analytics
    [self searchButtonPressed:self.tableViewCells[indexPath.row]];
    
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"SearchByName" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"SearchByDepartment" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"SearchBySalary" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"SearchByPosition" sender:self];
            break;
        case 4:
            [self performSegueWithIdentifier:@"SearchByNameAndDepartment" sender:self];
            break;
        case 5:
            [self performSegueWithIdentifier:@"SearchByPositionAndDepartment" sender:self];
            break;
        case 6:
            [self performSegueWithIdentifier:@"SearchBySalaryAndDepartment" sender:self];
            break;
        case 7:
            [self performSegueWithIdentifier:@"SearchBySalaryAndPosition" sender:self];
            break;
        default:
            break;
    }
    
    //Change the selected background view of the cell.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/*************************************************
 VIEW METHODS
 *************************************************/

#pragma mark - View Methods

-(void)configureView {
    // round center view
    self.centerView.layer.cornerRadius = 20;
    self.centerView.layer.masksToBounds = YES;
    self.centerView.layer.opacity = 0.9f;
    
    // add image to background
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chicago_5.png"]];
//    [self.view addSubview:backgroundView];
//    [self.view sendSubviewToBack:backgroundView];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.tableViewCells = @[@"Name", @"Department", @"Salary", @"Position", @"Name and Department", @"Position and Department", @"Salary and Department", @"Salary and Position"];
    
    // helps hide separators in certain cells, see cellForRowAtIndexPath in tableView for more
    self.tableView.separatorColor = [UIColor clearColor];
}

-(void)showOptInAlert {
    UIAlertController *alert =   [UIAlertController
                                  alertControllerWithTitle:@"Google Analytics"
                                  message:@"With your permission, usage information will be collected to improve the application."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             // do nothing
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    UIAlertAction *noThanks = [UIAlertAction
                             actionWithTitle:@"No Thanks"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 // opt out of tracking
                                 [[GAI sharedInstance] setOptOut:YES];
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:noThanks];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.view addGoogleAnalytics:@"Home"];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView flashScrollIndicators];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (! [defaults boolForKey:@"alertShown"]) {
        // display alert...
        [self showOptInAlert];
        [defaults setBool:YES forKey:@"alertShown"];
    }
    
    [self configureView];
}

#pragma mark - Memory Methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
