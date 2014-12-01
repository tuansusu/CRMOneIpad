//
//  NetworkUtils.m
//  KunKun
//
//  Created by Nguyen Quang Hieu on 12/4/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import "NetworkUtils.h"
#import "JSON.h"

@implementation NetworkUtils

+ (NSString *) getJsonContentType {
	return CONTENTTYPE_JSON;
}
+ (NSString *) getMultipartContentType {
	return CONTENTTYPE_MUTIPART;
}
+ (NSString *) getTextContentType {
	return CONTENTTYPE_TEXT;
}
+ (NSString *) getBinaryContentType {
	return CONTENTTYPE_BINARY;
}

+ (NSString *) getBoundaryString {
	return BOUNDARY;
}
//get Mutipart data
+ (NSMutableData*) getMultipartMutableDataWithObject: (NSMutableDictionary*) params andFileField : (NSString*) fileField andFileName: (NSString*) fileName andFileType: (NSString*) fileType andData: (NSMutableData*) data
{
	NSMutableData *res = [[NSMutableData alloc] init];
	[res appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	if(params != nil)
	{
		NSArray *keys = [params allKeys];
		// values in foreach loop
		for (NSString *key in keys) {
			NSString *value = (NSString*)[params objectForKey:key];
			[res appendData:[@"Content-Disposition: form-data; name=\"" dataUsingEncoding:NSUTF8StringEncoding]];
			[res appendData:[key dataUsingEncoding:NSUTF8StringEncoding]];
			[res appendData:[@"\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
			[res appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
			[res appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
			[res appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
			[res appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
			[res appendData:[BOUNDARY dataUsingEncoding:NSUTF8StringEncoding]];
			[res appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
			
		}
	}
	//NSString *ns = [[NSString alloc] initWithData: res encoding:NSUTF8StringEncoding];
	if(fileField == nil || [@"" isEqualToString:fileField])
	{
		fileType = @"KunKun";
	}
	if(fileName == nil || [@"" isEqualToString:fileName])
	{
		fileType = @"KunKun";
	}
	if(fileType == nil || [@"" isEqualToString:fileType])
	{
		fileType = @"image/png";
	}
	
	[res appendData:[@"Content-Disposition: form-data; name=\"" dataUsingEncoding:NSUTF8StringEncoding]];
	[res appendData:[fileField dataUsingEncoding:NSUTF8StringEncoding]];
	[res appendData:[@"\"; filename=\"" dataUsingEncoding:NSUTF8StringEncoding]];
	[res appendData:[fileName dataUsingEncoding:NSUTF8StringEncoding]];
	[res appendData:[@"\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[res appendData:[@"Content-Type: " dataUsingEncoding:NSUTF8StringEncoding]];
	[res appendData:[fileType dataUsingEncoding:NSUTF8StringEncoding]];
	[res appendData:[@"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	if(data == nil)
	{
		[data appendData:[@"KunKun" dataUsingEncoding:NSUTF8StringEncoding]];
	}
	else{
		[res appendData:data];
	}
	
	[res appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	return [res autorelease];
}

+ (NSMutableData *) getJsonMutableDataWithObject: (NSMutableDictionary*) object {
	SBJsonWriter *writer = [[SBJsonWriter alloc] init];
	NSString *json = [writer stringWithObject:object];
	[writer release];
	NSData* nsData = [json dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *data = [[NSMutableData alloc] init];
	[data appendData:nsData];
	//return data;
    return [data autorelease];
}

+ (NSString *) getJsonStringDataWithObject: (NSMutableDictionary*) object {
	SBJsonWriter *writer = [[SBJsonWriter alloc] init];
	NSString *json = [writer stringWithObject:object];
	[writer release];
	return json;
}



@end
