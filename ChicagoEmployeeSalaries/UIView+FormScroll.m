//
//  UIView+FormScroll.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/20/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

/** This method is used to scroll the window without having to use
 the UIScrollBar object */
#import "UIView+FormScroll.h"

@implementation UIView (FormScroll)

///*************************************************
// EXAMPLE USE
// *************************************************/
//
//- (IBAction)textFieldDidBeginEditing:(id)sender {
//
//    UITextField *textField = (UITextField*)sender;
//
//    [self.view scrollToView:textField];
//}
//
//- (IBAction)textFieldDidEndEditing:(id)sender {
//
//    [self.view scrollToY:0];
//}

-(void)scrollToY:(float)y
{
    
    [UIView beginAnimations:@"registerScroll" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4];
    self.transform = CGAffineTransformMakeTranslation(0, y);
    [UIView commitAnimations];
    
}

-(void)scrollToView:(UIView *)view
{
    
    CGRect theFrame = view.frame;
    float y = theFrame.origin.y + 150;
    y -= (y/1.7);
    [self scrollToY:-y];
}

-(void)scrollElement:(UIView *)view toPoint:(float)y
{
    CGRect theFrame = view.frame;
    float orig_y = theFrame.origin.y;
    float diff = y - orig_y;
    if (diff < 0) {
        [self scrollToY:diff];
    }
    else {
        [self scrollToY:0];
    }
    
}

@end
