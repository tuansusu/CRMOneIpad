//
//  HttpLoader.m
//  KunKun
//
//  Created by PTSPM_HIEUNQ1 on 7/18/11.
//  Copyright 2011 Trung tâm phần mềm Viettel. All rights reserved.
//

#import "HttpLoader.h"
#import "NetworkUtils.h"
#import "NetworkEngine.h"
#import "FrameworkAppDelegate.h"
#import "Constants.h"
#import "ActionEvent.h"
#import "NSMutableDictionary-(KunKun).h"

#ifdef OAUTH
#import "OADataFetcher.h"
#endif

#define MAX_REQUEST 1
#define MAX_REQUEST_TRACKING 3
#define TIMEOUT_JSON 30
#define TIMEOUT_MULTIPART 90

@implementation HttpLoader

@synthesize receivedData;
@synthesize httpConnection;
@synthesize httpRequest;
@synthesize httpResponse;
@synthesize requestCount;



#ifndef OAUTH
- (id) initWithRequest: (HTTPRequest*) httprequest {
	if (self = [super init]) {
		
		self.httpRequest = httprequest;
		httpResponse = [httpRequest createHTTPResponse];
		httpResponse.tag = httpRequest.tag;
		httpResponse.action = httpRequest.action;
		httpResponse.identifier = httpRequest.identifier;
		httpResponse.userData = httpRequest.userData;
		
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		requestCount = 1;
		
		NSString *urlString = httpRequest.uri;
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
		[request setURL:[NSURL URLWithStringReplaceSpace:urlString]];
		//set headers
		[request addValue: httpRequest.contentType forHTTPHeaderField: @"Content-Type"];
		[request addValue: @"Iphone client 1.0" forHTTPHeaderField: @"User-Agent"];
        
        IphoneFrameworkAppDelegate *kunkunAppDelegate = (IphoneFrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
		if(kunkunAppDelegate.profile.userToken != nil) {
			[requestOAuth addValue: kunkunAppDelegate.profile.userToken forHTTPHeaderField: @"UserToken"];
		}
        if(kunkunAppDelegate.profile.sessionId != nil) {
             NSLog(@" 62 Cookie = %@", kunkunAppDelegate.profile.sessionId);
			[requestOAuth addValue: kunkunAppDelegate.profile.sessionId forHTTPHeaderField: @"Cookie"];
		}
        
		if (httpRequest.method == GET) {
			[request setHTTPMethod:@"GET"];
		}
		else if (httpRequest.method == POST){
			[request setHTTPMethod:@"POST"];
			[request setHTTPBody: httpRequest.data];
		}
        if ([httpRequest.contentType isEqualToString: [NetworkUtils getJsonContentType]]) {
			if (((ActionEvent*) httpRequest.userData).action == actionDigitalDocument) {
                [requestOAuth setTimeoutInterval: TIMEOUT_JSON*16];
            }else{
                [requestOAuth setTimeoutInterval: TIMEOUT_JSON];
            }
		}
//		if ([httpRequest.contentType isEqualToString: [NetworkUtils getJsonContentType]]) {
//			[request setTimeoutInterval: TIMEOUT_JSON];
//		}
		if ([httpRequest.contentType isEqualToString: [NetworkUtils getMultipartContentType]]) {
			[request setTimeoutInterval: TIMEOUT_MULTIPART];
		}
		httpConnection = [[NSURLConnection alloc] initWithRequest: request delegate: self startImmediately:YES];
		[request release];
		
		[pool release];
	}
	return self;
}
#else
- (id) initWithRequest: (HTTPRequest*) httprequest {
	if (self = [super init]) {
		
		self.httpRequest = httprequest;
		httpResponse = [httpRequest createHTTPResponse];
		httpResponse.tag = httpRequest.tag;
		httpResponse.action = httpRequest.action;
		httpResponse.identifier = httpRequest.identifier;
		httpResponse.userData = httpRequest.userData;
		
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		requestCount = 1;
		
		NSString *urlString = httpRequest.uri;
		OAMutableURLRequest *requestOAuth = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithStringReplaceSpace:urlString]
												  consumer:[NetworkEngine getHttpClient].consumer
													 token:[NetworkEngine getHttpClient].accessToken
													 realm:nil
										 signatureProvider:nil];
        
        //set headers
		[requestOAuth addValue: httpRequest.contentType forHTTPHeaderField: @"Content-Type"];
		[requestOAuth addValue: @"Iphone client 1.0" forHTTPHeaderField: @"User-Agent"];
		
		FrameworkAppDelegate *kunkunAppDelegate = (FrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
		if(kunkunAppDelegate.userToken != nil && [kunkunAppDelegate.userToken length] > 0) {
			[requestOAuth addValue: kunkunAppDelegate.userToken forHTTPHeaderField: @"UserToken"];
		}
        if(kunkunAppDelegate.sessionId != nil && [kunkunAppDelegate.sessionId length] > 0) {
            
            //NSLog(@"httpLoader:125 Cookie = %@", kunkunAppDelegate.sessionId);
            
			[requestOAuth addValue: kunkunAppDelegate.sessionId forHTTPHeaderField: @"Cookie"];
		}
        
		if (httpRequest.method == GET) {
			[requestOAuth setHTTPMethod:@"GET"];
		}
		else if (httpRequest.method == POST){
			[requestOAuth setHTTPMethod:@"POST"];
			[requestOAuth setHTTPBody: httpRequest.data];
		}
//		if ([httpRequest.contentType isEqualToString: [NetworkUtils getJsonContentType]]) {
//			[requestOAuth setTimeoutInterval: TIMEOUT_JSON];
//		}
        
        if ([httpRequest.contentType isEqualToString: [NetworkUtils getJsonContentType]]) {
			if (((ActionEvent*) httpRequest.userData).action == actionDigitalDocument) {
                [requestOAuth setTimeoutInterval: TIMEOUT_JSON*16];
            }else{
                [requestOAuth setTimeoutInterval: TIMEOUT_JSON];
            }
		}
		if ([httpRequest.contentType isEqualToString: [NetworkUtils getMultipartContentType]]) {
			[requestOAuth setTimeoutInterval: TIMEOUT_MULTIPART];
		}
		OAAsynchronousDataFetcher *fetcher = [OAAsynchronousDataFetcher asynchronousFetcherWithRequest:requestOAuth 
																   delegate:self 
														  didFinishSelector:nil 
															didFailSelector:nil];
		
		[fetcher start];
		[requestOAuth release];
		
		[pool release];
	}
	return self;
}

