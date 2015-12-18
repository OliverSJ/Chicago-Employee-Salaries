//
//  DataTier.h
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTier : NSObject

@property NSString *baseUrl;
@property NSArray *jsonArr;

- (instancetype)initWithBaseUrl:(NSString*)url;

-(NSArray*)executeQuery:(NSString*)url;
-(NSArray*)parseData:(NSData *)responseData;
-(NSString*)convertToHttpURL:(NSString *)query;

@end