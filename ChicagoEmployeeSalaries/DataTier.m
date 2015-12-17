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

-(NSString*)queryToURL:(NSString *)query{
    
    // replace all % signs with %25
    query = [query stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
    
    // replace all spaces
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    // replace all 's with %27
    query = [query stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
    
    // init full url
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@", self.baseUrl, query];
    
    return fullUrl;
}

// Prepare the link that is going to be used on the GET request
-(NSArray*)executeQuery:(NSString*)query{
    
    NSString *url = [self queryToURL:query];
    
    // Make asynchronous request
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                self.jsonArr = [[self parseData:data] copy];
                
            }] resume];
    
    //TODO Remove this line when used in iOS APP
    [NSThread sleepForTimeInterval:5.0f]; // sleep for 1 second to allow for async response
    
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

-(NSArray*)searchByFirstName:(NSString *)firstName{
    // do nothing yet
    return nil;
}

@end
