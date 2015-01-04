//
//  DTOComplainObject.m
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import "DTOComplainObject.h"

#import "Items.h"

@implementation DTOComplainObject

+(NSArray*)allFields{
    return [NSArray arrayWithObjects:
            @"casesId",
            @"code",
            @"content",
            @"reason",
            @"result",
            @"status",
            @"fromReceived",
            @"type",
            @"priority",
            @"receiverId",
            @"receivedDate",
            @"processerId",
            @"processedDate",
            @"closedId",
            @"closedDate",
            @"accountId",
            @"productMasterId",
            @"acceptTypeId",
            @"agentText",
            @"assignBy",
            @"blackList",
            @"callLenght",
            nil];
}

- (Items*)itemObject{
    Items * item = [[Items alloc] initWithKeys:[NSArray arrayWithObjects:
                                                @"casesId",
                                                @"code",
                                                @"content",
                                                @"reason",
                                                @"result",
                                                @"status",
                                                @"fromReceived",
                                                @"type",
                                                @"priority",
                                                @"receiverId",
                                                @"receivedDate",
                                                @"processerId",
                                                @"processedDate",
                                                @"closedId",
                                                @"closedDate",
                                                @"accountId",
                                                @"productMasterId",
                                                @"acceptTypeId",
                                                @"agentText",
                                                @"assignBy",
                                                @"blackList",
                                                @"callLenght",
                                                nil]];

    for (NSString *key in [item allKeys]) {
        [item setValue:[self valueForKey:key] forKey:key];
    }

    return item ;
}

- (NSMutableDictionary *)convertToDictionary
{
    NSMutableDictionary *_dictionary=[[NSMutableDictionary alloc] init];
    NSArray *keyArray=[NSArray arrayWithObjects:
                       @"casesId",
                       @"code",
                       @"content",
                       @"reason",
                       @"result",
                       @"status",
                       @"fromReceived",
                       @"type",
                       @"priority",
                       @"receiverId",
                       @"receivedDate",
                       @"processerId",
                       @"processedDate",
                       @"closedId",
                       @"closedDate",
                       @"accountId",
                       @"productMasterId",
                       @"acceptTypeId",
                       @"agentText",
                       @"assignBy",
                       @"blackList",
                       @"callLenght",
                       nil];

    for (NSString *key in keyArray) {
        [_dictionary setValue:[self valueForKey:key] forKey:key];
    }
    return _dictionary ;
}
- (void)parseFromDictionary:(NSDictionary *)dictionary
{
    for (NSString *key in [dictionary allKeys]) {
        [self setValue:[dictionary objectForKey:key] forKey:key];
    }
}

- (void)parseFromItem:(Items*)item{
    for (NSString *key in [item allKeys]) {
        [self setValue:[item valueForKey:key] forKey:key];
    }
    
    
}

@end
