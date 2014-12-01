//
//  HTTPRequest.m
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import "HTTPRequest.h"
#import "Constants.h"

@implementation HTTPRequest

@synthesize observer;
@synthesize method;
@synthesize uri;
@synthesize cookie;
@synthesize contentType;

-(id)init
{
    if (self = [super init])
    {
		// Initialization code here
		observer = nil;
		method = 0;
		self.contentType = @"";
        //VOFFICE_REQUEST_PATH
		//uri = [LogUtil getRequestPath];
        //uri=  [GlobalVars sharedInstance].serviceUrl;
        //NSLog(@"uri = init http request = %@", uri);
		self.cookie = @"";
    }
    return self;
}

-(void) dealloc
{
//    if (uri) {
//        [uri release];uri = nil;
//    }
	[uri release];
	[cookie release];
	[contentType release];
	[super dealloc];
}

- (HTTPResponse*) createHTTPResponse
{
	HTTPResponse* httpResponse = [[HTTPResponse alloc] init];
	httpResponse.action = self.action;
	httpResponse.identifier = self.identifier;
	httpResponse.request = self;
	return httpResponse;
}
@end
