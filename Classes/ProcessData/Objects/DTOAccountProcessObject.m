//
//  DTOAccountProcessObject.m
//  OfficeOneMB
//
//  Created by macpro on 12/20/14.
//
//

#import "DTOAccountProcessObject.h"
#import "Items.h"

@implementation DTOAccountProcessObject
- (Items*)itemObject{
    Items * item = [[Items alloc] initWithKeys:[NSArray arrayWithObjects:
                                                @"accountId",
                                                @"accountLevel",
                                                @"accountType",
                                                @"activityStatus",
                                                @"address",
                                                @"areaId",
                                                @"assetTotal",
                                                @"birthday",
                                                @"branchCode",
                                                @"charter",
                                                @"clientAccountId",
                                                @"clientId",
                                                @"code",
                                                @"createdBy",
                                                @"createdDate",
                                                @"disableEmail",
                                                @"disableMeeting",
                                                @"disablePhone",
                                                @"disableSms",
                                                @"email",
                                                @"employeeCode",
                                                @"employeeNumber",
                                                @"familyIncome",
                                                @"fax",
                                                @"identifiedIssueArea",
                                                @"identifiedIssueDate",
                                                @"identifiedNumber",
                                                @"industryBusiness",
                                                @"isActive",
                                                @"languageId",
                                                @"lastTransaction",
                                                @"lat",
                                                @"lon",
                                                @"marialStatus",
                                                @"mnemonic",
                                                @"mobile",
                                                @"name",
                                                @"openCodeDate",
                                                @"orgType",
                                                @"ownerEmployeeId",
                                                @"personalIncome",
                                                @"personalIndustry",
                                                @"phone",
                                                @"registrationAddress",
                                                @"registrationDate",
                                                @"registrationNumber",
                                                @"revenue",
                                                @"sector",
                                                @"setupDate",
                                                @"sex",
                                                @"shareholderNumber",
                                                @"status",
                                                @"swiftCode",
                                                @"sysOrganizationId",
                                                @"taxCode",
                                                @"taxIssuedDate",
                                                @"updatedBy",
                                                @"updatedDate",
                                                @"website",
                                                @"id",
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
                       @"accountId",
                       @"accountLevel",
                       @"accountType",
                       @"activityStatus",
                       @"address",
                       @"areaId",
                       @"assetTotal",
                       @"birthday",
                       @"branchCode",
                       @"charter",
                       @"clientAccountId",
                       @"clientId",
                       @"code",
                       @"createdBy",
                       @"createdDate",
                       @"disableEmail",
                       @"disableMeeting",
                       @"disablePhone",
                       @"disableSms",
                       @"email",
                       @"employeeCode",
                       @"employeeNumber",
                       @"familyIncome",
                       @"fax",
                       @"identifiedIssueArea",
                       @"identifiedIssueDate",
                       @"identifiedNumber",
                       @"industryBusiness",
                       @"isActive",
                       @"languageId",
                       @"lastTransaction",
                       @"lat",
                       @"lon",
                       @"marialStatus",
                       @"mnemonic",
                       @"mobile",
                       @"name",
                       @"openCodeDate",
                       @"orgType",
                       @"ownerEmployeeId",
                       @"personalIncome",
                       @"personalIndustry",
                       @"phone",
                       @"registrationAddress",
                       @"registrationDate",
                       @"registrationNumber",
                       @"revenue",
                       @"sector",
                       @"setupDate",
                       @"sex",
                       @"shareholderNumber",
                       @"status",
                       @"swiftCode",
                       @"sysOrganizationId",
                       @"taxCode",
                       @"taxIssuedDate",
                       @"updatedBy",
                       @"updatedDate",
                       @"website",
                       @"id",
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
