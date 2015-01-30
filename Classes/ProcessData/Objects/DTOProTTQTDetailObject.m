//
//  DTOProTTQTDetail.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProTTQTDetailObject.h"

#import "Items.h"

@implementation DTOProTTQTDetailObject

+(NSArray*)allFields{
    return [NSArray arrayWithObjects:
            @"BRANCH_CODE",
            @"CONTRACT_NUMBER",
            @"CLIENT_ID",
            @"LC_TYPE",
            @"IMP_EXP",
            @"ISSUE_DATE",
            @"LC_CCY",
            @"LC_AMOUNT",
            @"LC_AMOUNT_USD",
            @"OUT_TYPE",
            @"OUT_CCY",
            @"OUT_AMOUNT",
            @"OUT_AMOUNT_USD",
            @"OUT_VALUE_DATE",
            @"STATUS",
            @"SECTOR",
            @"BUSSINESS_DATE",
            @"CREATED_DATE",
            @"UPDATE_DATE",
            @"PRODUCT_CODE",
            @"RM_CODE",
            @"KHOI",
            @"RM_BANCHEO",
            nil];
}

- (Items*)itemObject{
    Items * item = [[Items alloc] initWithKeys:[NSArray arrayWithObjects:
                                                @"BRANCH_CODE",
                                                @"CONTRACT_NUMBER",
                                                @"CLIENT_ID",
                                                @"LC_TYPE",
                                                @"IMP_EXP",
                                                @"ISSUE_DATE",
                                                @"LC_CCY",
                                                @"LC_AMOUNT",
                                                @"LC_AMOUNT_USD",
                                                @"OUT_TYPE",
                                                @"OUT_CCY",
                                                @"OUT_AMOUNT",
                                                @"OUT_AMOUNT_USD",
                                                @"OUT_VALUE_DATE",
                                                @"STATUS",
                                                @"SECTOR",
                                                @"BUSSINESS_DATE",
                                                @"CREATED_DATE",
                                                @"UPDATE_DATE",
                                                @"PRODUCT_CODE",
                                                @"RM_CODE",
                                                @"KHOI",
                                                @"RM_BANCHEO",
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
                       @"BRANCH_CODE",
                       @"CONTRACT_NUMBER",
                       @"CLIENT_ID",
                       @"LC_TYPE",
                       @"IMP_EXP",
                       @"ISSUE_DATE",
                       @"LC_CCY",
                       @"LC_AMOUNT",
                       @"LC_AMOUNT_USD",
                       @"OUT_TYPE",
                       @"OUT_CCY",
                       @"OUT_AMOUNT",
                       @"OUT_AMOUNT_USD",
                       @"OUT_VALUE_DATE",
                       @"STATUS",
                       @"SECTOR",
                       @"BUSSINESS_DATE",
                       @"CREATED_DATE",
                       @"UPDATE_DATE",
                       @"PRODUCT_CODE",
                       @"RM_CODE",
                       @"KHOI",
                       @"RM_BANCHEO",
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
