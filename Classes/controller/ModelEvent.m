//
//  ModelEvent.m
//  OfficeOneMB
//
//  Created by admin on 4/28/15.
//
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

@end
