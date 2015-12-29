//
//  NameViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "DoubleTextFieldViewController.h"
#import "UIView+FormScroll.h"
#import "PrevNextSearchToolbarView.h"
#import "GoogleAnalytics.h"

@interface DoubleTextFieldViewController()

/** Holds text fields in center of the screen */
@property (weak, nonatomic) IBOutlet UIView *centerView;

@end

@implementation DoubleTextFieldViewController

/*************************************************
 TEXT FIELDS
 *************************************************/

#pragma mark - Text Field Methods

- (IBAction)textFieldDidBeginEditing:(id)sender {
    
    UITextField *tempTextField = (UITextField*)sender;
    
    [self.view scrollToView:tempTextField];
}

- (IBAction)textFieldDidEndEditing:(id)sender {
    
    [self.view scrollToY:0];
}

- (IBAction)textFieldValueDidChange:(id)sender {
    
    UITextField *tempTextField = (UITextField*)sender;
    tempTextField.backgroundColor = [UIColor whiteColor];
}

/*************************************************
 PICKER VIEW (optional)
 *************************************************/

#pragma mark - Picker View Methods

-(void)addPickerView:(UITextField*)selectedTextField {
    // create pickerview
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    selectedTextField.inputView = self.pickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.pickerViewContents.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.pickerViewContents[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (self.textFieldTwo.text.length <= 0) {
        self.textFieldTwo.backgroundColor = [UIColor whiteColor];
    }
    
    // user has selected (leave blank), "blank out" departmentsTextField
    if (row == 0) {
        self.textFieldTwo.text = @"";
        return;
    }
    // user selected pickerview
    else {
        self.textFieldTwo.text = self.pickerViewContents[row];
    }
}


/*************************************************
 BUTTONS
 *************************************************/

#pragma mark - Button Methods

- (IBAction)buttonPressed:(id)sender {
    
    BOOL doReturn = NO;
    
    // 2 possible cases where user doesn't provide input
    if (self.textField.text.length <= 0) {
        self.textField.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        doReturn = YES;
    }
    
    if (self.textFieldTwo.text.length <= 0) {
        self.textFieldTwo.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        doReturn = YES;
    }
    
    if (doReturn) {
        return;
    }
    
    // send google analytics info about which type of search being performed
    [self.view addGoogleAnalyticsEvent:@"Search" createEventWithCategory:@"UX" action:@"view_employees" label:self.segueID];
    
    // close keyboard
    [self.view.window endEditing:YES];
    
    @try {
        [self performSegueWithIdentifier:self.segueID sender:sender];
    }
    @catch (NSException *exception) {
        // issue performing segue
    }
}

- (IBAction)nextButtonPressed:(id)sender {
    
    [self.textField resignFirstResponder];
    
    [self.textFieldTwo becomeFirstResponder];
}

- (void)prevButtonPressed:(id)sender {
    [self.textFieldTwo resignFirstResponder];
    
    [self.textField becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // force all text fields to end editing
}

/*************************************************
 VIEWS
 *************************************************/

#pragma mark - View Methods

- (void)addToolbars {
    // configure toolbar for picker view
    // add toolbar to min salary keyboard
    PrevNextSearchToolbarView *firstToolbar = [[PrevNextSearchToolbarView alloc]initWithSelectors:@selector(prevButtonPressed:) nextSelector:@selector(nextButtonPressed:) searchSelector:nil];
    firstToolbar.items[0].enabled = NO; // disable prev button
    self.textField.inputAccessoryView = firstToolbar;
    
    // add toolbar to max salary keyboard
    PrevNextSearchToolbarView *secondToolbar = [[PrevNextSearchToolbarView alloc]initWithSelectors:@selector(prevButtonPressed:) nextSelector:@selector(nextButtonPressed:) searchSelector:@selector(buttonPressed:)];
    secondToolbar.items[1].enabled = NO; // disable next button
    self.textFieldTwo.inputAccessoryView = secondToolbar;
}

-(void)configureView {
    // round center view
    self.centerView.layer.cornerRadius = 20;
    self.centerView.layer.masksToBounds = YES;
    self.centerView.layer.opacity = 0.97f;
    
    // add image to backround
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.backgroundImageName]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end