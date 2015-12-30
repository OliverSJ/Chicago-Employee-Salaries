//
//  GoogleAnalytics.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/28/15.
//  Copyright © 2015 ChiSalary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleAnalytics.h"

@implementation UIView(GoogleAnalytics)

-(void) addGoogleAnalytics:(NSString*)screenName {
    
    @try {
        if([[GAI sharedInstance]optOut] == NO){
            
            id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
            [tracker set:kGAIScreenName value:@"Department"];
            [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
            
        }
    }
    @catch (NSException *exception) {
        // no google analytics declared, user opted out most likely
    }
}

-(void) addGoogleAnalyticsEvent:(NSString *)screenName createEventWithCategory:(NSString*)category action:(NSString*)action label:(NSString*)label {
    
    @try {
        if([[GAI sharedInstance]optOut] == NO){
            
            // send google analytics info about which type of search being performed
            id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
            
            [tracker set:kGAIScreenName value:@"Search"];
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                                  action:action
                                                                   label:label
                                                                   value:nil] build]];
            [tracker set:kGAIScreenName value:nil];
        }
    }
    @catch (NSException *exception) {
        // no google analytics declared, user opted out most likely
    }
}

@end
