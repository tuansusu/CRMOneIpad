//
//  RequestHelper.m
//  NMC_iOS
//
//  Created by Nong Nghia on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RequestHelper.h"
#import "AFNetworking.h"
#import "CustomOperationQueue.h"

@implementation RequestHelper


+ (void)requestWithURL:(NSURL*)_URL
                method:(HttpMethod)_method
                params:(NSDictionary*)_params
               success:(void (^)(id result))success
               failure:(void (^)(NSError *error))failure
{
    NSMutableURLRequest *urlRequest=[[NSMutableURLRequest alloc] initWithURL:_URL ] ;
    [urlRequest setTimeoutInterval:10.0];
    
    [urlRequest setHTTPMethod:[self methodAtIndex:_method]];
    
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (_params!=nil) {
        NSData * jSonData=[NSJSONSerialization dataWithJSONObject:_params options:NSJSONReadingMutableLeaves error:nil];
        [urlRequest addValue:[NSString stringWithFormat:@"%d",jSonData.length] forHTTPHeaderField:@"Content-Length"];
        [urlRequest setHTTPBody:jSonData];
    }
    
    AFHTTPRequestOperation *rOperation=[[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [rOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(error);
        }
        
    }];
    [[CustomOperationQueue sharedInstance] addOperation:rOperation];
}
+(NSString*)methodAtIndex:(HttpMethod)_method{
    static NSArray *array;
    if (!array) {
        array=[[NSArray alloc] initWithObjects:
               @"GET",
               @"POST",
               @"PUT",
               @"DELETE",
               nil];
    }
    return [array objectAtIndex:_method];
}


@end
