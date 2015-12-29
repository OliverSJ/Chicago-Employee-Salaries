//
//  Google:Analytics.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/27/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#ifndef Google_Analytics_h
#define Google_Analytics_h

#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

#endif /* Google_Analytics_h */

@interface UIView(GoogleAnalytics)

-(void) addGoogleAnalytics:(NSString*)screenName;
-(void) addGoogleAnalyticsEvent:(NSString *)screenName createEventWithCategory:(NSString*)category action:(NSString*)action label:(NSString*)label;

@end
