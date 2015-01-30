//
//  DTOProBPDetailObject.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProBPDetailObject.h"

#import "Items.h"

@implementation DTOProBPDetailObject

+(NSArray*)allFields{
    return [NSArray arrayWithObjects:
            @"CONTRACT_NUMBER",
            @"BRANCH_CODE",
            @"REGISTER_MOBILE",
            @"ACCOUNT",
            @"CIF",
            @"CLIENT_ID",
            @"PRODUCT_CODE",
            @"REGISTER_DATE",
            @"BP_UPDATE_DATE",
            @"STATUS",
            @"BUSSINESS_DATE",
            @"CREATED_DATE",
            @"UPDATED_DATE",
            @"RM_CODE",
            nil];
}

- (Items*)itemObject{
    Items * item = [[Items alloc] initWithKeys:[NSArray arrayWithObjects:
                                                @"CONTRACT_NUMBER",
                                                @"BRANCH_CODE",
                                                @"REGISTER_MOBILE",
                                                @"ACCOUNT",
                                                @"CIF",
                                                @"CLIENT_ID",
                                                @"PRODUCT_CODE",
                                                @"REGISTER_DATE",
                                                @"BP_UPDATE_DATE",
                                                @"STATUS",
                                                @"BUSSINESS_DATE",
                                                @"CREATED_DATE",
                                                @"UPDATED_DATE",
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
                       @"BRANCH_CODE",
                       @"REGISTER_MOBILE",
                       @"ACCOUNT",
                       @"CIF",
                       @"CLIENT_ID",
                       @"PRODUCT_CODE",
                       @"REGISTER_DATE",
                       @"BP_UPDATE_DATE",
                       @"STATUS",
                       @"BUSSINESS_DATE",
                       @"CREATED_DATE",
                       @"UPDATED_DATE",
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
