//
//  NameViewController.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripleTextFieldViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSString *segueID;
@property UIViewController *thisView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *textFieldTwo;
@property (strong, nonatomic) IBOutlet UITextField *textFieldThree;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *labelTwo;
@property (strong, nonatomic) IBOutlet UILabel *labelThree;
@property (strong, nonatomic) NSString *backgroundImageName;
@property (strong, nonatomic) NSArray *pickerViewContents;
@property (nonatomic) IBOutlet UIPickerView *pickerView;

- (void)addToolbars;
- (IBAction)buttonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)prevButtonPressed:(id)sender;
- (void)addPickerView:(UITextField*)selectedTextField;
- (void)configureView;

@end