- (id) initWithRequestPayment: (HTTPRequest*) httprequest {
	if (self = [super init]) {
		
		self.httpRequest = httprequest;
		httpResponse = [httpRequest createHTTPResponse];
		httpResponse.tag = httpRequest.tag;
		httpResponse.action = httpRequest.action;
		httpResponse.identifier = httpRequest.identifier;
		httpResponse.userData = httpRequest.userData;
		
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		requestCount = 1;
		
		NSString *urlString = httpRequest.uri;
		OAMutableURLRequest *requestOAuth = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithStringReplaceSpace:urlString]
																			consumer:[NetworkEngine getHttpClient].consumer
																			   token:[NetworkEngine getHttpClient].accessToken
																			   realm:nil
																   signatureProvider:nil];
		
		//set headers
		[requestOAuth addValue: httpRequest.contentType forHTTPHeaderField: @"Content-Type"];
		[requestOAuth addValue: @"Iphone client 1.0" forHTTPHeaderField: @"User-Agent"];
		
		FrameworkAppDelegate *kunkunAppDelegate = (FrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
		if(kunkunAppDelegate.userToken != nil && [kunkunAppDelegate.userToken length] > 0) {
			[requestOAuth addValue: kunkunAppDelegate.userToken forHTTPHeaderField: @"UserToken"];
		}
        if(kunkunAppDelegate.sessionId != nil && [kunkunAppDelegate.sessionId length] > 0) {
			[requestOAuth addValue: kunkunAppDelegate.sessionId forHTTPHeaderField: @"Cookie"];
		}
        
		if (httpRequest.method == GET) {
			[requestOAuth setHTTPMethod:@"GET"];
		}
		else if (httpRequest.method == POST){
			[requestOAuth setHTTPMethod:@"POST"];
			[requestOAuth setHTTPBody: httpRequest.data];
		}
		if ([httpRequest.contentType isEqualToString: [NetworkUtils getJsonContentType]]) {
			[requestOAuth setTimeoutInterval: 480.0];
		}
		if ([httpRequest.contentType isEqualToString: [NetworkUtils getMultipartContentType]]) {
			[requestOAuth setTimeoutInterval: 480.0];
		}
		OAAsynchronousDataFetcher *fetcher = [OAAsynchronousDataFetcher asynchronousFetcherWithRequest:requestOAuth 
																							  delegate:self 
																					 didFinishSelector:nil 
																					   didFailSelector:nil];
		
		[fetcher start];
		[requestOAuth release];
		
		[pool release];
	}
	return self;
}

#endif

