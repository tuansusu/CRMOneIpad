//
//  HTTPObserver.h
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPResponse.h"


@protocol HTTPObserver
@required
//-(void)onReceivedDataWithId:(int)identifier AndAction:(int) method AndData: (NSData*) data;
-(void)onHttpReceivedData : (HTTPResponse*) httpResponse;

@optional

-(void)onHttpReceivedError : (HTTPResponse*) httpResponse : (NSString*) error;
-(void)onError;
@end
