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

-(DTOProTindungDetailObject*)dtoProTindungDetailObject{
    DTOProTindungDetailObject *proTinDungDetailOB = [[DTOProTindungDetailObject alloc] init];
    
    if (![StringUtil stringIsEmpty:[self objectForKey:@"BRANCH_CODE"]]) {
        proTinDungDetailOB.BRANCH_CODE = [self objectForKey:@"BRANCH_CODE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"CONTRACT_NUMBER"]]) {
        proTinDungDetailOB.CONTRACT_NUMBER = [self objectForKey:@"CONTRACT_NUMBER"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"OPEN_DATE"]]) {
        proTinDungDetailOB.OPEN_DATE = [self objectForKey:@"OPEN_DATE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"EXPIRE_DATE"]]) {
        proTinDungDetailOB.EXPIRE_DATE = [self objectForKey:@"EXPIRE_DATE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"EXTENSION_DATE"]]) {
        proTinDungDetailOB.EXTENSION_DATE = [self objectForKey:@"EXTENSION_DATE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"BALANCE"]]) {
        proTinDungDetailOB.BALANCE = [self objectForKey:@"BALANCE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"BALANCE_QD"]]) {
        proTinDungDetailOB.BALANCE_QD = [self objectForKey:@"BALANCE_QD"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"SOD_BALANCE"]]) {
        proTinDungDetailOB.SOD_BALANCE = [self objectForKey:@"SOD_BALANCE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"SOD_BALANCE_QD"]]) {
        proTinDungDetailOB.SOD_BALANCE_QD = [self objectForKey:@"SOD_BALANCE_QD"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"CURRENCY"]]) {
        proTinDungDetailOB.CURRENCY = [self objectForKey:@"CURRENCY"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"CLIENT_ID"]]) {
        proTinDungDetailOB.CLIENT_ID = [self objectForKey:@"CLIENT_ID"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"TERM"]]) {
        proTinDungDetailOB.TERM = [self objectForKey:@"TERM"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"TERM_TYPE"]]) {
        proTinDungDetailOB.TERM_TYPE = [self objectForKey:@"TERM_TYPE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"DEPT_GROUP"]]) {
        proTinDungDetailOB.DEPT_GROUP = [self objectForKey:@"DEPT_GROUP"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"DEPT_GROUP2"]]) {
        proTinDungDetailOB.DEPT_GROUP2 = [self objectForKey:@"DEPT_GROUP2"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"FIXED_INTEREST"]]) {
        proTinDungDetailOB.FIXED_INTEREST = [self objectForKey:@"FIXED_INTEREST"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"INTEREST_MARGIN"]]) {
        proTinDungDetailOB.INTEREST_MARGIN = [self objectForKey:@"INTEREST_MARGIN"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"INTEREST"]]) {
        proTinDungDetailOB.INTEREST = [self objectForKey:@"INTEREST"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"RECEIVEABLE_AMOUNT"]]) {
        proTinDungDetailOB.RECEIVEABLE_AMOUNT = [self objectForKey:@"RECEIVEABLE_AMOUNT"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"STATUS"]]) {
        proTinDungDetailOB.STATUS = [self objectForKey:@"STATUS"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"BUSSINESS_DATE"]]) {
        proTinDungDetailOB.BUSSINESS_DATE = [self objectForKey:@"BUSSINESS_DATE"];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:@"INITIAL_BALANCE"]]) {
        proTinDungDetailOB.INITIAL_BALANCE = [self objectForKey:@"INITIAL_BALANCE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"PREPAID_INTEREST"]]) {
        proTinDungDetailOB.PREPAID_INTEREST = [self objectForKey:@"PREPAID_INTEREST"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"OVERDUE_INTEREST"]]) {
        proTinDungDetailOB.OVERDUE_INTEREST = [self objectForKey:@"OVERDUE_INTEREST"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"SECTOR"]]) {
        proTinDungDetailOB.SECTOR = [self objectForKey:@"SECTOR"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"SOURCE_OF_FUND"]]) {
        proTinDungDetailOB.SOURCE_OF_FUND = [self objectForKey:@"SOURCE_OF_FUND"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"SECURE"]]) {
        proTinDungDetailOB.SECURE = [self objectForKey:@"SECURE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"GL"]]) {
        proTinDungDetailOB.GL = [self objectForKey:@"GL"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"INDUSTRY_CODE"]]) {
        proTinDungDetailOB.INDUSTRY_CODE = [self objectForKey:@"INDUSTRY_CODE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"INTEREST_TYPE"]]) {
        proTinDungDetailOB.INTEREST_TYPE = [self objectForKey:@"INTEREST_TYPE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"INTEREST_KEY"]]) {
        proTinDungDetailOB.INTEREST_KEY = [self objectForKey:@"INTEREST_KEY"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"INPUTTER"]]) {
        proTinDungDetailOB.INPUTTER = [self objectForKey:@"INPUTTER"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"PRODUCT_CODE"]]) {
        proTinDungDetailOB.PRODUCT_CODE = [self objectForKey:@"PRODUCT_CODE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"RM_CODE"]]) {
        proTinDungDetailOB.RM_CODE = [self objectForKey:@"RM_CODE"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"KHOI"]]) {
        proTinDungDetailOB.KHOI = [self objectForKey:@"KHOI"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"RM_BANCHEO"]]) {
        proTinDungDetailOB.RM_BANCHEO = [self objectForKey:@"RM_BANCHEO"];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:@"PURPOSE"]]) {
        proTinDungDetailOB.PURPOSE = [self objectForKey:@"PURPOSE"];
    }

    return proTinDungDetailOB;
}

