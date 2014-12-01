//
//  HTTPClient.m
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import "HTTPClient.h"
#import "HttpLoader.h"
#import "AbstractModelService.h"
#import "ModelEvent.h"


#ifdef OAUTH
#import "Constants.h"
#import "OADataFetcher.h"
#endif

@implementation HTTPClient
@synthesize userAgent;
//@synthesize arrWaitingRequest;
@synthesize webView;

#ifdef OAUTH
@synthesize consumer;
@synthesize accessToken;
@synthesize hasValidToken;
@synthesize isRetryAfterOAuthTimeout;
#endif

@synthesize isRetryAfterSessionTimeOut;


static HTTPClient *httpClient = nil;

+ (HTTPClient *) getHttpClient {
    
	if (httpClient == nil) {
        //NSLog(@"httpclient / getHttpClient / 39");
		httpClient = [[HTTPClient alloc] initWithNThread:6 AndUserAgent:@"Simple client 1.0" ];
	}
	return httpClient;
}

#ifdef OAUTH
-(void) loadOauthConsumerInfo {
//	if (consumer == nil) {
//		self.consumer = [[OAConsumer alloc] initWithKey:kConsumerKey
//												 secret:kConsumerSecret];		
//	}
//	
//	if(accessToken == nil) {
//		//		self.accessToken = [[OAToken alloc] initWithUserDefaultsUsingServiceProviderName:kAppProviderName 
//		//																				  prefix:kAppPrefix];
//	} else {
//		[accessToken release];
//		accessToken = nil;
//	}
	
}

-(void) resetOAuth {
	if(accessToken != nil) {
		[accessToken release];
		accessToken = nil;
	}
	hasValidToken = NO;
//	isRetryAfterOAuthTimeout = NO;
}

-(void) enQueue: (HTTPRequest *) request {
//	if(arrWaitingRequest == nil) {
//		arrWaitingRequest = [[NSMutableArray alloc] initWithCapacity:1];
//	}
//	[arrWaitingRequest addObject: request];
	[self pushToQueue: request];
}

-(void) storeOauthConsumerInfo: (NSString *)value {
	
	if (accessToken != nil) {
		[accessToken release];
		accessToken = nil;
	}
	
	self.accessToken = [[[OAToken alloc] initWithHTTPResponseBody:value] autorelease];
	
	//	[accessToken storeInUserDefaultsWithServiceProviderName:kAppProviaderName prefix:kAppPrefix];
	
	self.hasValidToken = YES;
	self.isRetryAfterOAuthTimeout = NO;
	
	//	NSLog(@"key: %@", accessToken.key);
	//	NSLog(@"secret: %@", accessToken.secret);
}

