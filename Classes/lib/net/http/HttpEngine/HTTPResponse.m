//
//  HTTPResponse.m
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import "HTTPResponse.h"


@implementation HTTPResponse

@synthesize resCode;
@synthesize message;
@synthesize request;
-(id) init {
	if(self = [super init]) {
		self.message = @"";
	}
	return self;
}

-(void) dealloc
{
	if(message){
		[message release];
		message = nil;
	}
	self.request = nil;
	[super dealloc];
}

-(void) getErrorCode
{
	
}

@end