-(DTOWidgetTypeObject*)dtoWidgetTypeObject{
    DTOWidgetTypeObject *widgetTypeOB = [[DTOWidgetTypeObject alloc] init];

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGETTYPE_widgetId]]) {
        widgetTypeOB.widgetId = [self objectForKey:DTOWIDGETTYPE_widgetId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGETTYPE_widgetName]]) {
        widgetTypeOB.widgetName = [self objectForKey:DTOWIDGETTYPE_widgetName];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGETTYPE_widgetType]]) {
        widgetTypeOB.widgetType = [self objectForKey:DTOWIDGETTYPE_widgetType];
    }
    return widgetTypeOB;
}

-(DTOWidgetObject*)dtoWidgetObject{
    DTOWidgetObject *widgetOB = [[DTOWidgetObject alloc] init];

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGET_confId]]) {
        widgetOB.confId = [self objectForKey:DTOWIDGET_confId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGET_accountName]]) {
        widgetOB.accountName = [self objectForKey:DTOWIDGET_accountName];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGET_typeGraphically]]) {
        widgetOB.typeGraphically = [self objectForKey:DTOWIDGET_typeGraphically];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGET_colorDisplay1]]) {
        widgetOB.colorDisplay1 = [self objectForKey:DTOWIDGET_colorDisplay1];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGET_createDate]]) {
        widgetOB.createDate = [self objectForKey:DTOWIDGET_createDate];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGET_isShowData]]) {
        widgetOB.isShowData = [self objectForKey:DTOWIDGET_isShowData];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGET_colorDisplay2]]) {
        widgetOB.colorDisplay2 = [self objectForKey:DTOWIDGET_colorDisplay2];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGET_widgetId]]) {
        widgetOB.widgetId = [self objectForKey:DTOWIDGET_widgetId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGET_widgetName]]) {
        widgetOB.widgetName = [self objectForKey:DTOWIDGET_widgetName];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGET_widgetType]]) {
        widgetOB.widgetType = [self objectForKey:DTOWIDGET_widgetType];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOWIDGET_status]]) {
        widgetOB.status = [self objectForKey:DTOWIDGET_status];
    }

    return widgetOB;
}


-(DTOTaskObject*)dtoTaskObject{
    DTOTaskObject *taskOB = [[DTOTaskObject alloc] init];
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOTASK_id]]) {
        taskOB.id = [self objectForKey:DTOTASK_id];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOTASK_clientTaskId]]) {
        taskOB.clientTaskId = [self objectForKey:DTOTASK_clientTaskId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOTASK_clientId]]) {
        taskOB.clientId = [self objectForKey:DTOTASK_clientId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOTASK_clientLeadId]]) {
        taskOB.clientLeadId = [self objectForKey:DTOTASK_clientLeadId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOTASK_title]]) {
        taskOB.title = [self objectForKey:DTOTASK_title];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOTASK_startDate]]) {
        taskOB.startDate = [self objectForKey:DTOTASK_startDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOTASK_endDate]]) {
        taskOB.endDate = [self objectForKey:DTOTASK_endDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOTASK_updatedDate]]) {
        taskOB.updatedDate = [self objectForKey:DTOTASK_updatedDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOTASK_taskStatus]]) {
        taskOB.taskStatus = [self objectForKey:DTOTASK_taskStatus];
    }
    return taskOB;
}

