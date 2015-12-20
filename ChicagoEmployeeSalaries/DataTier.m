//
//  DataTier.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "DataTier.h"

@implementation DataTier

// Creates init method to instantiate a DataTier object with
// a base url. This method must be used in place of
// the standard init.
- (instancetype)initWithBaseUrl:(NSString*)url
{
    self = [super init];
    if (self) {
        self.baseUrl = url;
    }
    return self;
}

// Converts a standard SODA query URL to a HTTP friendly URL
-(NSString*)convertToHttpURL:(NSString *)query{
    
    // replace all percent signs with %25
    query = [query stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
    
    // replace all spaces with %20
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    // replace all apostrophes with %27
    query = [query stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
    
    // init full url
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@", self.baseUrl, query];
    
    return fullUrl;
}

// Prepare the link that is going to be used on the GET request
-(NSArray*)executeQuery:(NSString*)query{
    
    NSString *url = [self convertToHttpURL:query];
    
    // Send a synchronous request
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    // sets response arr
    if (error == nil) {
        self.jsonArr = [[self parseData:data] copy];
        return self.jsonArr;
    }
    
    // an error has occured, return nil
    else {
        return nil;
    }
}

// Parses the data and returns and array of deictionary
// objects with key value pairs corresponding to the data
// retrieved
-(NSArray*)parseData:(NSData *)responseData
{
    NSError *error = nil;
    
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"Error parsing JSON.");
        return nil;
    }
    
    return dataArr;
}

@end
