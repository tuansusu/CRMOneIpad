//
//  HttpLoader.h
//  KunKun
//
//  Created by PTSPM_HIEUNQ1 on 7/18/11.
//  Copyright 2011 Trung tâm phần mềm Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRequest.h"
#import "HTTPResponse.h"

#ifdef OAUTH
#import "OAAsynchronousDataFetcher.h"
#import "OAConsumer.h"
#import "OAServiceTicket.h"
#import "OAToken.h"
@interface HttpLoader : OAAsynchronousDataFetcher {	
#else 
@interface HttpLoader : NSObject {
#endif
	NSMutableData *receivedData;
	NSURLConnection *httpConnection;
	HTTPRequest *httpRequest;
	HTTPResponse* httpResponse;
	int requestCount;
}

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSURLConnection *httpConnection;
@property (nonatomic, retain) HTTPRequest *httpRequest;
@property (nonatomic, retain) HTTPResponse *httpResponse;
@property (nonatomic, assign) int requestCount;

- (id) initWithRequest: (HTTPRequest*) httprequest;
- (id) initWithRequestPayment: (HTTPRequest*) httprequest;
- (void) handleReceiveError;
- (void) handleReceiveData;
@end