-(DTOComplainObject*)dtoComplainObject{
    DTOComplainObject *complainOB = [[DTOComplainObject alloc] init];

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_casesId]]) {
        complainOB.casesId = [self objectForKey:DTOCOMPLAIN_casesId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_code]]) {
        complainOB.code = [self objectForKey:DTOCOMPLAIN_code];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_content]]) {
        complainOB.content = [self objectForKey:DTOCOMPLAIN_content];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_reason]]) {
        complainOB.reason = [self objectForKey:DTOCOMPLAIN_reason];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_result]]) {
        complainOB.result = [self objectForKey:DTOCOMPLAIN_result];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_fromReceived]]) {
        complainOB.fromReceived = [self objectForKey:DTOCOMPLAIN_fromReceived];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_type]]) {
        complainOB.type = [self objectForKey:DTOCOMPLAIN_type];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_priority]]) {
        complainOB.priority = [self objectForKey:DTOCOMPLAIN_priority];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_receiverId]]) {
        complainOB.receiverId = [self objectForKey:DTOCOMPLAIN_receiverId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_receivedDate]]) {
        complainOB.receivedDate = [self objectForKey:DTOCOMPLAIN_receivedDate];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_processerId]]) {
        complainOB.processerId = [self objectForKey:DTOCOMPLAIN_processerId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_processedDate]]) {
        complainOB.processedDate = [self objectForKey:DTOCOMPLAIN_processedDate];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_closedId]]) {
        complainOB.closedId = [self objectForKey:DTOCOMPLAIN_closedId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_closedDate]]) {
        complainOB.closedDate = [self objectForKey:DTOCOMPLAIN_closedDate];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_accountId]]) {
        complainOB.accountId = [self objectForKey:DTOCOMPLAIN_accountId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_productMasterId]]) {
        complainOB.productMasterId = [self objectForKey:DTOCOMPLAIN_productMasterId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_acceptTypeId]]) {
        complainOB.acceptTypeId = [self objectForKey:DTOCOMPLAIN_acceptTypeId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_agentText]]) {
        complainOB.agentText = [self objectForKey:DTOCOMPLAIN_agentText];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_assignBy]]) {
        complainOB.assignBy = [self objectForKey:DTOCOMPLAIN_assignBy];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_blackList]]) {
        complainOB.blackList = [self objectForKey:DTOCOMPLAIN_blackList];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOCOMPLAIN_callLenght]]) {
        complainOB.callLenght = [self objectForKey:DTOCOMPLAIN_callLenght];
    }

    return complainOB;
}


-(DTOProductMasterObject*)dtoProductMasterObject{
    DTOProductMasterObject *productMasterOB = [[DTOProductMasterObject alloc] init];

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTMASTER_code]]) {
        productMasterOB.code = [self objectForKey:DTOPRODUCTMASTER_code];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTMASTER_name]]) {
        productMasterOB.name = [self objectForKey:DTOPRODUCTMASTER_name];
    }

    return productMasterOB;

}

