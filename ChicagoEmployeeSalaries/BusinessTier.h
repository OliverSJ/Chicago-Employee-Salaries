//
//  BusinessTier.h
//  ChicagoEmployeeSalaries
//
//  Created by Oliver San Juan on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessTierRules.h"
#import "DataTier.h"

@interface BusinessTier : NSObject <BusinessTierRules>

@property NSString* baseUrl;
@property DataTier* dt;
@property NSString* query;
@property NSArray *jsonResponse;

@end
