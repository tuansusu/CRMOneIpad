//
//  DTOProEMBDetailObject.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProEMBDetailObject.h"

#import "Items.h"

@implementation DTOProEMBDetailObject

+(NSArray*)allFields{
    return [NSArray arrayWithObjects:
            @"CONTRACT_NUMBER",
            @"PRODUCT_CODE",
            @"CLIENT_ID",
            @"BRANCH_CODE",
            @"CMT",
            @"START_DATE",
            @"END_DATE",
            @"BUSSINESS_DATE",
            @"CREATED_DATE",
            @"UPDATE_DATE",
            @"RM_CODE",
            nil];
}

- (Items*)itemObject{
    Items * item = [[Items alloc] initWithKeys:[NSArray arrayWithObjects:
                                                @"CONTRACT_NUMBER",
                                                @"PRODUCT_CODE",
                                                @"CLIENT_ID",
                                                @"BRANCH_CODE",
                                                @"CMT",
                                                @"START_DATE",
                                                @"END_DATE",
                                                @"BUSSINESS_DATE",
                                                @"CREATED_DATE",
                                                @"UPDATE_DATE",
                                                @"RM_CODE",
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
                       @"CONTRACT_NUMBER",
                       @"PRODUCT_CODE",
                       @"CLIENT_ID",
                       @"BRANCH_CODE",
                       @"CMT",
                       @"START_DATE",
                       @"END_DATE",
                       @"BUSSINESS_DATE",
                       @"CREATED_DATE",
                       @"UPDATE_DATE",
                       @"RM_CODE",
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
