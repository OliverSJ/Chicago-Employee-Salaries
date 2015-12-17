//
//  DataTier.m
//  ChicagoEmployeeSalaries
//
//  Created by Bradley Golden on 12/16/15.
//  Copyright © 2015 Oliver San Juan. All rights reserved.
//

#import "DataTier.h"

@implementation DataTier

- (instancetype)initWithBaseUrl:(NSString*)url
{
    self = [super init];
    if (self) {
        _baseUrl = url;
    }
    return self;
}

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
    
    // Make asynchronous request
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                self.jsonArr = [[self parseData:data] copy];
                
            }] resume];
    
    //TODO Remove this line when used in iOS APP - Only used for DEBUGGING
    //[NSThread sleepForTimeInterval:5.0f]; // sleep for 1 second to allow for async response
    
    return self.jsonArr;
}

-(NSArray*)parseData:(NSData *)responseData
{
    NSError *error = nil;
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"Error parsing JSON.");
        return nil;
    }
    
    return jsonArray;
}

@end
