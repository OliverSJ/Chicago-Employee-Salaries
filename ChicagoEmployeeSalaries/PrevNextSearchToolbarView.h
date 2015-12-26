//
//  PrevNextSearchView.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/23/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrevNextSearchToolbarView : UIToolbar

@property (strong, nonatomic) PrevNextSearchToolbarView *toolBar;
@property (strong, nonatomic) UIBarButtonItem *prevButton;
@property (strong, nonatomic) UIBarButtonItem *nextButton;
@property (strong, nonatomic) UIBarButtonItem *searchButton;
- (instancetype)initWithSelectors:(SEL)prevSelector nextSelector:(SEL)nextSelector searchSelector:(SEL)searchSelector;

@end
