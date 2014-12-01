//
//  ModelEvent.m
//  KunKun
//
//  Created by Nguyen Quang Hieu on 11/24/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import "ModelEvent.h"

@implementation ModelEvent

@synthesize actionEvent;
@synthesize modelData, modelMessage,modelCode;
@synthesize bankErrorCode;


- (id) init {
	self = [super init];
	if (self != nil) {
		actionEvent = nil;
		modelData = nil;
		modelMessage = [[NSString alloc] init];
		modelCode = 200;
		bankErrorCode = 0;
	}
	return self;
}

- (void) dealloc {
	if(actionEvent != nil){
		[actionEvent release];
		actionEvent=nil;
	}
	if(modelData != nil){
		[modelData release];
		modelData=nil;
	}
	if(modelMessage != nil){
		[modelMessage release];
		modelMessage=nil;
	}

	[super dealloc];
}



@end
