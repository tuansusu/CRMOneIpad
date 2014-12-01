//
//  HTTPResponse.h
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPMessage.h"

@interface HTTPResponse : HTTPMessage {
	int resCode;
	NSString* message;
	NSObject *request;
}

//@property (nonatomic, copy) int resCode;
@property (nonatomic, assign) int resCode;
@property (nonatomic, retain) NSString* message;
@property (nonatomic, retain) NSObject *request;
-(void) getErrorCode;
@end
