//
//  DTOProBaoLanhDetail.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProBaoLanhDetailObject.h"

#import "Items.h"

@implementation DTOProBaoLanhDetailObject
+(NSArray*)allFields{
    return [NSArray arrayWithObjects:
            @"BRANCH_CODE",
            @"CONTRACT_NUMBER",
            @"CATEGORY",
            @"REF",
            @"CLIENT_ID",
            @"SECTOR",
            @"INDUSTRY_CODE",
            @"CURRENCY",
            @"BALANCE",
            @"OPEN_DATE",
            @"VALUE_DATE",
            @"EXPIRE_DATE",
            @"MD_FREE",
            @"MARGIN",
            @"MARGIN_AMOUNT",
            @"RECEIVER_CODE",
            @"RECEIVER_NAME",
            @"UPDATE_LIMIT",
            @"PROVISION",
            @"MARGIN_FLAG",
            @"MARGIN2",
            @"LIQUIDATION_MODE",
            @"FEE_TYPE",
            @"FREQUENCY",
            @"AUTO_EXPIRE",
            @"BUSSINESS_DATE",
            @"CMS_DATE",
            @"CMS_AMT",
            @"DESCRIPTION",
            @"INITIAL_MARGIN",
            @"BALANCE_QD",
            @"FOREX_RATE",
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
                                                @"CATEGORY",
                                                @"REF",
                                                @"CLIENT_ID",
                                                @"SECTOR",
                                                @"INDUSTRY_CODE",
                                                @"CURRENCY",
                                                @"BALANCE",
                                                @"OPEN_DATE",
                                                @"VALUE_DATE",
                                                @"EXPIRE_DATE",
                                                @"MD_FREE",
                                                @"MARGIN",
                                                @"MARGIN_AMOUNT",
                                                @"RECEIVER_CODE",
                                                @"RECEIVER_NAME",
                                                @"UPDATE_LIMIT",
                                                @"PROVISION",
                                                @"MARGIN_FLAG",
                                                @"MARGIN2",
                                                @"LIQUIDATION_MODE",
                                                @"FEE_TYPE",
                                                @"FREQUENCY",
                                                @"AUTO_EXPIRE",
                                                @"BUSSINESS_DATE",
                                                @"CMS_DATE",
                                                @"CMS_AMT",
                                                @"DESCRIPTION",
                                                @"INITIAL_MARGIN",
                                                @"BALANCE_QD",
                                                @"FOREX_RATE",
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
                       @"CATEGORY",
                       @"REF",
                       @"CLIENT_ID",
                       @"SECTOR",
                       @"INDUSTRY_CODE",
                       @"CURRENCY",
                       @"BALANCE",
                       @"OPEN_DATE",
                       @"VALUE_DATE",
                       @"EXPIRE_DATE",
                       @"MD_FREE",
                       @"MARGIN",
                       @"MARGIN_AMOUNT",
                       @"RECEIVER_CODE",
                       @"RECEIVER_NAME",
                       @"UPDATE_LIMIT",
                       @"PROVISION",
                       @"MARGIN_FLAG",
                       @"MARGIN2",
                       @"LIQUIDATION_MODE",
                       @"FEE_TYPE",
                       @"FREQUENCY",
                       @"AUTO_EXPIRE",
                       @"BUSSINESS_DATE",
                       @"CMS_DATE",
                       @"CMS_AMT",
                       @"DESCRIPTION",
                       @"INITIAL_MARGIN",
                       @"BALANCE_QD",
                       @"FOREX_RATE",
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
