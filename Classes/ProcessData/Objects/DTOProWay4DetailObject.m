//
//  DTOProWay4Detail.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProWay4DetailObject.h"

#import "Items.h"

@implementation DTOProWay4DetailObject

+(NSArray*)allFields{
    return [NSArray arrayWithObjects:
            @"CARD_NUMBER",
            @"CARD_HOLDER_NAME",
            @"CLIENT_ID",
            @"CURRENT_ACCOUNT",
            @"PRODUCT_CODE",
            @"BRANCH_CODE",
            @"OPEN_DATE",
            @"EXPIRE_DATE",
            @"AVAIABLE",
            @"BLOCKED",
            @"BALANCE",
            @"STATUS",
            @"TYPE",
            @"BUSSINESS_DATE",
            @"CREATED_DATE",
            @"UPDATED_DATE",
            @"RM_CODE",
            @"CONTRACT_NUMBER",
            nil];
}

- (Items*)itemObject{
    Items * item = [[Items alloc] initWithKeys:[NSArray arrayWithObjects:
                                                @"CARD_NUMBER",
                                                @"CARD_HOLDER_NAME",
                                                @"CLIENT_ID",
                                                @"CURRENT_ACCOUNT",
                                                @"PRODUCT_CODE",
                                                @"BRANCH_CODE",
                                                @"OPEN_DATE",
                                                @"EXPIRE_DATE",
                                                @"AVAIABLE",
                                                @"BLOCKED",
                                                @"BALANCE",
                                                @"STATUS",
                                                @"TYPE",
                                                @"BUSSINESS_DATE",
                                                @"CREATED_DATE",
                                                @"UPDATED_DATE",
                                                @"RM_CODE",
                                                @"CONTRACT_NUMBER",
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
                       @"CARD_NUMBER",
                       @"CARD_HOLDER_NAME",
                       @"CLIENT_ID",
                       @"CURRENT_ACCOUNT",
                       @"PRODUCT_CODE",
                       @"BRANCH_CODE",
                       @"OPEN_DATE",
                       @"EXPIRE_DATE",
                       @"AVAIABLE",
                       @"BLOCKED",
                       @"BALANCE",
                       @"STATUS",
                       @"TYPE",
                       @"BUSSINESS_DATE",
                       @"CREATED_DATE",
                       @"UPDATED_DATE",
                       @"RM_CODE",
                       @"CONTRACT_NUMBER",
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