-(DTOProductDetailObject*)dtoProductDetailObject{
    DTOProductDetailObject *productDetailOB = [[DTOProductDetailObject alloc] init];

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_productDetailId]]) {
        productDetailOB.productDetailId = [self objectForKey:DTOPRODUCTDETAIL_productDetailId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_contractNumber]]) {
        productDetailOB.contractNumber = [self objectForKey:DTOPRODUCTDETAIL_contractNumber];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_balance]]) {
        productDetailOB.balance = [self objectForKey:DTOPRODUCTDETAIL_balance];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_openDate]]) {
        productDetailOB.openDate = [self objectForKey:DTOPRODUCTDETAIL_openDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_expiredDate]]) {
        productDetailOB.expiredDate = [self objectForKey:DTOPRODUCTDETAIL_expiredDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_status]]) {
        productDetailOB.status = [self objectForKey:DTOPRODUCTDETAIL_status];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_type]]) {
        productDetailOB.type = [self objectForKey:DTOPRODUCTDETAIL_type];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_branchCode]]) {
        productDetailOB.branchCode = [self objectForKey:DTOPRODUCTDETAIL_branchCode];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_currency]]) {
        productDetailOB.currency = [self objectForKey:DTOPRODUCTDETAIL_currency];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_productCode]]) {
        productDetailOB.productCode = [self objectForKey:DTOPRODUCTDETAIL_productCode];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_clientId]]) {
        productDetailOB.clientId = [self objectForKey:DTOPRODUCTDETAIL_clientId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_bussinessDate]]) {
        productDetailOB.bussinessDate = [self objectForKey:DTOPRODUCTDETAIL_bussinessDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_createdDate]]) {
        productDetailOB.createdDate = [self objectForKey:DTOPRODUCTDETAIL_createdDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_updatedDate]]) {
        productDetailOB.updatedDate = [self objectForKey:DTOPRODUCTDETAIL_updatedDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_rmCode]]) {
        productDetailOB.rmCode = [self objectForKey:DTOPRODUCTDETAIL_rmCode];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_balanceQD]]) {
        productDetailOB.balanceQD = [self objectForKey:DTOPRODUCTDETAIL_balanceQD];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_Khoi]]) {
        productDetailOB.Khoi = [self objectForKey:DTOPRODUCTDETAIL_Khoi];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTDETAIL_rmBancheo]]) {
        productDetailOB.rmBancheo = [self objectForKey:DTOPRODUCTDETAIL_rmBancheo];
    }
    return productDetailOB;
}

-(DTOProductLeadTypeObject*)dtoProductLeadTypeObject{
    DTOProductLeadTypeObject *productTypeLeadOB = [[DTOProductLeadTypeObject alloc] init];

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTTYPE_productTypeId]]) {
        productTypeLeadOB.productTypeId = [self objectForKey:DTOPRODUCTTYPE_productTypeId];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTTYPE_name]]) {
        productTypeLeadOB.name = [self objectForKey:DTOPRODUCTTYPE_name];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTTYPE_code]]) {
        productTypeLeadOB.code = [self objectForKey:DTOPRODUCTTYPE_code];
    }

    if (![StringUtil stringIsEmpty:[self objectForKey:DTOPRODUCTTYPE_isActive]]) {
        productTypeLeadOB.isActive = [self objectForKey:DTOPRODUCTTYPE_isActive];
    }
    return productTypeLeadOB;
}


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
        accountLeadOB.lat = [self objectForKey:DTOLEAD_lat];
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
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_orgTypeId]]) {
        accountLeadOB.orgTypeId = [self objectForKey:DTOLEAD_orgTypeId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_organization]]) {
        accountLeadOB.organization = [self objectForKey:DTOLEAD_organization];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_ownerEmployeeId]]) {
        accountLeadOB.ownerEmployeeId = [self objectForKey:DTOLEAD_ownerEmployeeId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_passport]]) {
        accountLeadOB.passport = [self objectForKey:DTOLEAD_passport];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_personalJob]]) {
        accountLeadOB.personalJob = [self objectForKey:DTOLEAD_personalJob];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_personalPosition]]) {
        accountLeadOB.personalPosition = [self objectForKey:DTOLEAD_personalPosition];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_phone]]) {
        accountLeadOB.phone = [self objectForKey:DTOLEAD_phone];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_pinMilitary]]) {
        accountLeadOB.pinMilitary = [self objectForKey:DTOLEAD_pinMilitary];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_profitNonTax]]) {
        accountLeadOB.profitNonTax = [self objectForKey:DTOLEAD_profitNonTax];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_registrationNumber]]) {
        accountLeadOB.registrationNumber = [self objectForKey:DTOLEAD_registrationNumber];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_revenue]]) {
        accountLeadOB.revenue = [self objectForKey:DTOLEAD_revenue];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_sector]]) {
        accountLeadOB.sector = [self objectForKey:DTOLEAD_sector];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_sex]]) {
        accountLeadOB.sex = [self objectForKey:DTOLEAD_sex];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_shareholderNumber]]) {
        accountLeadOB.shareholderNumber = [self objectForKey:DTOLEAD_shareholderNumber];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_sourceDescription]]) {
        accountLeadOB.sourceDescription = [self objectForKey:DTOLEAD_sourceDescription];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_sourceId]]) {
        accountLeadOB.sourceId = [self objectForKey:DTOLEAD_sourceId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_status]]) {
        accountLeadOB.status = [self objectForKey:DTOLEAD_status];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_statusDescription]]) {
        accountLeadOB.statusDescription = [self objectForKey:DTOLEAD_statusDescription];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_swiftCode]]) {
        accountLeadOB.swiftCode = [self objectForKey:DTOLEAD_swiftCode];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_sysOrganizationId]]) {
        accountLeadOB.sysOrganizationId = [self objectForKey:DTOLEAD_sysOrganizationId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_taxCode]]) {
        accountLeadOB.taxCode = [self objectForKey:DTOLEAD_taxCode];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_updatedBy]]) {
        accountLeadOB.updatedBy = [self objectForKey:DTOLEAD_updatedBy];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_updatedDate]]) {
        accountLeadOB.updatedDate = [self objectForKey:DTOLEAD_updatedDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_website]]) {
        accountLeadOB.website = [self objectForKey:DTOLEAD_website];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOLEAD_id]]) {
        accountLeadOB.id = [self objectForKey:DTOLEAD_id];
    }

    return accountLeadOB;
}

