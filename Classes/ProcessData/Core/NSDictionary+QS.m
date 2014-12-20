//
//  NSDictionaryExtends.m
//  OfficeOneMB
//
//  Created by Pham Ngoc Hoang on 12/20/14.
//
//

#import "NSDictionary+QS.h"

#import "StringUtil.h"

@implementation NSDictionary (QS)

-(DTOAcountLeadProcessObject*)dtoAcountLeadProcessOb{
    DTOAcountLeadProcessObject *accountLeadOB = [[DTOAcountLeadProcessObject alloc] init];
    
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_accountId]]) {
         accountLeadOB.accountId = [self objectForKey:DTOLEAD_accountId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_address]]) {
        accountLeadOB.address = [self objectForKey:DTOLEAD_address];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_areaId]]) {
        accountLeadOB.areaId = [self objectForKey:DTOLEAD_areaId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_assetTotal]]) {
        accountLeadOB.assetTotal = [self objectForKey:DTOLEAD_assetTotal];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_auditId]]) {
        accountLeadOB.auditId = [self objectForKey:DTOLEAD_auditId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_birthday]]) {
        accountLeadOB.birthday = [self objectForKey:DTOLEAD_birthday];
    }
    
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_campaignId]]) {
        accountLeadOB.campaignId = [self objectForKey:DTOLEAD_campaignId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_clientId]]) {
        accountLeadOB.clientId = [self objectForKey:DTOLEAD_clientId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_clientLeadId]]) {
        accountLeadOB.clientLeadId = [self objectForKey:DTOLEAD_clientLeadId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_code]]) {
        accountLeadOB.code = [self objectForKey:DTOLEAD_code];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_companyPhone]]) {
        accountLeadOB.companyPhone = [self objectForKey:DTOLEAD_companyPhone];
    }
    
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_createdBy]]) {
        accountLeadOB.createdBy = [self objectForKey:DTOLEAD_createdBy];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_createdDate]]) {
        accountLeadOB.createdDate = [self objectForKey:DTOLEAD_createdDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_charter]]) {
        accountLeadOB.charter = [self objectForKey:DTOLEAD_charter];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_disableEmail]]) {
        accountLeadOB.disableEmail = [self objectForKey:DTOLEAD_disableEmail];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_disableMeeting]]) {
        accountLeadOB.disableMeeting = [self objectForKey:DTOLEAD_disableMeeting];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_disablePhone]]) {
        accountLeadOB.disablePhone = [self objectForKey:DTOLEAD_disablePhone];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_disableSms]]) {
        accountLeadOB.disableSms = [self objectForKey:DTOLEAD_disableSms];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_email]]) {
        accountLeadOB.email = [self objectForKey:DTOLEAD_email];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_employeeNumber]]) {
        accountLeadOB.employeeNumber = [self objectForKey:DTOLEAD_employeeNumber];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_equityOwner]]) {
        accountLeadOB.equityOwner = [self objectForKey:DTOLEAD_equityOwner];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_fax]]) {
        accountLeadOB.fax = [self objectForKey:DTOLEAD_fax];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_identifiedNumber]]) {
        accountLeadOB.identifiedNumber = [self objectForKey:DTOLEAD_identifiedNumber];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_isFi]]) {
        accountLeadOB.isFi = [self objectForKey:DTOLEAD_isFi];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_languageId]]) {
        accountLeadOB.languageId = [self objectForKey:DTOLEAD_languageId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_lat]]) {
        accountLeadOB.languageId = [self objectForKey:DTOLEAD_lat];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_leadId]]) {
        accountLeadOB.leadId = [self objectForKey:DTOLEAD_leadId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_leadStatusId]]) {
        accountLeadOB.leadStatusId = [self objectForKey:DTOLEAD_leadStatusId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_leadType]]) {
        accountLeadOB.leadType = [self objectForKey:DTOLEAD_leadType];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_lon]]) {
        accountLeadOB.lon = [self objectForKey:DTOLEAD_lon];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_marialStatus]]) {
        accountLeadOB.marialStatus = [self objectForKey:DTOLEAD_marialStatus];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_mergedLeadId]]) {
        accountLeadOB.mergedLeadId = [self objectForKey:DTOLEAD_mergedLeadId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_mobile]]) {
        accountLeadOB.mobile = [self objectForKey:DTOLEAD_mobile];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_monthlyIncome]]) {
        accountLeadOB.monthlyIncome = [self objectForKey:DTOLEAD_monthlyIncome];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_name]]) {
        accountLeadOB.name = [self objectForKey:DTOLEAD_name];
    }
    return accountLeadOB;
}

-(DTOAccountProcessObject*)dtoAcountProcessOb{
    DTOAccountProcessObject *kh360OB = [[DTOAccountProcessObject alloc] init];
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_name]]) {
        kh360OB.name = [self objectForKey:DTOACCOUNT_name];
    }
    return kh360OB;
}


@end
