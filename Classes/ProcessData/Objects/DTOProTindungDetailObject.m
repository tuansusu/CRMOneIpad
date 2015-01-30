//
//  DTOProTindungDetailObject.m
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import "DTOProTindungDetailObject.h"

#import "Items.h"

@implementation DTOProTindungDetailObject

+(NSArray*)allFields{
    return [NSArray arrayWithObjects:
            @"BRANCH_CODE",
            @"CONTRACT_NUMBER",
            @"OPEN_DATE",
            @"EXPIRE_DATE",
            @"EXTENSION_DATE",
            @"BALANCE",
            @"BALANCE_QD",
            @"SOD_BALANCE",
            @"SOD_BALANCE_QD",
            @"CURRENCY",
            @"CLIENT_ID",
            @"TERM",
            @"TERM_TYPE",
            @"DEPT_GROUP",
            @"DEPT_GROUP2",
            @"FIXED_INTEREST",
            @"INTEREST_MARGIN",
            @"INTEREST",
            @"RECEIVEABLE_AMOUNT",
            @"STATUS",
            @"BUSSINESS_DATE",
            @"INITIAL_BALANCE",
            @"PREPAID_INTEREST",
            @"OVERDUE_INTEREST",
            @"SECTOR",
            @"SOURCE_OF_FUND",
            @"SECURE",
            @"GL",
            @"INDUSTRY_CODE",
            @"INTEREST_TYPE",
            @"INTEREST_KEY",
            @"INPUTTER",
            @"PRODUCT_CODE",
            @"RM_CODE",
            @"KHOI",
            @"RM_BANCHEO",
            @"PURPOSE",
            nil];
}

- (Items*)itemObject{
    Items * item = [[Items alloc] initWithKeys:[NSArray arrayWithObjects:
                                                @"BRANCH_CODE",
                                                @"CONTRACT_NUMBER",
                                                @"OPEN_DATE",
                                                @"EXPIRE_DATE",
                                                @"EXTENSION_DATE",
                                                @"BALANCE",
                                                @"BALANCE_QD",
                                                @"SOD_BALANCE",
                                                @"SOD_BALANCE_QD",
                                                @"CURRENCY",
                                                @"CLIENT_ID",
                                                @"TERM",
                                                @"TERM_TYPE",
                                                @"DEPT_GROUP",
                                                @"DEPT_GROUP2",
                                                @"FIXED_INTEREST",
                                                @"INTEREST_MARGIN",
                                                @"INTEREST",
                                                @"RECEIVEABLE_AMOUNT",
                                                @"STATUS",
                                                @"BUSSINESS_DATE",
                                                @"INITIAL_BALANCE",
                                                @"PREPAID_INTEREST",
                                                @"OVERDUE_INTEREST",
                                                @"SECTOR",
                                                @"SOURCE_OF_FUND",
                                                @"SECURE",
                                                @"GL",
                                                @"INDUSTRY_CODE",
                                                @"INTEREST_TYPE",
                                                @"INTEREST_KEY",
                                                @"INPUTTER",
                                                @"PRODUCT_CODE",
                                                @"RM_CODE",
                                                @"KHOI",
                                                @"RM_BANCHEO",
                                                @"PURPOSE",
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
                       @"OPEN_DATE",
                       @"EXPIRE_DATE",
                       @"EXTENSION_DATE",
                       @"BALANCE",
                       @"BALANCE_QD",
                       @"SOD_BALANCE",
                       @"SOD_BALANCE_QD",
                       @"CURRENCY",
                       @"CLIENT_ID",
                       @"TERM",
                       @"TERM_TYPE",
                       @"DEPT_GROUP",
                       @"DEPT_GROUP2",
                       @"FIXED_INTEREST",
                       @"INTEREST_MARGIN",
                       @"INTEREST",
                       @"RECEIVEABLE_AMOUNT",
                       @"STATUS",
                       @"BUSSINESS_DATE",
                       @"INITIAL_BALANCE",
                       @"PREPAID_INTEREST",
                       @"OVERDUE_INTEREST",
                       @"SECTOR",
                       @"SOURCE_OF_FUND",
                       @"SECURE",
                       @"GL",
                       @"INDUSTRY_CODE",
                       @"INTEREST_TYPE",
                       @"INTEREST_KEY",
                       @"INPUTTER",
                       @"PRODUCT_CODE",
                       @"RM_CODE",
                       @"KHOI",
                       @"RM_BANCHEO",
                       @"PURPOSE",
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
