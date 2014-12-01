//
//  HTTPEngine.m
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import "HTTPEngine.h"
//library
#import <CoreFoundation/CoreFoundation.h>
#import <CoreFoundation/CFStream.h>
#import <CFNetwork/CFHTTPStream.h>
#import <CFNetwork/CFHTTPMessage.h>
#import <CoreFoundation/CFString.h>
//user defined
#import "HTTPRequest.h"
#import "HTTPResponse.h"
#import "HTTPClient.h"
#import "NetworkUtils.h"

#define kReadBufSize 1024

@implementation HTTPEngine
- (id) initWithHTTPClient: (HTTPClient*) aHTTPClient {
	if (self = [super init]) {
		httpClient = aHTTPClient;
	}
	return self;
}

- (id) init {
    self = [super init];
	[self initWithHTTPClient:nil];
	return self;
}

- (BOOL)checkURL:(NSString*)url{
	NSRange rangeOfString = [url rangeOfString:@"\\"];
	if(rangeOfString.location != NSNotFound)
		return FALSE;
	else {
		rangeOfString = [url rangeOfString:@"http://"];
		if(rangeOfString.location == NSNotFound)
			return FALSE;
		else{
			rangeOfString = [url rangeOfString:@" "];
			if(rangeOfString.location != NSNotFound)
				return FALSE;
			else {
				rangeOfString = [url rangeOfString:@"("];
				if(rangeOfString.location != NSNotFound)
					return FALSE;
				return TRUE;
			}
			return TRUE;
		}
		
		
	}
	
}

- (HTTPResponse*) request:(HTTPRequest*) httpRequest
{
	if (! httpRequest) {
		return nil;
	}

	HTTPResponse* httpResponse = [httpRequest createHTTPResponse];
	for (int i = 0;  i < 2;  i++) {
		@try {
			//prepar request
			NSString *urlString = httpRequest.uri;
			NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
			[request setTimeoutInterval: 480.0];
			[request setURL:[NSURL URLWithStringReplaceSpace:urlString]];
			//set headers
			[request addValue: httpRequest.contentType forHTTPHeaderField: @"Content-Type"];
			if ([httpRequest.contentType isEqualToString: [NetworkUtils getJsonContentType]]) {
				[request setTimeoutInterval: 480.0];
			}
			if ([httpRequest.contentType isEqualToString: [NetworkUtils getMultipartContentType]]) {
				[request setTimeoutInterval: 480.0];
			}
			[request addValue: httpClient.userAgent forHTTPHeaderField: @"User-Agent"];
			[request addValue: httpRequest.cookie forHTTPHeaderField: @"Cookie"];
			if (httpRequest.method == GET) {
				[request setHTTPMethod:@"GET"];
			}
			else if (httpRequest.method == POST){
				[request setHTTPMethod:@"POST"];
				[request setHTTPBody: httpRequest.data];
			}
			//get response
			NSHTTPURLResponse* urlResponse = nil;  
			NSError *error = [[NSError alloc] init];
			NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];  
			if ( error ) {
				[error release];
				[request release];
				
				httpResponse.resCode = [error code];
				httpResponse.tag = httpRequest.tag;
				httpResponse.action = httpRequest.action;
				httpResponse.identifier = httpRequest.identifier;
				httpResponse.userData = httpRequest.userData;
				continue;
			}
			[error release];
			[request release];
			if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
				
				NSMutableData *data = [[NSMutableData alloc] init];
				[data appendData: responseData];
				httpResponse.data = data;
				[data release];
				httpResponse.resCode = [urlResponse statusCode];
				httpResponse.tag = httpRequest.tag;
				httpResponse.action = httpRequest.action;
				httpResponse.identifier = httpRequest.identifier;
				httpResponse.userData = httpRequest.userData;		
				return httpResponse;
			} else {
				
				NSMutableData *data = [[NSMutableData alloc] init];
				[data appendData: responseData];
				httpResponse.data = data;
				[data release];
				httpResponse.resCode = [urlResponse statusCode];
				httpResponse.tag = httpRequest.tag;
				httpResponse.action = httpRequest.action;
				httpResponse.identifier = httpRequest.identifier;
				httpResponse.userData = httpRequest.userData;	
				continue;
			}
		}
		@catch (NSException * e) {
			httpResponse.resCode = 504;
			httpResponse.tag = httpRequest.tag;
			httpResponse.action = httpRequest.action;
			httpResponse.identifier = httpRequest.identifier;
			httpResponse.userData = httpRequest.userData;	
			continue;
		}
		
		

	}
	return httpResponse;
}

- (HTTPResponse*) requestPayment:(HTTPRequest*) httpRequest
{
	if (! httpRequest) {
		return nil;
	}
	
	HTTPResponse* httpResponse = [httpRequest createHTTPResponse];
	for (int i = 0;  i < 2;  i++) {
		@try {
			//prepar request
			NSString *urlString = httpRequest.uri;
			NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
			[request setTimeoutInterval: 480.0];
			[request setURL:[NSURL URLWithStringReplaceSpace:urlString]];
			//set headers
			[request addValue: httpRequest.contentType forHTTPHeaderField: @"Content-Type"];
			if ([httpRequest.contentType isEqualToString: [NetworkUtils getJsonContentType]]) {
				[request setTimeoutInterval: 480.0];
			}
			if ([httpRequest.contentType isEqualToString: [NetworkUtils getMultipartContentType]]) {
				[request setTimeoutInterval: 480.0];
			}
			[request addValue: httpClient.userAgent forHTTPHeaderField: @"User-Agent"];
            
			[request addValue: httpRequest.cookie forHTTPHeaderField: @"Cookie"];
			if (httpRequest.method == GET) {
				[request setHTTPMethod:@"GET"];
			}
			else if (httpRequest.method == POST){
				[request setHTTPMethod:@"POST"];
				[request setHTTPBody: httpRequest.data];
			}
			//get response
			NSHTTPURLResponse* urlResponse = nil;  
			NSError *error = [[NSError alloc] init];
			NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];  
			if ( error ) {
				[error release];
				[request release];
				
				httpResponse.resCode = [error code];
				httpResponse.tag = httpRequest.tag;
				httpResponse.action = httpRequest.action;
				httpResponse.identifier = httpRequest.identifier;
				httpResponse.userData = httpRequest.userData;
				continue;
			}
			[error release];
			[request release];
			if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
				
				NSMutableData *data = [[NSMutableData alloc] init];
				[data appendData: responseData];
				httpResponse.data = data;
				[data release];
				httpResponse.resCode = [urlResponse statusCode];
				httpResponse.tag = httpRequest.tag;
				httpResponse.action = httpRequest.action;
				httpResponse.identifier = httpRequest.identifier;
				httpResponse.userData = httpRequest.userData;		
				return httpResponse;
			} else {
				
				NSMutableData *data = [[NSMutableData alloc] init];
				[data appendData: responseData];
				httpResponse.data = data;
				[data release];
				httpResponse.resCode = [urlResponse statusCode];
				httpResponse.tag = httpRequest.tag;
				httpResponse.action = httpRequest.action;
				httpResponse.identifier = httpRequest.identifier;
				httpResponse.userData = httpRequest.userData;	
				continue;
			}
		}
		@catch (NSException * e) {
			httpResponse.resCode = 504;
			httpResponse.tag = httpRequest.tag;
			httpResponse.action = httpRequest.action;
			httpResponse.identifier = httpRequest.identifier;
			httpResponse.userData = httpRequest.userData;	
			continue;
		}
		
	}
	return httpResponse;
}

- (void) dealloc {
	[httpClient release];
	[super dealloc];
}


@end
