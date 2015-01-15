//
//  DTOTaskObject.m
//  OfficeOneMB
//
//  Created by macpro on 1/8/15.
//
//

#import "DTOTaskObject.h"

#import "Items.h"

@implementation DTOTaskObject

- (Items*)itemObject{
    Items * item = [[Items alloc] initWithKeys:[NSArray arrayWithObjects:
                                                @"id",
                                                @"clientTaskId",
                                                @"clientId",
                                                @"clientLeadId",
                                                @"title",
                                                @"startDate",
                                                @"endDate",
                                                @"updatedDate",
                                                @"taskStatus",
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
                       @"id",
                       @"clientTaskId",
                       @"clientId",
                       @"clientLeadId",
                       @"title",
                       @"startDate",
                       @"endDate",
                       @"updatedDate",
                       @"taskStatus",
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
