//
//  NetworkEngine.m
//  KunKun
//
//  Created by Nguyen Quang Hieu on 11/25/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import "NetworkEngine.h"



@implementation NetworkEngine

HTTPClient *httpClient = nil;

+ (HTTPClient *) getHttpClient {
	if (httpClient == nil) {
		httpClient = [[HTTPClient alloc] initWithNThread:6 AndUserAgent:@"Simple client 1.0" ];
	}
	return httpClient;
}
@end
