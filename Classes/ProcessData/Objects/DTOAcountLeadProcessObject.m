//
//  DTOAcountLeadProcessObject.m
//  OfficeOneMB
//
//  Created by Pham Ngoc Hoang on 12/20/14.
//
//

#import "DTOAcountLeadProcessObject.h"

#import "Items.h"

@implementation DTOAcountLeadProcessObject

- (Items*)itemObject{
    Items * item = [[Items alloc] initWithKeys:[NSArray arrayWithObjects:
                                                @"accountId",
                                                @"address",
                                                @"areaId",
                                                @"assetTotal",
                                                @"auditId",
                                                @"birthday",
                                                @"campaignId",
                                                @"clientId",
                                                @"clientLeadId",
                                                @"code",
                                                @"companyPhone",
                                                @"createdBy",
                                                @"createdDate",
                                                @"charter",
                                                @"disableEmail",
                                                @"disableMeeting",
                                                @"disablePhone",
                                                @"disableSms",
                                                @"email",
                                                @"employeeNumber",
                                                @"equityOwner",
                                                @"fax",
                                                @"identifiedNumber",
                                                @"isFi",
                                                @"languageId",
                                                @"lat",
                                                @"leadId",
                                                @"leadStatusId",
                                                @"leadType",
                                                @"lon",
                                                @"marialStatus",
                                                @"mergedLeadId",
                                                @"mobile",
                                                @"monthlyIncome",
                                                @"name",
                                                @"orgTypeId",
                                                @"organization",
                                                @"ownerEmployeeId",
                                                @"passport",
                                                @"personalJob",
                                                @"personalPosition",
                                                @"phone",
                                                @"pinMilitary",
                                                @"profitNonTax",
                                                @"registrationNumber",
                                                @"revenue",
                                                @"sector",
                                                @"sex",
                                                @"shareholderNumber",
                                                @"sourceDescription",
                                                @"sourceId",
                                                @"status",
                                                @"statusDescription",
                                                @"swiftCode",
                                                @"sysOrganizationId",
                                                @"taxCode",
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
                       @"address",
                       @"areaId",
                       @"assetTotal",
                       @"auditId",
                       @"birthday",
                       @"campaignId",
                       @"clientId",
                       @"clientLeadId",
                       @"code",
                       @"companyPhone",
                       @"createdBy",
                       @"createdDate",
                       @"charter",
                       @"disableEmail",
                       @"disableMeeting",
                       @"disablePhone",
                       @"disableSms",
                       @"email",
                       @"employeeNumber",
                       @"equityOwner",
                       @"fax",
                       @"identifiedNumber",
                       @"isFi",
                       @"languageId",
                       @"lat",
                       @"leadId",
                       @"leadStatusId",
                       @"leadType",
                       @"lon",
                       @"marialStatus",
                       @"mergedLeadId",
                       @"mobile",
                       @"monthlyIncome",
                       @"name",
                       @"orgTypeId",
                       @"organization",
                       @"ownerEmployeeId",
                       @"passport",
                       @"personalJob",
                       @"personalPosition",
                       @"phone",
                       @"pinMilitary",
                       @"profitNonTax",
                       @"registrationNumber",
                       @"revenue",
                       @"sector",
                       @"sex",
                       @"shareholderNumber",
                       @"sourceDescription",
                       @"sourceId",
                       @"status",
                       @"statusDescription",
                       @"swiftCode",
                       @"sysOrganizationId",
                       @"taxCode",
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