-(void) requestToken:(OAConsumer *) consumer {
	OAMutableURLRequest *requestToken;
	OADataFetcher *fetcher;
    //kRequestTokenURL
	NSURL *url = [NSURL URLWithStringReplaceSpace:[LogUtil getKRequestTokenURL]];
	requestToken = [[[OAMutableURLRequest alloc] initWithURL:url
													consumer: self.consumer
													   token:nil
													   realm:nil
										   signatureProvider:nil] autorelease];
    
	[requestToken setHTTPMethod:@"POST"];
	fetcher = [[[OADataFetcher alloc] init] autorelease];
	[fetcher fetchDataWithRequest:requestToken
                         delegate:self
                didFinishSelector:@selector(requestTokenTicket:didFinishWithData:)
                  didFailSelector:@selector(requestTokenTicket:didFailWithError:)];
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {
	if (ticket.didSucceed && [data length] > 0) {
		NSString *responseBody = [[NSString alloc] initWithData:data
                                                       encoding:NSUTF8StringEncoding];
		
		//		[[NetworkEngine getHttpClient] storeOauthConsumerInfo:responseBody];
        //NSLog(@"HTTPClient RequestTokenTicket didFinishWithData %@",responseBody );
		if (accessToken != nil) {
			[accessToken release];
			accessToken = nil;
		}
		
		self.accessToken = [[[OAToken alloc] initWithHTTPResponseBody:responseBody] autorelease];
		[self authorizationToken:self.accessToken];
		
		[responseBody release];		
	} else {
        [self handleOAuthFailure];
    }
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error {
//	NSLog(@"%@", error);
   // NSLog(@"HTTPClient RequestTokenTicket requestTokenTicket %@",error );
	[self handleOAuthFailure];
}

- (void)handleOAuthFailure {
	isRetryAfterOAuthTimeout = NO;
	if(syncQueue != nil) {
		@try{
			NSObject *object = nil;
			while ((object = [syncQueue popNotWait]) != nil) {
				if ([object isKindOfClass: [HTTPRequest class]]) {
					HTTPRequest *httpRequest = (HTTPRequest*) object;
					HTTPResponse *httpResponse = [httpRequest createHTTPResponse];
					httpResponse.tag = httpRequest.tag;
					httpResponse.action = httpRequest.action;
					httpResponse.identifier = httpRequest.identifier;
					httpResponse.userData = httpRequest.userData;
					[httpRequest.observer onHttpReceivedError: httpResponse: NSLocalizedString(@"TEXT_NO_CONNECT_INTERNET", nil)];
					[httpResponse release];
					httpResponse = nil;
                }
								
			}
		}@catch (NSException *e) {
            [LogUtil writeLogWithException:e];
		}
	}
}

-(void)authorizationToken:(OAToken *)token {
    //kAuthorizeURL
	NSURL *url = [NSURL URLWithStringReplaceSpace:[LogUtil getKAuthorizeURL]];
	OAMutableURLRequest *requestAuthorize = [[OAMutableURLRequest alloc] initWithURL:url];
	
	OARequestParameter* para1 = [[[OARequestParameter alloc] initWithName:@"requestToken" value:self.accessToken.key] autorelease];
	OARequestParameter* para2 = [[[OARequestParameter alloc] initWithName:@"authorize" value:@"Authorize"] autorelease];
	
	NSArray* params = [NSArray arrayWithObjects:para1, para2, nil];
	[requestAuthorize setParameters:params];
	 //NSLog(@"HTTPClient RequestTokenTicket authorizationToken params %@",params );
	webView.delegate = self;
	[webView loadRequest: requestAuthorize];
	[requestAuthorize release];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)urlRequest navigationType:(UIWebViewNavigationType)navigationType {
	    //NSLog(@"webView:shouldStartLoadWithRequest:");
	    //NSLog(@"%@", [urlRequest.URL absoluteString]);
	NSString *url = [urlRequest.URL absoluteString];
	NSString *verifyCode = @"";
	if(url != nil) {
		NSRange range = [url rangeOfString:@"oauth_verifier" options:0 range:NSMakeRange(0, [url length])];
		if(range.length > 0) {
			verifyCode = [url substringFromIndex:range.location + range.length + 1];
			if ([verifyCode length] > 0) {
				//				NSLog(@"pin %@", pin);				
				if ([self respondsToSelector:@selector(successfulAuthorizationWithVerifyCode:)])
					[self successfulAuthorizationWithVerifyCode:verifyCode];
			}
		}
	}
	
    return YES;
}

- (void)successfulAuthorizationWithVerifyCode:(NSString *)verifyCode {
	[self requestAccessToken:self.consumer with:self.accessToken and:verifyCode];
}

- (void)failedAuthorization {
	[self handleOAuthFailure];
}

-(void) requestAccessToken:(OAConsumer *) consumer with: (OAToken *) token and:(NSString *) verifyCode {
	OAMutableURLRequest *requestAccessToken;
	OADataFetcher *fetcher;
	//kAccessTokenURL
	NSString *urlString = [NSString stringWithFormat:@"%@?oauth_token=%@&oauth_verifier=%@"
						   , [LogUtil getKAccessTokenURL], token.key, verifyCode];
	NSURL *url = [NSURL URLWithStringReplaceSpace: urlString];
	
	requestAccessToken = [[[OAMutableURLRequest alloc] initWithURL:url
														  consumer: self.consumer
															 token: token
															 realm: nil
												 signatureProvider: nil] autorelease];
	
	[requestAccessToken setOAuthParameterName:@"oauth_verifier" withValue:verifyCode];    
	[requestAccessToken setHTTPMethod:@"POST"];
	
	fetcher = [[[OADataFetcher alloc] init] autorelease];    
	[fetcher fetchDataWithRequest:requestAccessToken
                         delegate:self
                didFinishSelector:@selector(requestAccessTokenTicket:didFinishWithData:)
                  didFailSelector:@selector(requestAccessTokenTicket:didFailWithError:)];
}

- (void)requestAccessTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {
	if (ticket.didSucceed) {
		NSString *responseBody = [[NSString alloc] initWithData:data
                                                       encoding:NSUTF8StringEncoding];
        
        //NSLog(@"HTTPClient requestAccessTokenTicket responseBody %@",responseBody );
		[self storeOauthConsumerInfo:responseBody];		
		[responseBody release];
		// access protected resource
		if(hasValidToken) {
			if(syncQueue != nil) {
				@try{
					NSObject *object = nil;
					while ((object = [syncQueue popNotWait]) != nil) {
						if ([object isKindOfClass: [HTTPRequest class]]) {
							HTTPRequest *httpRequest = (HTTPRequest*)object;
							HttpLoader *loader = [[HttpLoader alloc] initWithRequest: httpRequest];
							[loader release];			}
						if ([object isKindOfClass: [NSArray class]]) {
						}			
					}
				}@catch (NSException *e) {
                    [LogUtil writeLogWithException:e];
				}
			}
		}
    }
}

- (void)requestAccessTokenTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error {
	[self handleOAuthFailure];
}

#endif

-(id) initWithNThread: (int) nConcurentThreads AndUserAgent:(NSString*)strUserAgent
{
	if (self = [super init])
	{
#ifdef OAUTH
        //NSLog(@"Httpclient / NetworkEngine / getHttpClient / initWithNThread(262)");
		[self loadOauthConsumerInfo];
#endif
		
		requestID = 0;
		//use self to access through property
		//		userAgent = [[NSString alloc] initWithString:strUserAgent];
		//		syncQueue = [[SyncQueue alloc] init];
		//		if (nConcurentThreads <= 0) {
		//			nConcurentThreads = 1;
		//		}
		//		arrThread = [[NSMutableArray alloc] initWithCapacity:nConcurentThreads ];
		//		KKLog(@"Concurrent thread is : %d",nConcurentThreads);
		//		if (arrThread != nil) {
		//			for (int i = 0; i < nConcurentThreads; i++) {
		//				//add HTTPRequest to arrThread;
		//				HTTPThread* httpThread = [[HTTPThread alloc] initWithHTTPClient:self];
		//				[arrThread addObject:(id)httpThread];
		//				//don't forget to set request queue to thread
		//				httpThread.requestQueue = syncQueue;
		//				[httpThread start];
		//				[httpThread release];
		//			}
		//		}
	}
	return self;
}

-(id) init {
	return [self initWithNThread: 2 AndUserAgent:@""];
}

- (void) emptyQueue {
	NSObject *object = nil;
	while ((object = [syncQueue popNotWait]) != nil) {
		
	}    
}
- (void) pushToQueue: (id) req {
	[syncQueue pushNotWait: req];
}
- (void)requestQueue {
	NSObject *object = nil;
	while ((object = [syncQueue popNotWait]) != nil) {
		if ([object isKindOfClass: [HTTPRequest class]]) {
			HttpLoader *loader = [[HttpLoader alloc] initWithRequest: (HTTPRequest*)object];
			[loader release];
		}
		if ([object isKindOfClass: [NSArray class]]) {
			AbstractModelService *service = [(NSArray*)object objectAtIndex: 0];
			ModelEvent *model = [(NSArray*)object objectAtIndex: 1];
			[service sentModelRequest: model.actionEvent];
		}
	}
}

- (void)requestQueueAfterLogin {
	isRetryAfterSessionTimeOut = NO;
	NSObject *object = nil;
	while ((object = [syncQueue popNotWait]) != nil) {
		if ([object isKindOfClass: [HTTPRequest class]]) {
			HttpLoader *loader = [[HttpLoader alloc] initWithRequest: (HTTPRequest*)object];
			[loader release];
		}
		if ([object isKindOfClass: [NSArray class]]) {
			AbstractModelService *service = [(NSArray*)object objectAtIndex: 0];
			ModelEvent *model = [(NSArray*)object objectAtIndex: 1];
			[service sentModelRequest: model.actionEvent];
		}
	}
}

-(int)request:(HTTPRequest*) httpRequest
{
	int result  = 0;
	httpRequest.identifier = requestID;
	
	requestID += 1;
	
	if (syncQueue == nil) {
		syncQueue = [[SyncQueue alloc] init];
	}
		
//#ifdef OAUTH
//	if(self.accessToken != nil) { // tam thoi chua check expired access token
//		if (isRetryAfterSessionTimeOut) {
//			//neu la dang login thi dua vao hang doi de lay session roi moi request
//			[syncQueue pushNotWait: httpRequest];
//		} else {
//			HttpLoader *loader = [[HttpLoader alloc] initWithRequest: httpRequest];
//			[loader release];
//			result  = httpRequest.identifier;
//		}
//	} else {
//		// push request to array
//		[syncQueue pushNotWait: httpRequest];
//		// request access token first, then access protected resource
//		[self requestToken:consumer];
//		// access protected resource in get access token success
//	}
//#else
//	HttpLoader *loader = [[HttpLoader alloc] initWithRequest: httpRequest];
//	[loader release];
//	result  = httpRequest.identifier;
//#endif
    
    
    HttpLoader *loader = [[HttpLoader alloc] initWithRequest: httpRequest];
	[loader release];
	result  = httpRequest.identifier;
	return result;
}

-(int)requestPayment:(HTTPRequest*) httpRequest
{
	int result  = 0;
	httpRequest.identifier = requestID;
	
	requestID += 1;
	
	if (syncQueue == nil) {
		syncQueue = [[SyncQueue alloc] init];
	}
#ifdef OAUTH
	if(self.accessToken != nil) { // tam thoi chua check expired access token
		if (isRetryAfterSessionTimeOut) {
			//neu la dang login thi dua vao hang doi de lay session roi moi request
			[syncQueue pushNotWait: httpRequest];
		} else {
			HttpLoader *loader = [[HttpLoader alloc] initWithRequestPayment: httpRequest];
			[loader release];
			result  = httpRequest.identifier;
		}
	} else {
		// push request to array
		[syncQueue pushNotWait: httpRequest];
		// request access token first, then access protected resource
		[self requestToken:consumer];
		// access protected resource in get access token success
	}
#else
	HttpLoader *loader = [[HttpLoader alloc] initWithRequestPayment: httpRequest];
	[loader release];
	result  = httpRequest.identifier;
#endif
	return result;
}

-(void) dealloc {
#ifdef OAUTH
	if(consumer) {
		[consumer release];
	}
	if(accessToken) {
		[accessToken release];
	}
#endif
	[webView release];
    webView.delegate = nil;
	[super dealloc];
}


@end
