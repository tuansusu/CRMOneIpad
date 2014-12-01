//
//  NetworkUtils.h
//  KunKun
//
//  Created by Nguyen Quang Hieu on 12/4/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BOUNDARY  @"----------V2ymHFg03ehbqgZCaKO6jy"
#define CONTENTTYPE_TEXT @"text"
#define CONTENTTYPE_BINARY @"binary"
#define CONTENTTYPE_JSON @"application/json"
#define CONTENTTYPE_MUTIPART @"multipart/form-data; boundary=----------V2ymHFg03ehbqgZCaKO6jy"
#define RPC_PATH @"%@rpc"

@interface NetworkUtils : NSObject {

}

+ (NSString *) getJsonContentType;
+ (NSString *) getMultipartContentType;
+ (NSString *) getTextContentType;
+ (NSString *) getBinaryContentType;

+ (NSString *) getBoundaryString;
+ (NSMutableData*) getMultipartMutableDataWithObject: (NSMutableDictionary*) params andFileField : (NSString*) fileField andFileName: (NSString*) fileName andFileType: (NSString*) fileType andData: (NSMutableData*) data;
+ (NSMutableData *) getJsonMutableDataWithObject: (NSMutableDictionary*) object;
+ (NSString *) getJsonStringDataWithObject: (NSMutableDictionary*) object;

@end
