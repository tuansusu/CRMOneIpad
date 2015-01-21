//
//  DTOWidgetObject.m
//  OfficeOneMB
//
//  Created by macpro on 1/18/15.
//
//

#import "DTOWidgetObject.h"

#import "Items.h"

@implementation DTOWidgetObject
+(NSArray*)allFields{
    return [NSArray arrayWithObjects:
            @"confId",
            @"accountName",
            @"typeGraphically",
            @"colorDisplay1",
            @"createDate",
            @"isShowData",
            @"colorDisplay2",
            @"widgetId",
            @"widgetName",
            @"widgetType",
            @"status",
            nil];
}
- (Items*)itemObject{
    Items * item = [[Items alloc] initWithKeys:[NSArray arrayWithObjects:
                                                @"confId",
                                                @"accountName",
                                                @"typeGraphically",
                                                @"colorDisplay1",
                                                @"createDate",
                                                @"isShowData",
                                                @"colorDisplay2",
                                                @"widgetId",
                                                @"widgetName",
                                                @"widgetType",
                                                @"status",
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
                       @"confId",
                       @"accountName",
                       @"typeGraphically",
                       @"colorDisplay1",
                       @"createDate",
                       @"isShowData",
                       @"colorDisplay2",
                       @"widgetId",
                       @"widgetName",
                       @"widgetType",
                       @"status",
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