//#ifdef OAUTH
//- (void) reRequest {
//	[httpConnection release], httpConnection = nil;
//	[receivedData release], receivedData = nil;
//	
//	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//	
//	requestCount ++;
//	
//	NSString *urlString = httpRequest.uri;
////	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
////	[request setURL:[NSURL URLWithStringReplaceSpace:urlString]];
//	OAMutableURLRequest *requestOAuth = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithStringReplaceSpace:urlString]
//																		consumer:[NetworkEngine getHttpClient].consumer
//																		   token:[NetworkEngine getHttpClient].accessToken
//																		   realm:nil
//															   signatureProvider:nil];
//	//set headers
//	[requestOAuth addValue: httpRequest.contentType forHTTPHeaderField: @"Content-Type"];
//	[requestOAuth addValue: @"Iphone client 1.0" forHTTPHeaderField: @"User-Agent"];
//	[requestOAuth addValue: httpRequest.cookie forHTTPHeaderField: @"Cookie"];
//	KunKunAppDelegate *kunkunAppDelegate = (KunKunAppDelegate*)[[UIApplication sharedApplication] delegate];
//	if(kunkunAppDelegate.profile.sessionId != nil) {
//		[requestOAuth addValue: kunkunAppDelegate.profile.sessionId forHTTPHeaderField: @"UserToken"];
//	}
//	if (httpRequest.method == GET) {
//		[requestOAuth setHTTPMethod:@"GET"];
//	}
//	else if (httpRequest.method == POST){
//		[requestOAuth setHTTPMethod:@"POST"];
//		[requestOAuth setHTTPBody: httpRequest.data];
//	}
//	if ([httpRequest.contentType isEqualToString: [NetworkUtils getJsonContentType]]) {
//		[requestOAuth setTimeoutInterval: TIMEOUT_JSON];
////		[self performSelector:@selector(cancelLoading)
////				   withObject:nil
////				   afterDelay: TIMEOUT_JSON];
//	}
//	if ([httpRequest.contentType isEqualToString: [NetworkUtils getMultipartContentType]]) {
//		[requestOAuth setTimeoutInterval: TIMEOUT_MULTIPART];
////		[self performSelector:@selector(cancelLoading)
////				   withObject:nil
////				   afterDelay: TIMEOUT_MULTIPART];
//	}
//	OAAsynchronousDataFetcher *fetcher = [OAAsynchronousDataFetcher asynchronousFetcherWithRequest:requestOAuth 
//																						  delegate:self 
//																				 didFinishSelector:nil 
//																				   didFailSelector:nil];
//	
//	[fetcher start];
//	[requestOAuth release];
//	
//	[pool release];
//}
//#else
//- (void) reRequest {
//	[httpConnection release], httpConnection = nil;
//	[receivedData release], receivedData = nil;
//	
//	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//	
//	requestCount ++;
//	
//	NSString *urlString = httpRequest.uri;
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//	[request setURL:[NSURL URLWithStringReplaceSpace:urlString]];
//	//set headers
//	[request addValue: httpRequest.contentType forHTTPHeaderField: @"Content-Type"];
//	[request addValue: @"Iphone client 1.0" forHTTPHeaderField: @"User-Agent"];
//	[request addValue: httpRequest.cookie forHTTPHeaderField: @"Cookie"];
//	if (httpRequest.method == GET) {
//		[request setHTTPMethod:@"GET"];
//	}
//	else if (httpRequest.method == POST){
//		[request setHTTPMethod:@"POST"];
//		[request setHTTPBody: httpRequest.data];
//	}
//	if ([httpRequest.contentType isEqualToString: [NetworkUtils getJsonContentType]]) {
//		[request setTimeoutInterval: TIMEOUT_JSON];
////		[self performSelector:@selector(cancelLoading)
////				   withObject:nil
////				   afterDelay: TIMEOUT_JSON];
//	}
//	if ([httpRequest.contentType isEqualToString: [NetworkUtils getMultipartContentType]]) {
//		[request setTimeoutInterval: TIMEOUT_MULTIPART];
////		[self performSelector:@selector(cancelLoading)
////				   withObject:nil
////				   afterDelay: TIMEOUT_MULTIPART];
//	}
//	httpConnection = [[NSURLConnection alloc] initWithRequest: request delegate: self startImmediately:YES];
//	[request release];
//	
//	[pool release];
//}
//#endif
//
//- (void)cancelLoading
//{
//	[httpConnection cancel];
//	
//	if (httpRequest.action == 404) {
//		if (requestCount < MAX_REQUEST_TRACKING) {
//			[self reRequest];
//			return;
//		} 
//	} else {
//		if (requestCount < MAX_REQUEST) {
//			[self reRequest];
//			return;
//		}
//	}
//	
//	httpResponse.resCode = -1001;
//	if(httpRequest.observer != nil) {
//		[self performSelectorOnMainThread:@selector(handleReceiveError) withObject: nil waitUntilDone:NO];
//	}
//	
//	[httpConnection release], httpConnection = nil;
//	[receivedData release], receivedData = nil;
//	
//}

