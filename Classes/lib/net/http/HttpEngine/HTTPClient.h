//
//  HTTPClient.h
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyncQueue.h"
#import "HTTPThread.h"
#import "HTTPRequest.h"

#ifdef OAUTH
#import "OAConsumer.h"
#import "OAToken.h"
#import "OAServiceTicket.h"
#endif

@interface HTTPClient : NSObject <UIWebViewDelegate>{
	
	//queue contains HTTPRequest
	SyncQueue* syncQueue;
	NSMutableArray* arrThread;
	//generate requestID
	UInt32 requestID;
	NSString* userAgent;
//	NSMutableArray* arrWaitingRequest;
#ifdef OAUTH
	OAConsumer *consumer;
	OAToken *accessToken;
	BOOL hasValidToken;
	BOOL isRetryAfterOAuthTimeout;
	
//	NSString *userToken;
#endif
	BOOL isRetryAfterSessionTimeOut;
}
@property (nonatomic, assign) BOOL isRetryAfterSessionTimeOut;
//@property (nonatomic, retain) NSMutableArray* arrWaitingRequest;
#ifdef OAUTH
@property (nonatomic, retain) OAConsumer *consumer;
@property (nonatomic, retain) OAToken *accessToken;
@property (nonatomic, assign) BOOL hasValidToken;
@property (nonatomic, assign) BOOL isRetryAfterOAuthTimeout;
//@property (nonatomic, assign) NSString *userToken;
#endif

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, readonly) NSString* userAgent;

-(id) initWithNThread: (int) nConcurentThreads AndUserAgent:(NSString*)strUserAgent;
-(int)request:(HTTPRequest*) httpRequest;
-(int)requestPayment:(HTTPRequest*) httpRequest;
- (void) pushToQueue: (id) req;
- (void) emptyQueue;
- (void) requestQueue;

#ifdef OAUTH
-(void) loadOauthConsumerInfo;
-(void) storeOauthConsumerInfo: (NSString *)value;
-(void) resetOAuth;
-(void) enQueue: (HTTPRequest *) request;

-(void) requestToken:(OAConsumer *) consumer;
- (void)requestTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
- (void)requestTokenTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error;
-(void)authorizationToken:(OAToken *)token;
- (void)successfulAuthorizationWithVerifyCode:(NSString *)verifyCode;
- (void)failedAuthorization;
-(void) requestAccessToken:(OAConsumer *) consumer with: (OAToken *) token and:(NSString *) verifyCode;
- (void)requestAccessTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
- (void)requestAccessTokenTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error;
- (void)handleOAuthFailure;
#endif

+ (HTTPClient *) getHttpClient;

@end
