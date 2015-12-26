//
//  NameViewController.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleTextFieldViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSString *segueID;
@property UIViewController *thisView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSString *backgroundImageName;
@property (strong, nonatomic) NSArray *pickerViewContents;
@property (nonatomic) IBOutlet UIPickerView *pickerView;

- (instancetype)initWithBackgroundAndSegue:(NSString*)imageName segueIdentifier:(NSString*)identifier;
- (IBAction)buttonPressed:(id)sender;
- (void)addPickerView;
- (void)configureView;

@end