#pragma mark NSURL Loading

/**
 * handle https delegate
 */
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)space {
	if([[space authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        return YES; // Self-signed cert will be accepted
	}
	// If no other authentication is required, return NO for everything else
	// Otherwise maybe YES for NSURLAuthenticationMethodDefault and etc.
	return NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])			[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

/**
 * end handle https delegate
 */

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response
{
	[receivedData release], receivedData = nil;
	receivedData = [[NSMutableData alloc] init];
	NSHTTPURLResponse* urlResponse = (NSHTTPURLResponse *)response;  
	httpResponse.resCode = [urlResponse statusCode];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	httpResponse.data = receivedData;
	if(httpRequest.observer != nil) {
		if (httpResponse != nil) {
			if(httpResponse.resCode != 200)
			{
				if (httpRequest.action == 404) {
					if (requestCount < MAX_REQUEST_TRACKING) {
						[self reRequest];
						return;
					} 
				}
				if(httpRequest.observer != nil) {
					[self handleReceiveError];
				}
			} else {
				if(httpRequest.observer != nil) {
					[self handleReceiveData];
				}
			}
		} else {
			if (httpRequest.action == 404) {
				if (requestCount < MAX_REQUEST_TRACKING) {
					[self reRequest];
					return;
				} 
			}
			if(httpRequest.observer != nil) {
				[self handleReceiveError];
			}
		}
	}
	[httpConnection release];
	httpConnection = nil;
	if (receivedData)
	{	
		[receivedData release]; 
		receivedData = nil;
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *) error
{
	if (httpRequest.action == 404) {
		if (requestCount < MAX_REQUEST_TRACKING) {
			[self reRequest];
			return;
		} 
	}
    
	httpResponse.resCode = [error code];
	if(httpRequest.observer != nil) {
		[self handleReceiveError];
	}
	[httpConnection release];
	httpConnection = nil;
	[receivedData release];
	receivedData = nil;
	
}
-(void) reRequest{
    
}



#pragma mark Properties

-(void) handleReceiveData {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	@try{
		if (httpRequest.observer) {
			[httpRequest.observer onHttpReceivedData: httpResponse];
			[httpResponse release];
			[httpRequest release];
			httpRequest = nil;
			httpResponse = nil;
		}
	}@catch (NSException *e) {
        [LogUtil writeLogWithException:e];
	}
	[pool release];
}

- (void) handleReceiveError {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	@try{
#ifdef LOG_ERROR
		if (httpRequest.userData) {
			if (httpRequest.action != 404) {
				HTTPRequest *req = [self getTrackingRequest];
				[[NetworkEngine getHttpClient] request: req];
				[req release];
			}
		}
#endif
#ifdef OAUTH
		if(httpResponse.resCode == 500 || httpResponse.resCode == 401) {
			if(![NetworkEngine getHttpClient].isRetryAfterOAuthTimeout) {
				[NetworkEngine getHttpClient].isRetryAfterOAuthTimeout = YES;
				// retry request include OAuth request
				// reset accessToken
				[[NetworkEngine getHttpClient] resetOAuth];
				// request
				[[NetworkEngine getHttpClient] request:httpRequest];
			} else {
				[[NetworkEngine getHttpClient] enQueue:httpRequest];
			}
			return;
			// end
		}
#endif
        
        if(httpResponse.resCode == Code_TimeOut) {
            [httpRequest.observer onHttpReceivedError: httpResponse: SYS_TimeOut];
			[httpResponse release];
			[httpRequest release];
			httpRequest = nil;
			httpResponse = nil;
            
			return;
			// end
		}
        
		if (httpRequest.observer) {
			[httpRequest.observer onHttpReceivedError: httpResponse: @"Không thể kết nối với máy chủ."];
			[httpResponse release];
			[httpRequest release];
			httpRequest = nil;
			httpResponse = nil;
		}
	}@catch (NSException *e) {
        [LogUtil writeLogWithException:e];
	}
	[pool release];
}

- (void) dealloc
{
	if (receivedData) {
		[receivedData release];
		receivedData = nil;
	}

	if (httpConnection) {
		[httpConnection release];
		httpConnection = nil;
	}
	
	if (httpRequest) {
		[httpRequest release];
		httpRequest = nil;
	}
	
	if (httpResponse) {
		[httpResponse release];
		httpResponse = nil;
	}

	[super dealloc];
}


@end
