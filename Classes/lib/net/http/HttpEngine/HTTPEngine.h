//
//  HTTPEngine.h
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HTTPRequest;
@class HTTPResponse;
@class HTTPClient;

@interface HTTPEngine : NSObject {
	HTTPClient* httpClient;
}

- (id) initWithHTTPClient: (HTTPClient*) aHTTPClient;
- (HTTPResponse*) request:(HTTPRequest*) httpRequest;
- (HTTPResponse*) requestPayment:(HTTPRequest*) httpRequest;
- (BOOL)checkURL:(NSString*)url;
@end