-(DTOAccountProcessObject*)dtoAcountProcessOb{
    DTOAccountProcessObject *kh360OB = [[DTOAccountProcessObject alloc] init];
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_accountId]]) {
        kh360OB.accountId = [self objectForKey:DTOACCOUNT_accountId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_accountLevel]]) {
        kh360OB.accountLevel = [self objectForKey:DTOACCOUNT_accountLevel];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_accountType]]) {
        kh360OB.accountType = [self objectForKey:DTOACCOUNT_accountType];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_activityStatus]]) {
        kh360OB.activityStatus = [self objectForKey:DTOACCOUNT_activityStatus];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_address]]) {
        kh360OB.address = [self objectForKey:DTOACCOUNT_address];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_areaId]]) {
        kh360OB.areaId = [self objectForKey:DTOACCOUNT_areaId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_assetTotal]]) {
        kh360OB.assetTotal = [self objectForKey:DTOACCOUNT_assetTotal];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_birthday]]) {
        kh360OB.birthday = [self objectForKey:DTOACCOUNT_birthday];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_branchCode]]) {
        kh360OB.branchCode = [self objectForKey:DTOACCOUNT_branchCode];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_charter]]) {
        kh360OB.charter = [self objectForKey:DTOACCOUNT_charter];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_clientAccountId]]) {
        kh360OB.clientAccountId = [self objectForKey:DTOACCOUNT_clientAccountId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_clientId]]) {
        kh360OB.clientId = [self objectForKey:DTOACCOUNT_clientId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_code]]) {
        kh360OB.code = [self objectForKey:DTOACCOUNT_code];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_createdBy]]) {
        kh360OB.createdBy = [self objectForKey:DTOACCOUNT_createdBy];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_createdDate]]) {
        kh360OB.createdDate = [self objectForKey:DTOACCOUNT_createdDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_disableEmail]]) {
        kh360OB.disableEmail = [self objectForKey:DTOACCOUNT_disableEmail];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_disableMeeting]]) {
        kh360OB.disableMeeting = [self objectForKey:DTOACCOUNT_disableMeeting];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_disablePhone]]) {
        kh360OB.disablePhone = [self objectForKey:DTOACCOUNT_disablePhone];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_disableSms]]) {
        kh360OB.disableSms = [self objectForKey:DTOACCOUNT_disableSms];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_email]]) {
        kh360OB.email = [self objectForKey:DTOACCOUNT_email];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_employeeCode]]) {
        kh360OB.employeeCode = [self objectForKey:DTOACCOUNT_employeeCode];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_employeeNumber]]) {
        kh360OB.employeeNumber = [self objectForKey:DTOACCOUNT_employeeNumber];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_familyIncome]]) {
        kh360OB.familyIncome = [self objectForKey:DTOACCOUNT_familyIncome];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_fax]]) {
        kh360OB.fax = [self objectForKey:DTOACCOUNT_fax];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_identifiedIssueArea]]) {
        kh360OB.identifiedIssueArea = [self objectForKey:DTOACCOUNT_identifiedIssueArea];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_identifiedIssueDate]]) {
        kh360OB.identifiedIssueDate = [self objectForKey:DTOACCOUNT_identifiedIssueDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_identifiedNumber]]) {
        kh360OB.identifiedNumber = [self objectForKey:DTOACCOUNT_identifiedNumber];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_industryBusiness]]) {
        kh360OB.industryBusiness = [self objectForKey:DTOACCOUNT_industryBusiness];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_isActive]]) {
        kh360OB.isActive = [self objectForKey:DTOACCOUNT_isActive];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_languageId]]) {
        kh360OB.languageId = [self objectForKey:DTOACCOUNT_languageId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_lastTransaction]]) {
        kh360OB.lastTransaction = [self objectForKey:DTOACCOUNT_lastTransaction];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_lat]]) {
        kh360OB.lat = [self objectForKey:DTOACCOUNT_lat];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_lon]]) {
        kh360OB.lon = [self objectForKey:DTOACCOUNT_lon];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_marialStatus]]) {
        kh360OB.marialStatus = [self objectForKey:DTOACCOUNT_marialStatus];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_mnemonic]]) {
        kh360OB.mnemonic = [self objectForKey:DTOACCOUNT_mnemonic];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_mobile]]) {
        kh360OB.mobile = [self objectForKey:DTOACCOUNT_mobile];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_name]]) {
        kh360OB.name = [self objectForKey:DTOACCOUNT_name];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_openCodeDate]]) {
        kh360OB.openCodeDate = [self objectForKey:DTOACCOUNT_openCodeDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_orgType]]) {
        kh360OB.orgType = [self objectForKey:DTOACCOUNT_orgType];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_ownerEmployeeId]]) {
        kh360OB.ownerEmployeeId = [self objectForKey:DTOACCOUNT_ownerEmployeeId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_personalIncome]]) {
        kh360OB.personalIncome = [self objectForKey:DTOACCOUNT_personalIncome];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_personalIndustry]]) {
        kh360OB.personalIndustry = [self objectForKey:DTOACCOUNT_personalIndustry];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_phone]]) {
        kh360OB.phone = [self objectForKey:DTOACCOUNT_phone];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_registrationAddress]]) {
        kh360OB.registrationAddress = [self objectForKey:DTOACCOUNT_registrationAddress];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_registrationDate]]) {
        kh360OB.registrationDate = [self objectForKey:DTOACCOUNT_registrationDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_registrationNumber]]) {
        kh360OB.registrationNumber = [self objectForKey:DTOACCOUNT_registrationNumber];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_revenue]]) {
        kh360OB.revenue = [self objectForKey:DTOACCOUNT_revenue];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_sector]]) {
        kh360OB.sector = [self objectForKey:DTOACCOUNT_sector];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_setupDate]]) {
        kh360OB.setupDate = [self objectForKey:DTOACCOUNT_setupDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_sex]]) {
        kh360OB.sex = [self objectForKey:DTOACCOUNT_sex];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_shareholderNumber]]) {
        kh360OB.shareholderNumber = [self objectForKey:DTOACCOUNT_shareholderNumber];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_status]]) {
        kh360OB.status = [self objectForKey:DTOACCOUNT_status];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_swiftCode]]) {
        kh360OB.swiftCode = [self objectForKey:DTOACCOUNT_swiftCode];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_sysOrganizationId]]) {
        kh360OB.sysOrganizationId = [self objectForKey:DTOACCOUNT_sysOrganizationId];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_taxCode]]) {
        kh360OB.taxCode = [self objectForKey:DTOACCOUNT_taxCode];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_taxIssuedDate]]) {
        kh360OB.taxIssuedDate = [self objectForKey:DTOACCOUNT_taxIssuedDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_updatedBy]]) {
        kh360OB.updatedBy = [self objectForKey:DTOACCOUNT_updatedBy];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_updatedDate]]) {
        kh360OB.updatedDate = [self objectForKey:DTOACCOUNT_updatedDate];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_website]]) {
        kh360OB.website = [self objectForKey:DTOACCOUNT_website];
    }
    if (![StringUtil stringIsEmpty:[self objectForKey:DTOACCOUNT_id]]) {
        kh360OB.id = [self objectForKey:DTOACCOUNT_id];
    }
    return kh360OB;
}


@end
