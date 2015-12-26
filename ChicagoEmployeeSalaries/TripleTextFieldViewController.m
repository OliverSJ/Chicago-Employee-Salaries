//
//  NameViewController.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "TripleTextFieldViewController.h"
#import "UIView+FormScroll.h"
#import "PrevNextSearchToolbarView.h"

@interface TripleTextFieldViewController()

/** Holds text fields in center of the screen */
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (nonatomic) int currTextField;
@property (nonatomic) NSArray *textFieldArr; // hold all text fields in the view

@end

@implementation TripleTextFieldViewController

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
    
    if (self.textFieldThree.text.length <= 0) {
        self.textFieldThree.backgroundColor = [UIColor whiteColor];
    }
    
    // user has selected (leave blank), "blank out" departmentsTextField
    if (row == 0) {
        self.textFieldThree.text = @"";
        return;
    }
    // user selected pickerview
    else {
        self.textFieldThree.text = self.pickerViewContents[row];
    }
}


/*************************************************
 BUTTONS
 *************************************************/

#pragma mark - Button Methods

- (IBAction)buttonPressed:(id)sender {
    
    BOOL doReturn = NO;
    
    // 3 possible cases where user doesn't provide input
    if (self.textField.text.length <= 0) {
        self.textField.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        doReturn = YES;
    }
    
    if (self.textFieldTwo.text.length <= 0) {
        self.textFieldTwo.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        doReturn = YES;
    }
    
    if (self.textFieldThree.text.length <= 0) {
        self.textFieldThree.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        self.textFieldThree.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        doReturn = YES;
    }
    
    if (doReturn) {
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

- (IBAction)nextButtonPressed:(id)sender {
    NSLog(@"Closing text field %i", self.currTextField);
    UITextField *curr = self.textFieldArr[self.currTextField];
    UITextField *next = self.textFieldArr[++self.currTextField];

    [self.textField resignFirstResponder];
    [next becomeFirstResponder];
}

- (void)prevButtonPressed:(id)sender {
    UITextField *curr = self.textFieldArr[self.currTextField];
    UITextField *prev = self.textFieldArr[--self.currTextField];
    
    [curr resignFirstResponder];
    [prev becomeFirstResponder];
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
    // add toolbar to first textfield
    PrevNextSearchToolbarView *firstToolbar = [[PrevNextSearchToolbarView alloc]initWithSelectors:@selector(prevButtonPressed:) nextSelector:@selector(nextButtonPressed:) searchSelector:nil];
    firstToolbar.items[0].enabled = NO; // disable prev button
    self.textField.inputAccessoryView = firstToolbar;
    
    // add toolbar to second textfield
    PrevNextSearchToolbarView *secondToolbar = [[PrevNextSearchToolbarView alloc]initWithSelectors:@selector(prevButtonPressed:) nextSelector:@selector(nextButtonPressed:) searchSelector:nil];
    self.textFieldTwo.inputAccessoryView = secondToolbar;
    
    // add toolbar to third textfield
    PrevNextSearchToolbarView *thirdToolbar = [[PrevNextSearchToolbarView alloc]initWithSelectors:@selector(prevButtonPressed:) nextSelector:@selector(nextButtonPressed:) searchSelector:@selector(buttonPressed:)];
    thirdToolbar.items[1].enabled = NO; // disable next button
    self.textFieldThree.inputAccessoryView = thirdToolbar;
}

-(void)configureView {
    // round center view
    self.centerView.layer.cornerRadius = 20;
    self.centerView.layer.masksToBounds = YES;
    self.centerView.layer.opacity = 0.97f;
    
    // used to determine which text field is next and previous when using the toolbar
    self.currTextField = 0;
    self.textFieldArr = @[self.textField, self.textFieldTwo, self.textFieldThree];
    
    // add image to backround
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.backgroundImageName]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
   // [self addToolbars];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end