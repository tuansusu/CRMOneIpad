//
//  HTTPMessage.m
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//


#import "HTTPMessage.h"


@implementation HTTPMessage

@synthesize data;
@synthesize action;
@synthesize identifier;
@synthesize tag;
@synthesize userData;

-(id)init
{
    if (self = [super init])
    {
		// Initialization code here
		//data = [[NSMutableData alloc] init];
		identifier = 0;
		action = 0;
		tag = -1;
    }
    return self;
}


-(BOOL) setDataWithMutableString: (NSString*) strData WithEncoding: (NSStringEncoding) encoding {
	BOOL res = TRUE;
	[self resetData];
	if (strData == nil) {
		return res;
	}
	if (data == nil) {
		data = [[NSMutableData alloc] init];		
	}
	NSData* nsData = [strData dataUsingEncoding:encoding];
	if (nsData == nil) {
		//convert fail with encoding
		return FALSE;
	}
	[data appendData:nsData];
	return res;
}

-(void) resetData {
	[data setLength: 0];
}

-(void) appendData:(UInt8 *) aData withDataSize:(int) length {
	if (data == nil) {
		data = [[NSMutableData alloc] init];		
	}
	[data appendBytes:(const void*)aData length:length];
}

-(void)setdata:(NSMutableData *) _data{
	data = _data;
}

-(void) dealloc
{
	if(data != nil) {
		[data release];
	}
	if(userData != nil) {
		[userData release];
	}

	[super dealloc];

}
@end
