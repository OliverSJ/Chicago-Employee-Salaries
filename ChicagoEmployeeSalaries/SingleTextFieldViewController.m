//
//  NameViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "SingleTextFieldViewController.h"
#import "UIView+FormScroll.h"

@interface SingleTextFieldViewController()

/** Holds text fields in center of the screen */
@property (weak, nonatomic) IBOutlet UIView *centerView;

@end

@implementation SingleTextFieldViewController

- (instancetype)initWithBackgroundAndSegue:(NSString*)imageName segueIdentifier:(NSString*)identifier
{
    self = [super init];
    if (self) {
        self.backgroundImageName = imageName;
        self.segueID = identifier;
    }
    self.thisView = self;
    return self;
}

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
    self.textField.backgroundColor = [UIColor whiteColor];
}

/*************************************************
 PICKER VIEW (optional)
 *************************************************/

#pragma mark - Picker View Methods

-(void)addPickerView {
    // create pickerview
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.textField.inputView = self.pickerView;
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
    
    if (self.textField.text.length <= 0) {
        self.textField.backgroundColor = [UIColor whiteColor];
    }
    
    // user has selected (leave blank), "blank out" departmentsTextField
    if (row == 0) {
        self.textField.text = @"";
        return;
    }
    // user selected department
    else {
        self.textField.text = self.pickerViewContents[row];
    }
}


/*************************************************
 BUTTONS
 *************************************************/

#pragma mark - Button Methods

- (IBAction)buttonPressed:(id)sender {
    
    if (self.textField.text.length <= 0) {
        self.textField.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
        return;
    }
    
    // close keyboard
    [self.view.window endEditing:YES];
    
    @try {
        [self performSegueWithIdentifier:self.segueID sender:sender];
    }
    @catch (NSException *exception) {
        // issue performing segue
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // force all text fields to end editing
}

/*************************************************
 VIEWS
 *************************************************/

#pragma mark - View Methods

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
    
    [self configureView];
}

@end