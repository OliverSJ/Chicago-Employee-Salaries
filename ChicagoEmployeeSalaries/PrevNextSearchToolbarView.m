//
//  PrevNextSearchView.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/23/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "PrevNextSearchToolbarView.h"

@implementation PrevNextSearchToolbarView

/** 
 @brief Initialize this toolbar with action selectors.
 @param prevSelector Action selector for previous arrow button.
 @param nextSelector Action selector for next arrow button.
 @param searchSelector Action selector for search button.
 */
- (instancetype)initWithSelectors:(SEL)prevSelector nextSelector:(SEL)nextSelector searchSelector:(SEL)searchSelector
{
    self.toolBar = [super init];
    if (self) {
        [self configureView:prevSelector actionTwo:nextSelector action3:searchSelector];
    }
    return self.toolBar;
}

- (void)configureView:(SEL)act1 actionTwo:(SEL)act2 action3:(SEL)act3 {
    
    NSMutableArray *items = [[NSMutableArray alloc]init];
    
    self.toolBar= [[PrevNextSearchToolbarView alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [self.toolBar setBarStyle:UIBarStyleDefault];
    
    // previous button
    if (act1 != nil) {
        self.prevButton = [[UIBarButtonItem alloc]
                           initWithImage:[UIImage imageNamed:@"BackIcon"]
                           style:UIBarButtonItemStylePlain
                           target:self
                           action:act1];
        [items addObject:self.prevButton];
    }
    
    // next button
    if (act2 != nil) {
        self.nextButton = [[UIBarButtonItem alloc]
                           initWithImage:[UIImage imageNamed:@"NextIcon"]
                           style:UIBarButtonItemStylePlain
                           target:self
                           action:act2];
        [items addObject:self.nextButton];

    }
    
    // middle space between left and right buttons
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [items addObject:flex];
    
    // search button
    if (act3 != nil) {
        self.searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                          target:self
                                                                          action:act3];
        [items addObject:self.searchButton];
    }
    
    if (items.count > 0) {
        self.toolBar.items = items;
    }
}

@end
