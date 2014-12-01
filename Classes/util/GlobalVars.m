//
//  GlobalVars.m
//  OfficeOneIpad
//
//  Created by viettel on 6/3/14.
//
//

#import "GlobalVars.h"

@implementation GlobalVars

@synthesize siteUrl = _siteUrl;
@synthesize serviceUrl = _serviceUrl;

+ (GlobalVars *)sharedInstance {
    static dispatch_once_t onceToken;
    static GlobalVars *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalVars alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _siteUrl = nil;
        _serviceUrl = nil;
    }
    return self;
}

@end
