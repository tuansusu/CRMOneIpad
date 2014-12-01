//
//  HTTPRequest.h
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPMessage.h"
#import "HTTPObserver.h"
#import "HTTPResponse.h"

enum Method {
	GET,
	POST,
	PUT
};

enum ContentType {
	BINARY,
	TEXT
};

@interface HTTPRequest : HTTPMessage {
	enum Method method;
	NSString *uri;
	id<HTTPObserver> observer;
	NSString* cookie;
	NSString *contentType; //by default is TEXT
}
- (HTTPResponse*) createHTTPResponse;
@property (nonatomic, retain) id<HTTPObserver> observer;
@property (nonatomic) enum Method method;
@property (copy, nonatomic) NSString* uri;
@property (nonatomic, copy) NSString* cookie;
@property (nonatomic,copy) NSString* contentType;

@end
