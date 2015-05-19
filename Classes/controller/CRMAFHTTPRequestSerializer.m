//
//  CRMAFHTTPRequestSerializer.m
//  OfficeOneMB
//
//  Created by admin on 5/13/15.
//
//

#import "CRMAFHTTPRequestSerializer.h"



@implementation CRMAFHTTPRequestSerializer

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
{
    NSMutableURLRequest *request = [super requestWithMethod:method URLString:URLString parameters:parameters];
    [request setTimeoutInterval:CONFIG_REQUEST_TIMEOUT];
    
    return request;
}

@end
