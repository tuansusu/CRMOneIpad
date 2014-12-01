//
//  ActionEvent.m
//  KunKun
//
//  Created by Nguyen Quang Hieu on 11/24/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import "ActionEvent.h"


@implementation ActionEvent
@synthesize textSender = _textSender;
@synthesize action;
@synthesize tag;
@synthesize viewData = _viewData;
@synthesize sender = _sender;
@synthesize userData = _userData;
@synthesize cancel;
@synthesize request;
@synthesize json = _json;
@synthesize tempData;

- (id) init {
	self = [super init];
	if (self != nil) {
		action = none;
		tag = 0;
		cancel = FALSE;
		self.sender = nil;
		self.viewData = nil;
		self.userData = nil;
		self.json=nil;
        self.tempData = nil;

	}
	return self;
}

- (void) dealloc {
	self.textSender = nil;
	self.sender = nil;
	self.viewData = nil;
	self.userData = nil;
	self.json = nil;
    self.tempData=nil;
    self.timeSend = nil;
	[super dealloc];
}

@end
