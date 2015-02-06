//
//  DataField.h
//  OfficeOneStudy
//
//  Created by viettel on 10/31/14.
//
//

#import <Foundation/Foundation.h>

///android_metadata  Field
#define ANDROID_METADATA_locale @"locale" //TEXT
///dtosyscat  Field
#define DTOSYSCAT_code @"code" //VARCHAR
#define DTOSYSCAT_createdBy @"createdBy" //BIGINT
#define DTOSYSCAT_createdDate @"createdDate" //VARCHAR
#define DTOSYSCAT_description @"description" //TEXT
#define DTOSYSCAT_isActive @"isActive" //SMALLINT
#define DTOSYSCAT_isDefault @"isDefault" //SMALLINT
#define DTOSYSCAT_name @"name" //VARCHAR
#define DTOSYSCAT_orderNum @"orderNum" //INTEGER
#define DTOSYSCAT_sysCatId @"sysCatId" //BIGINT
#define DTOSYSCAT_sysCatTypeId @"sysCatTypeId" //BIGINT
#define DTOSYSCAT_updatedBy @"updatedBy" //BIGINT
#define DTOSYSCAT_updatedDate @"updatedDate" //VARCHAR
#define DTOSYSCAT_value @"value" //VARCHAR
#define DTOSYSCAT_id @"id" //INTEGER
///sqlite_sequence  Field
#define SQLITE_SEQUENCE_name @"name" //
#define SQLITE_SEQUENCE_seq @"seq" //
///dtohistories  Field
#define DTOHISTORIES_clientId @"clientId" //BIGINT
#define DTOHISTORIES_description @"description" //VARCHAR
#define DTOHISTORIES_serverId @"serverId" //BIGINT
#define DTOHISTORIES_tableName @"tableName" //VARCHAR
#define DTOHISTORIES_sync_status @"sync_status" //INTEGER
#define DTOHISTORIES_id @"id" //INTEGER
///dtolog  Field
#define DTOLOG_tableName @"tableName" //TEXT
#define DTOLOG_isSync @"isSync" //SMALLINT
#define DTOLOG_timestamp @"timestamp" //BIGINT
#define DTOLOG_id @"id" //INTEGER
///dtoarea  Field
#define DTOAREA_areaId @"areaId" //BIGINT
#define DTOAREA_code @"code" //VARCHAR
#define DTOAREA_createdBy @"createdBy" //BIGINT
#define DTOAREA_createdDate @"createdDate" //VARCHAR
#define DTOAREA_isActive @"isActive" //SMALLINT
#define DTOAREA_name @"name" //VARCHAR
#define DTOAREA_parentId @"parentId" //BIGINT
#define DTOAREA_path @"path" //VARCHAR
#define DTOAREA_type @"type" //INTEGER
#define DTOAREA_updatedBy @"updatedBy" //BIGINT
#define DTOAREA_updatedDate @"updatedDate" //VARCHAR
#define DTOAREA_id @"id" //INTEGER
///dtosyscattype  Field
#define DTOSYSCATTYPE_code @"code" //VARCHAR
#define DTOSYSCATTYPE_createdBy @"createdBy" //BIGINT
#define DTOSYSCATTYPE_createdDate @"createdDate" //VARCHAR
#define DTOSYSCATTYPE_isActive @"isActive" //SMALLINT
#define DTOSYSCATTYPE_name @"name" //VARCHAR
#define DTOSYSCATTYPE_sysCatTypeId @"sysCatTypeId" //BIGINT
#define DTOSYSCATTYPE_updatedBy @"updatedBy" //BIGINT
#define DTOSYSCATTYPE_updatedDate @"updatedDate" //VARCHAR
#define DTOSYSCATTYPE_id @"id" //INTEGER
///dtoemployee  Field
#define DTOEMPLOYEE_address @"address" //VARCHAR
#define DTOEMPLOYEE_aoCode @"aoCode" //VARCHAR
#define DTOEMPLOYEE_birthday @"birthday" //VARCHAR
#define DTOEMPLOYEE_branch @"branch" //VARCHAR
#define DTOEMPLOYEE_code @"code" //VARCHAR
#define DTOEMPLOYEE_userLogin @"userLogin" //VARCHAR
#define DTOEMPLOYEE_dayStartPosition @"dayStartPosition" //VARCHAR
#define DTOEMPLOYEE_department @"department" //VARCHAR
#define DTOEMPLOYEE_email @"email" //VARCHAR
#define DTOEMPLOYEE_employeeId @"employeeId" //BIGINT
#define DTOEMPLOYEE_employeeType @"employeeType" //VARCHAR
#define DTOEMPLOYEE_enterOrgDate @"enterOrgDate" //VARCHAR
#define DTOEMPLOYEE_fax @"fax" //VARCHAR
#define DTOEMPLOYEE_fullName @"fullName" //VARCHAR
#define DTOEMPLOYEE_hrisCode @"hrisCode" //VARCHAR
#define DTOEMPLOYEE_isActive @"isActive" //INTEGER
#define DTOEMPLOYEE_levelEmployee @"levelEmployee" //BIGINT
#define DTOEMPLOYEE_mobile @"mobile" //VARCHAR
#define DTOEMPLOYEE_userId @"userId" //BIGINT
#define DTOEMPLOYEE_phone @"phone" //VARCHAR
#define DTOEMPLOYEE_phoneOrg @"phoneOrg" //VARCHAR
#define DTOEMPLOYEE_phoneRetail @"phoneRetail" //VARCHAR
#define DTOEMPLOYEE_position @"position" //VARCHAR
#define DTOEMPLOYEE_sex @"sex" //VARCHAR
#define DTOEMPLOYEE_sysOrganizationId @"sysOrganizationId" //BIGINT
#define DTOEMPLOYEE_title @"title" //VARCHAR
#define DTOEMPLOYEE_updatedDate @"updatedDate" //VARCHAR
#define DTOEMPLOYEE_month @"month" //INTEGER
#define DTOEMPLOYEE_day @"day" //INTEGER
#define DTOEMPLOYEE_id @"id" //INTEGER
///dtocampaign  Field
#define DTOCAMPAIGN_accountType @"accountType" //VARCHAR
#define DTOCAMPAIGN_budget @"budget" //VARCHAR
#define DTOCAMPAIGN_campaignCategory @"campaignCategory" //VARCHAR
#define DTOCAMPAIGN_campaignsId @"campaignsId" //BIGINT
#define DTOCAMPAIGN_code @"code" //VARCHAR
#define DTOCAMPAIGN_condition @"condition" //VARCHAR
#define DTOCAMPAIGN_costActual @"costActual" //VARCHAR
#define DTOCAMPAIGN_createdBy @"createdBy" //BIGINT
#define DTOCAMPAIGN_createdDate @"createdDate" //BIGINT
#define DTOCAMPAIGN_distributeTo @"distributeTo" //SMALLINT
#define DTOCAMPAIGN_employeeId @"employeeId" //BIGINT
#define DTOCAMPAIGN_endDate @"endDate" //VARCHAR
#define DTOCAMPAIGN_formId @"formId" //BIGINT
#define DTOCAMPAIGN_isActive @"isActive" //INTEGER
#define DTOCAMPAIGN_name @"name" //VARCHAR
#define DTOCAMPAIGN_policyApply @"policyApply" //VARCHAR
#define DTOCAMPAIGN_scope @"scope" //INTEGER
#define DTOCAMPAIGN_startDate @"startDate" //VARCHAR
#define DTOCAMPAIGN_status @"status" //INTEGER
#define DTOCAMPAIGN_sysOrganizationId @"sysOrganizationId" //BIGINT
#define DTOCAMPAIGN_typeId @"typeId" //BIGINT
#define DTOCAMPAIGN_updatedBy @"updatedBy" //BIGINT
#define DTOCAMPAIGN_updatedDate @"updatedDate" //BIGINT
#define DTOCAMPAIGN_id @"id" //INTEGER
///dtolead  Field
#define DTOLEAD_accountId @"accountId" //BIGINT
#define DTOLEAD_address @"address" //VARCHAR
#define DTOLEAD_areaId @"areaId" //BIGINT
#define DTOLEAD_assetTotal @"assetTotal" //VARCHAR
#define DTOLEAD_auditId @"auditId" //BIGINT
#define DTOLEAD_birthday @"birthday" //VARCHAR
#define DTOLEAD_campaignId @"campaignId" //BIGINT
#define DTOLEAD_clientId @"clientId" //BIGINT
#define DTOLEAD_clientLeadId @"clientLeadId" //BIGINT
#define DTOLEAD_code @"code" //VARCHAR
#define DTOLEAD_companyPhone @"companyPhone" //VARCHAR
#define DTOLEAD_createdBy @"createdBy" //BIGINT
#define DTOLEAD_createdDate @"createdDate" //VARCHAR
#define DTOLEAD_charter @"charter"
#define DTOLEAD_disableEmail @"disableEmail" //SMALLINT
#define DTOLEAD_disableMeeting @"disableMeeting" //SMALLINT
#define DTOLEAD_disablePhone @"disablePhone" //SMALLINT
#define DTOLEAD_disableSms @"disableSms" //SMALLINT
#define DTOLEAD_email @"email" //VARCHAR
#define DTOLEAD_employeeNumber @"employeeNumber" //BIGINT
#define DTOLEAD_equityOwner @"equityOwner" //VARCHAR
#define DTOLEAD_fax @"fax" //VARCHAR
#define DTOLEAD_identifiedNumber @"identifiedNumber" //VARCHAR
#define DTOLEAD_isFi @"isFi" //SMALLINT
#define DTOLEAD_languageId @"languageId" //BIGINT
#define DTOLEAD_lat @"lat" //VARCHAR
#define DTOLEAD_leadId @"leadId" //BIGINT
#define DTOLEAD_leadStatusId @"leadStatusId" //BIGINT
#define DTOLEAD_leadType @"leadType" //INTEGER
#define DTOLEAD_lon @"lon" //VARCHAR
#define DTOLEAD_marialStatus @"marialStatus" //SMALLINT
#define DTOLEAD_mergedLeadId @"mergedLeadId" //BIGINT
#define DTOLEAD_mobile @"mobile" //VARCHAR
#define DTOLEAD_monthlyIncome @"monthlyIncome" //VARCHAR
#define DTOLEAD_name @"name" //VARCHAR
#define DTOLEAD_orgTypeId @"orgTypeId" //BIGINT
#define DTOLEAD_organization @"organization" //VARCHAR
#define DTOLEAD_ownerEmployeeId @"ownerEmployeeId" //BIGINT
#define DTOLEAD_passport @"passport" //VARCHAR
#define DTOLEAD_personalJob @"personalJob" //BIGINT
#define DTOLEAD_personalPosition @"personalPosition" //BIGINT
#define DTOLEAD_phone @"phone" //VARCHAR
#define DTOLEAD_pinMilitary @"pinMilitary" //VARCHAR
#define DTOLEAD_profitNonTax @"profitNonTax" //VARCHAR
#define DTOLEAD_registrationNumber @"registrationNumber" //VARCHAR
#define DTOLEAD_revenue @"revenue" //VARCHAR
#define DTOLEAD_sector @"sector" //VARCHAR
#define DTOLEAD_sex @"sex" //VARCHAR
#define DTOLEAD_shareholderNumber @"shareholderNumber" //VARCHAR
#define DTOLEAD_sourceDescription @"sourceDescription" //VARCHAR
#define DTOLEAD_sourceId @"sourceId" //BIGINT
#define DTOLEAD_status @"status" //INTEGER
#define DTOLEAD_statusDescription @"statusDescription" //VARCHAR
#define DTOLEAD_swiftCode @"swiftCode" //VARCHAR
#define DTOLEAD_sysOrganizationId @"sysOrganizationId" //BIGINT
#define DTOLEAD_taxCode @"taxCode" //VARCHAR
#define DTOLEAD_updatedBy @"updatedBy" //BIGINT
#define DTOLEAD_updatedDate @"updatedDate" //VARCHAR
#define DTOLEAD_website @"website" //VARCHAR
#define DTOLEAD_id @"id" //INTEGER
///dtoleadcrosssell  Field
#define DTOLEADCROSSSELL_confirmNote @"confirmNote" //VARCHAR
#define DTOLEADCROSSSELL_createdBy @"createdBy" //BIGINT
#define DTOLEADCROSSSELL_createdDate @"createdDate" //VARCHAR
#define DTOLEADCROSSSELL_employeeId @"employeeId" //BIGINT
#define DTOLEADCROSSSELL_endDate @"endDate" //VARCHAR
#define DTOLEADCROSSSELL_leadCrossSellingId @"leadCrossSellingId" //BIGINT
#define DTOLEADCROSSSELL_leadId @"leadId" //BIGINT
#define DTOLEADCROSSSELL_note @"note" //VARCHAR
#define DTOLEADCROSSSELL_organizationId @"organizationId" //BIGINT
#define DTOLEADCROSSSELL_sellingEmployeeId @"sellingEmployeeId" //BIGINT
#define DTOLEADCROSSSELL_status @"status" //INTEGER
#define DTOLEADCROSSSELL_targetType @"targetType" //INTEGER
#define DTOLEADCROSSSELL_type @"type" //INTEGER
#define DTOLEADCROSSSELL_updatedBy @"updatedBy" //BIGINT
#define DTOLEADCROSSSELL_updatedDate @"updatedDate" //VARCHAR
#define DTOLEADCROSSSELL_id @"id" //INTEGER
///dtoemployeeranking  Field
#define DTOEMPLOYEERANKING_createdBy @"createdBy" //BIGINT
#define DTOEMPLOYEERANKING_createdDate @"createdDate" //VARCHAR
#define DTOEMPLOYEERANKING_employeeId @"employeeId" //BIGINT
#define DTOEMPLOYEERANKING_honor @"honor" //VARCHAR
#define DTOEMPLOYEERANKING_level1Note @"level1Note" //VARCHAR
#define DTOEMPLOYEERANKING_level2Note @"level2Note" //VARCHAR
#define DTOEMPLOYEERANKING_period @"period" //VARCHAR
#define DTOEMPLOYEERANKING_periodId @"periodId" //BIGINT
#define DTOEMPLOYEERANKING_point @"point" //VARCHAR
#define DTOEMPLOYEERANKING_rank @"rank" //VARCHAR
#define DTOEMPLOYEERANKING_updatedBy @"updatedBy" //BIGINT
#define DTOEMPLOYEERANKING_updatedDate @"updatedDate" //VARCHAR
#define DTOEMPLOYEERANKING_year @"year" //INTEGER
#define DTOEMPLOYEERANKING_id @"id" //INTEGER
///dtosysorganization  Field
#define DTOSYSORGANIZATION_address @"address" //VARCHAR
#define DTOSYSORGANIZATION_code @"code" //VARCHAR
#define DTOSYSORGANIZATION_createdBy @"createdBy" //BIGINT
#define DTOSYSORGANIZATION_createdDate @"createdDate" //VARCHAR
#define DTOSYSORGANIZATION_description @"description" //VARCHAR
#define DTOSYSORGANIZATION_isActive @"isActive" //SMALLINT
#define DTOSYSORGANIZATION_mnemomic @"mnemomic" //VARCHAR
#define DTOSYSORGANIZATION_name @"name" //VARCHAR
#define DTOSYSORGANIZATION_parentCode @"parentCode" //VARCHAR
#define DTOSYSORGANIZATION_parentId @"parentId" //BIGINT
#define DTOSYSORGANIZATION_status @"status" //SMALLINT
#define DTOSYSORGANIZATION_sysOrganizationId @"sysOrganizationId" //BIGINT
#define DTOSYSORGANIZATION_taxCode @"taxCode" //VARCHAR
#define DTOSYSORGANIZATION_type @"type" //INTEGER
#define DTOSYSORGANIZATION_updatedBy @"updatedBy" //BIGINT
#define DTOSYSORGANIZATION_updatedDate @"updatedDate" //VARCHAR
#define DTOSYSORGANIZATION_id @"id" //INTEGER
///dtoemployeeacctype  Field
#define DTOEMPLOYEEACCTYPE_accountTypeCode @"accountTypeCode" //VARCHAR
#define DTOEMPLOYEEACCTYPE_employeeAccountTypeId @"employeeAccountTypeId" //BIGINT
#define DTOEMPLOYEEACCTYPE_employeeId @"employeeId" //BIGINT
#define DTOEMPLOYEEACCTYPE_kpiRmGroupId @"kpiRmGroupId" //BIGINT
#define DTOEMPLOYEEACCTYPE_id @"id" //INTEGER
///dtoemployeegroup  Field
#define DTOEMPLOYEEGROUP_employeeGroupId @"employeeGroupId" //BIGINT
#define DTOEMPLOYEEGROUP_employeeId @"employeeId" //BIGINT
#define DTOEMPLOYEEGROUP_groupId @"groupId" //BIGINT
#define DTOEMPLOYEEGROUP_isOwner @"isOwner" //SMALLINT
#define DTOEMPLOYEEGROUP_id @"id" //INTEGER
///dtoaccount  Field
#define DTOACCOUNT_accountId @"accountId" //BIGINT
#define DTOACCOUNT_accountLevel @"accountLevel" //VARCHAR
#define DTOACCOUNT_accountType @"accountType" //VARCHAR
#define DTOACCOUNT_activityStatus @"activityStatus" //BIGINT
#define DTOACCOUNT_address @"address" //VARCHAR
#define DTOACCOUNT_areaId @"areaId" //BIGINT
#define DTOACCOUNT_assetTotal @"assetTotal" //VARCHAR
#define DTOACCOUNT_birthday @"birthday" //VARCHAR
#define DTOACCOUNT_branchCode @"branchCode" //VARCHAR
#define DTOACCOUNT_charter @"charter" //VARCHAR
#define DTOACCOUNT_clientAccountId @"clientAccountId" //BIGINT
#define DTOACCOUNT_clientId @"clientId" //BIGINT
#define DTOACCOUNT_code @"code" //VARCHAR
#define DTOACCOUNT_createdBy @"createdBy" //BIGINT
#define DTOACCOUNT_createdDate @"createdDate" //VARCHAR
#define DTOACCOUNT_disableEmail @"disableEmail" //SMALLINT
#define DTOACCOUNT_disableMeeting @"disableMeeting" //SMALLINT
#define DTOACCOUNT_disablePhone @"disablePhone" //SMALLINT
#define DTOACCOUNT_disableSms @"disableSms" //SMALLINT
#define DTOACCOUNT_email @"email" //VARCHAR
#define DTOACCOUNT_employeeCode @"employeeCode" //VARCHAR
#define DTOACCOUNT_employeeNumber @"employeeNumber" //VARCHAR
#define DTOACCOUNT_familyIncome @"familyIncome" //VARCHAR
#define DTOACCOUNT_fax @"fax" //VARCHAR
#define DTOACCOUNT_identifiedIssueArea @"identifiedIssueArea" //VARCHAR
#define DTOACCOUNT_identifiedIssueDate @"identifiedIssueDate" //VARCHAR
#define DTOACCOUNT_identifiedNumber @"identifiedNumber" //VARCHAR
#define DTOACCOUNT_industryBusiness @"industryBusiness" //VARCHAR
#define DTOACCOUNT_isActive @"isActive" //SMALLINT
#define DTOACCOUNT_languageId @"languageId" //BIGINT
#define DTOACCOUNT_lastTransaction @"lastTransaction" //VARCHAR
#define DTOACCOUNT_lat @"lat" //VARCHAR
#define DTOACCOUNT_lon @"lon" //VARCHAR
#define DTOACCOUNT_marialStatus @"marialStatus" //SMALLINT
#define DTOACCOUNT_mnemonic @"mnemonic" //VARCHAR
#define DTOACCOUNT_mobile @"mobile" //VARCHAR
#define DTOACCOUNT_name @"name" //VARCHAR
#define DTOACCOUNT_openCodeDate @"openCodeDate" //VARCHAR
#define DTOACCOUNT_orgType @"orgType" //BIGINT
#define DTOACCOUNT_ownerEmployeeId @"ownerEmployeeId" //BIGINT
#define DTOACCOUNT_personalIncome @"personalIncome" //VARCHAR
#define DTOACCOUNT_personalIndustry @"personalIndustry" //VARCHAR
#define DTOACCOUNT_phone @"phone" //VARCHAR
#define DTOACCOUNT_registrationAddress @"registrationAddress" //VARCHAR
#define DTOACCOUNT_registrationDate @"registrationDate" //VARCHAR
#define DTOACCOUNT_registrationNumber @"registrationNumber" //VARCHAR
#define DTOACCOUNT_revenue @"revenue" //VARCHAR
#define DTOACCOUNT_sector @"sector" //VARCHAR
#define DTOACCOUNT_setupDate @"setupDate" //VARCHAR
#define DTOACCOUNT_sex @"sex" //VARCHAR
#define DTOACCOUNT_shareholderNumber @"shareholderNumber" //BIGINT
#define DTOACCOUNT_status @"status" //INTEGER
#define DTOACCOUNT_swiftCode @"swiftCode" //VARCHAR
#define DTOACCOUNT_sysOrganizationId @"sysOrganizationId" //BIGINT
#define DTOACCOUNT_taxCode @"taxCode" //VARCHAR
#define DTOACCOUNT_taxIssuedDate @"taxIssuedDate" //VARCHAR
#define DTOACCOUNT_updatedBy @"updatedBy" //BIGINT
#define DTOACCOUNT_updatedDate @"updatedDate" //VARCHAR
#define DTOACCOUNT_website @"website" //VARCHAR
#define DTOACCOUNT_id @"id" //INTEGER
///dtoaccountcrosssell  Field
#define DTOACCOUNTCROSSSELL_accountCrossSellingId @"accountCrossSellingId" //BIGINT
#define DTOACCOUNTCROSSSELL_accountId @"accountId" //BIGINT
#define DTOACCOUNTCROSSSELL_confirmNote @"confirmNote" //VARCHAR
#define DTOACCOUNTCROSSSELL_createdBy @"createdBy" //BIGINT
#define DTOACCOUNTCROSSSELL_createdDate @"createdDate" //VARCHAR
#define DTOACCOUNTCROSSSELL_employeeId @"employeeId" //BIGINT
#define DTOACCOUNTCROSSSELL_endDate @"endDate" //VARCHAR
#define DTOACCOUNTCROSSSELL_note @"note" //VARCHAR
#define DTOACCOUNTCROSSSELL_organizationId @"organizationId" //BIGINT
#define DTOACCOUNTCROSSSELL_sellingEmployeeId @"sellingEmployeeId" //BIGINT
#define DTOACCOUNTCROSSSELL_status @"status" //INTEGER
#define DTOACCOUNTCROSSSELL_targetType @"targetType" //INTEGER
#define DTOACCOUNTCROSSSELL_type @"type" //INTEGER
#define DTOACCOUNTCROSSSELL_updatedBy @"updatedBy" //BIGINT
#define DTOACCOUNTCROSSSELL_updatedDate @"updatedDate" //VARCHAR
#define DTOACCOUNTCROSSSELL_id @"id" //INTEGER
///dtotask  Field
#define DTOTASK_accountId @"accountId" //BIGINT
#define DTOTASK_campaignId @"campaignId" //BIGINT
#define DTOTASK_clientId @"clientId" //BIGINT
#define DTOTASK_clientLeadId @"clientLeadId" //BIGINT
#define DTOTASK_clientTaskId @"clientTaskId" //BIGINT
#define DTOTASK_code @"code" //VARCHAR
#define DTOTASK_content @"content" //VARCHAR
#define DTOTASK_createdBy @"createdBy" //BIGINT
#define DTOTASK_createdDate @"createdDate" //VARCHAR
#define DTOTASK_dayIndex @"dayIndex" //INTEGER
#define DTOTASK_employeeCreated @"employeeCreated" //BIGINT
#define DTOTASK_employeeId @"employeeId" //BIGINT
#define DTOTASK_endDate @"endDate" //VARCHAR
#define DTOTASK_formal @"formal" //INTEGER
#define DTOTASK_groupId @"groupId" //BIGINT
#define DTOTASK_hourIndex @"hourIndex" //INTEGER
#define DTOTASK_isActive @"isActive" //SMALLINT
#define DTOTASK_isChance @"isChance" //SMALLINT
#define DTOTASK_isEmail @"isEmail" //SMALLINT
#define DTOTASK_isException @"isException" //SMALLINT
#define DTOTASK_isMarkSendmail @"isMarkSendmail" //SMALLINT
#define DTOTASK_isNotification @"isNotification" //SMALLINT
#define DTOTASK_isPublic @"isPublic" //SMALLINT
#define DTOTASK_isRecurrence @"isRecurrence" //SMALLINT
#define DTOTASK_isReminder @"isReminder" //SMALLINT
#define DTOTASK_isRepeat @"isRepeat" //SMALLINT
#define DTOTASK_isSms @"isSms" //SMALLINT
#define DTOTASK_leadId @"leadId" //BIGINT
#define DTOTASK_location @"location" //VARCHAR
#define DTOTASK_masterId @"masterId" //BIGINT
#define DTOTASK_minuteIndex @"minuteIndex" //INTEGER
#define DTOTASK_opportunityId @"opportunityId" //BIGINT
#define DTOTASK_percentComplete @"percentComplete" //INTEGER
#define DTOTASK_productsMasterId @"productsMasterId" //BIGINT
#define DTOTASK_relationObject @"relationObject" //INTEGER
#define DTOTASK_reminderEmail @"reminderEmail" //SMALLINT
#define DTOTASK_reminderNofify @"reminderNofify" //SMALLINT
#define DTOTASK_reminderSMS @"reminderSMS" //SMALLINT
#define DTOTASK_reminderTime @"reminderTime" //BIGINT
#define DTOTASK_reminderUnit @"reminderUnit" //INTEGER
#define DTOTASK_repeatDuration @"repeatDuration" //INTEGER
#define DTOTASK_repeatMode @"repeatMode" //INTEGER
#define DTOTASK_repeatUntil @"repeatUntil" //VARCHAR
#define DTOTASK_repeatWeekFri @"repeatWeekFri" //SMALLINT
#define DTOTASK_repeatWeekMon @"repeatWeekMon" //SMALLINT
#define DTOTASK_repeatWeekSat @"repeatWeekSat" //SMALLINT
#define DTOTASK_repeatWeekSun @"repeatWeekSun" //SMALLINT
#define DTOTASK_repeatWeekThu @"repeatWeekThu" //SMALLINT
#define DTOTASK_repeatWeekTue @"repeatWeekTue" //SMALLINT
#define DTOTASK_repeatWeekWed @"repeatWeekWed" //SMALLINT
#define DTOTASK_rpMonthDayOfWeek @"rpMonthDayOfWeek" //INTEGER
#define DTOTASK_rpMonthFirstDay @"rpMonthFirstDay" //INTEGER
#define DTOTASK_rpMonthIndexDay @"rpMonthIndexDay" //INTEGER
#define DTOTASK_rpMonthRdFirstDay @"rpMonthRdFirstDay" //SMALLINT
#define DTOTASK_rpMonthRdIndexDay @"rpMonthRdIndexDay" //SMALLINT
#define DTOTASK_startDate @"startDate" //VARCHAR
#define DTOTASK_taskId @"taskId" //BIGINT
#define DTOTASK_taskPriority @"taskPriority" //BIGINT
#define DTOTASK_taskStatus @"taskStatus" //INTEGER
#define DTOTASK_title @"title" //VARCHAR
#define DTOTASK_typeTask @"typeTask" //INTEGER
#define DTOTASK_updatedBy @"updatedBy" //BIGINT
#define DTOTASK_updatedDate @"updatedDate" //VARCHAR
#define DTOTASK_id @"id" //INTEGER
#define DTOTASK_clientOpportunityId @"clientOpportunityId" //BIGINT

///dtoDashboardConfiguration  Field
#define DTOWIDGET_confId @"confId" //BIGINT
#define DTOWIDGET_accountName @"accountName" //VARCHAR
#define DTOWIDGET_typeGraphically @"typeGraphically" //VARCHAR
#define DTOWIDGET_colorDisplay1 @"colorDisplay1" //VARCHAR
#define DTOWIDGET_createDate @"createDate" //DATE
#define DTOWIDGET_isShowData @"isShowData" //BIGINT
#define DTOWIDGET_colorDisplay2 @"colorDisplay2" //VARCHAR
#define DTOWIDGET_widgetId @"widgetId" //VARCHAR
#define DTOWIDGET_widgetName @"widgetName" //VARCHAR
#define DTOWIDGET_widgetType @"widgetType" //VARCHAR
#define DTOWIDGET_status @"status" //VARCHAR

//dtoWidgetType
#define DTOWIDGETTYPE_widgetId @"widgetId" //VARCHAR
#define DTOWIDGETTYPE_widgetName @"widgetName" //VARCHAR
#define DTOWIDGETTYPE_widgetType @"widgetType" //VARCHAR

///dtogroup  Field
#define DTOGROUP_code @"code" //VARCHAR
#define DTOGROUP_createdBy @"createdBy" //BIGINT
#define DTOGROUP_createdDate @"createdDate" //VARCHAR
#define DTOGROUP_groupId @"groupId" //BIGINT
#define DTOGROUP_name @"name" //VARCHAR
#define DTOGROUP_sysOrganizationId @"sysOrganizationId" //BIGINT
#define DTOGROUP_updatedBy @"updatedBy" //BIGINT
#define DTOGROUP_updatedDate @"updatedDate" //VARCHAR
#define DTOGROUP_id @"id" //INTEGER
///dtofollowup  Field
#define DTOFOLLOWUP_clientFollowUpId @"clientFollowUpId" //BIGINT
#define DTOFOLLOWUP_createdBy @"createdBy" //BIGINT
#define DTOFOLLOWUP_createdDate @"createdDate" //VARCHAR
#define DTOFOLLOWUP_employeeId @"employeeId" //BIGINT
#define DTOFOLLOWUP_endDate @"endDate" //VARCHAR
#define DTOFOLLOWUP_followUpId @"followUpId" //BIGINT
#define DTOFOLLOWUP_followUpState @"followUpState" //INTEGER
#define DTOFOLLOWUP_isEmail @"isEmail" //SMALLINT
#define DTOFOLLOWUP_isNotify @"isNotify" //SMALLINT
#define DTOFOLLOWUP_isReminder @"isReminder" //SMALLINT
#define DTOFOLLOWUP_isSms @"isSms" //SMALLINT
#define DTOFOLLOWUP_notifyDate @"notifyDate" //VARCHAR
#define DTOFOLLOWUP_objectId @"objectId" //BIGINT
#define DTOFOLLOWUP_objectName @"objectName" //VARCHAR
#define DTOFOLLOWUP_objectType @"objectType" //VARCHAR
#define DTOFOLLOWUP_startDate @"startDate" //VARCHAR
#define DTOFOLLOWUP_sysCatId @"sysCatId" //BIGINT
#define DTOFOLLOWUP_updatedBy @"updatedBy" //BIGINT
#define DTOFOLLOWUP_updatedDate @"updatedDate" //VARCHAR
#define DTOFOLLOWUP_id @"id" //INTEGER
///dtoopportunity  Field
#define DTOOPPORTUNITY_accountId @"accountId" //BIGINT
#define DTOOPPORTUNITY_campaignId @"campaignId" //BIGINT
#define DTOOPPORTUNITY_client @"client" //BIGINT
#define DTOOPPORTUNITY_clientOpportunityId @"clientOpportunityId" //BIGINT
#define DTOOPPORTUNITY_code @"code" //VARCHAR
#define DTOOPPORTUNITY_createdBy @"createdBy" //BIGINT
#define DTOOPPORTUNITY_createdDate @"createdDate" //VARCHAR
#define DTOOPPORTUNITY_description @"description" //VARCHAR
#define DTOOPPORTUNITY_employeeId @"employeeId" //BIGINT
#define DTOOPPORTUNITY_endDate @"endDate" //VARCHAR
#define DTOOPPORTUNITY_endDateReal @"endDateReal" //VARCHAR
#define DTOOPPORTUNITY_isActive @"isActive" //SMALLINT
#define DTOOPPORTUNITY_languageId @"languageId" //BIGINT
#define DTOOPPORTUNITY_leadId @"leadId" //BIGINT
#define DTOOPPORTUNITY_clientLeadId @"clientLeadId" //BIGINT
#define DTOOPPORTUNITY_name @"name" //VARCHAR
#define DTOOPPORTUNITY_needSupport @"needSupport" //SMALLINT
#define DTOOPPORTUNITY_nextTask @"nextTask" //BIGINT
#define DTOOPPORTUNITY_opportunityId @"opportunityId" //BIGINT
#define DTOOPPORTUNITY_opportunityLevelId @"opportunityLevelId" //BIGINT
#define DTOOPPORTUNITY_resultDescription @"resultDescription" //VARCHAR
#define DTOOPPORTUNITY_startDate @"startDate" //VARCHAR
#define DTOOPPORTUNITY_startDateReal @"startDateReal" //VARCHAR
#define DTOOPPORTUNITY_status @"status" //INTEGER
#define DTOOPPORTUNITY_successPercent @"successPercent" //INTEGER
#define DTOOPPORTUNITY_sysOrganizationId @"sysOrganizationId" //BIGINT
#define DTOOPPORTUNITY_type @"type" //BIGINT
#define DTOOPPORTUNITY_updatedBy @"updatedBy" //BIGINT
#define DTOOPPORTUNITY_updatedDate @"updatedDate" //VARCHAR
#define DTOOPPORTUNITY_id @"id" //INTEGER
///dtoindustry  Field
#define DTOINDUSTRY_createdBy @"createdBy" //BIGINT
#define DTOINDUSTRY_createdDate @"createdDate" //VARCHAR
#define DTOINDUSTRY_industryCode @"industryCode" //VARCHAR
#define DTOINDUSTRY_industryId @"industryId" //BIGINT
#define DTOINDUSTRY_industryName @"industryName" //VARCHAR
#define DTOINDUSTRY_industryParentId @"industryParentId" //BIGINT
#define DTOINDUSTRY_isActive @"isActive" //SMALLINT
#define DTOINDUSTRY_updatedBy @"updatedBy" //BIGINT
#define DTOINDUSTRY_updatedDate @"updatedDate" //VARCHAR
#define DTOINDUSTRY_id @"id" //INTEGER
///dtoindustryaccount  Field
#define DTOINDUSTRYACCOUNT_accountId @"accountId" //BIGINT
#define DTOINDUSTRYACCOUNT_clientIndustryAccountId @"clientIndustryAccountId" //BIGINT
#define DTOINDUSTRYACCOUNT_clientLeadId @"clientLeadId" //BIGINT
#define DTOINDUSTRYACCOUNT_createdBy @"createdBy" //BIGINT
#define DTOINDUSTRYACCOUNT_createdDate @"createdDate" //VARCHAR
#define DTOINDUSTRYACCOUNT_industryAccountId @"industryAccountId" //BIGINT
#define DTOINDUSTRYACCOUNT_industryId @"industryId" //BIGINT
#define DTOINDUSTRYACCOUNT_isActive @"isActive" //SMALLINT
#define DTOINDUSTRYACCOUNT_leadId @"leadId" //BIGINT
#define DTOINDUSTRYACCOUNT_updatedBy @"updatedBy" //BIGINT
#define DTOINDUSTRYACCOUNT_updatedDate @"updatedDate" //VARCHAR
#define DTOINDUSTRYACCOUNT_id @"id" //INTEGER
///dtoerrorlog  Field
#define DTOERRORLOG_employeeId @"employeeId" //BIGINT
#define DTOERRORLOG_errorDescription @"errorDescription" //VARCHAR
#define DTOERRORLOG_errorTime @"errorTime" //VARCHAR
#define DTOERRORLOG_errorType @"errorType" //VARCHAR
#define DTOERRORLOG_imei @"imei" //VARCHAR
#define DTOERRORLOG_ip @"ip" //VARCHAR
#define DTOERRORLOG_logErrorId @"logErrorId" //BIGINT
#define DTOERRORLOG_version @"version" //VARCHAR
#define DTOERRORLOG_id @"id" //INTEGER
///dtonote  Field
#define DTONOTE_accountId @"accountId" //BIGINT
#define DTONOTE_campaignId @"campaignId" //BIGINT
#define DTONOTE_clientNoteId @"clientNoteId" //BIGINT
#define DTONOTE_clientObjectId @"clientObjectId" //BIGINT
#define DTONOTE_objectType @"objectType" //BIGINT
#define DTONOTE_content @"content" //VARCHAR
#define DTONOTE_contentFormated @"contentFormated" //BLOB
#define DTONOTE_createdBy @"createdBy" //BIGINT
#define DTONOTE_createdDate @"createdDate" //VARCHAR
#define DTONOTE_employeeId @"employeeId" //BIGINT
#define DTONOTE_isActive @"isActive" //SMALLINT
#define DTONOTE_leadId @"leadId" //BIGINT
#define DTONOTE_noteId @"noteId" //BIGINT
#define DTONOTE_opportunityId @"opportunityId" //BIGINT
#define DTONOTE_title @"title" //VARCHAR
#define DTONOTE_updatedBy @"updatedBy" //BIGINT
#define DTONOTE_updatedDate @"updatedDate" //VARCHAR
#define DTONOTE_id @"id" //INTEGER
///dtoattachment  Field
#define DTOATTACHMENT_attachmentId @"attachmentId" //BIGINT
#define DTOATTACHMENT_checkSum @"checkSum" //SMALLINT
#define DTOATTACHMENT_clientAttachmentId @"clientAttachmentId" //BIGINT DTOATTACHMENT_clientObjectId
#define DTOATTACHMENT_clientObjectId @"clientObjectId"//DTOATTACHMENT_clientObjectId
#define DTOATTACHMENT_clientFilePath @"clientFilePath" //VARCHAR
#define DTOATTACHMENT_createdBy @"createdBy" //BIGINT
#define DTOATTACHMENT_createdDate @"createdDate" //VARCHAR
#define DTOATTACHMENT_fileName @"fileName" //VARCHAR
#define DTOATTACHMENT_isActive @"isActive" //SMALLINT
#define DTOATTACHMENT_note @"note" //VARCHAR
#define DTOATTACHMENT_objectId @"objectId" //BIGINT
#define DTOATTACHMENT_objectType @"objectType" //VARCHAR
#define DTOATTACHMENT_serverFilePath @"serverFilePath" //VARCHAR
#define DTOATTACHMENT_updatedBy @"updatedBy" //BIGINT
#define DTOATTACHMENT_updatedDate @"updatedDate" //VARCHAR
#define DTOATTACHMENT_verifyLat @"verifyLat" //VARCHAR
#define DTOATTACHMENT_verifyLon @"verifyLon" //VARCHAR
#define DTOATTACHMENT_id @"id" //INTEGER
///dtoopportunityproduct  Field
#define DTOOPPORTUNITYPRODUCT_clientOpportunityProductId @"clientOpportunityProductId" //BIGINT
#define DTOOPPORTUNITYPRODUCT_createdBy @"createdBy" //BIGINT
#define DTOOPPORTUNITYPRODUCT_createdDate @"createdDate" //VARCHAR
#define DTOOPPORTUNITYPRODUCT_currencyId @"currencyId" //BIGINT
#define DTOOPPORTUNITYPRODUCT_isActive @"isActive" //SMALLINT
#define DTOOPPORTUNITYPRODUCT_opportunityId @"opportunityId" //BIGINT
#define DTOOPPORTUNITYPRODUCT_opportunityProductId @"opportunityProductId" //BIGINT
#define DTOOPPORTUNITYPRODUCT_productMasterId @"productMasterId" //BIGINT
#define DTOOPPORTUNITYPRODUCT_quantity @"quantity" //VARCHAR
#define DTOOPPORTUNITYPRODUCT_revenue @"revenue" //VARCHAR
#define DTOOPPORTUNITYPRODUCT_updatedBy @"updatedBy" //BIGINT
#define DTOOPPORTUNITYPRODUCT_updatedDate @"updatedDate" //VARCHAR
#define DTOOPPORTUNITYPRODUCT_id @"id" //INTEGER
///dtoproductmaster  Field
#define DTOPRODUCTMASTER_accountType @"accountType" //VARCHAR
#define DTOPRODUCTMASTER_code @"code" //VARCHAR
#define DTOPRODUCTMASTER_createdBy @"createdBy" //BIGINT
#define DTOPRODUCTMASTER_createdDate @"createdDate" //VARCHAR
#define DTOPRODUCTMASTER_updatedDate @"updatedDate" //VARCHAR
#define DTOPRODUCTMASTER_description @"description" //VARCHAR
#define DTOPRODUCTMASTER_effectiveEndDate @"effectiveEndDate" //VARCHAR
#define DTOPRODUCTMASTER_effectiveStartDate @"effectiveStartDate" //VARCHAR
#define DTOPRODUCTMASTER_images @"images" //BLOB
#define DTOPRODUCTMASTER_isActive @"isActive" //SMALLINT
#define DTOPRODUCTMASTER_isLeaf @"isLeaf" //SMALLINT
#define DTOPRODUCTMASTER_name @"name" //VARCHAR
#define DTOPRODUCTMASTER_parentId @"parentId" //BIGINT
#define DTOPRODUCTMASTER_path @"path" //VARCHAR
#define DTOPRODUCTMASTER_productMasterId @"productMasterId" //BIGINT
#define DTOPRODUCTMASTER_productTypeId @"productTypeId" //BIGINT
#define DTOPRODUCTMASTER_updatedBy @"updatedBy" //BIGINT
#define DTOPRODUCTMASTER_crossPercent @"crossPercent" //INTEGER
#define DTOPRODUCTMASTER_id @"id" //INTEGER

///dtocompalin Field
#define DTOCOMPLAIN_casesId @"casesId" //VARCHAR
#define DTOCOMPLAIN_code @"code" //VARCHAR
#define DTOCOMPLAIN_content @"content" //VARCHAR
#define DTOCOMPLAIN_reason @"reason" //VARCHAR
#define DTOCOMPLAIN_result @"result" //VARCHAR
#define DTOCOMPLAIN_status @"status" //VARCHAR
#define DTOCOMPLAIN_fromReceived @"fromReceived" //VARCHAR
#define DTOCOMPLAIN_type @"type" //VARCHAR
#define DTOCOMPLAIN_priority @"priority" //VARCHAR
#define DTOCOMPLAIN_receiverId @"receiverId" //VARCHAR
#define DTOCOMPLAIN_receivedDate @"receivedDate" //VARCHAR
#define DTOCOMPLAIN_processerId @"processerId" //VARCHAR
#define DTOCOMPLAIN_processedDate @"processedDate" //VARCHAR
#define DTOCOMPLAIN_closedId @"closedId" //VARCHAR
#define DTOCOMPLAIN_closedDate @"closedDate" //VARCHAR
#define DTOCOMPLAIN_accountId @"accountId" //VARCHAR
#define DTOCOMPLAIN_productMasterId @"productMasterId" //VARCHAR
#define DTOCOMPLAIN_acceptTypeId @"acceptTypeId" //VARCHAR
#define DTOCOMPLAIN_agentText @"agentText" //VARCHAR
#define DTOCOMPLAIN_assignBy @"assignBy" //VARCHAR
#define DTOCOMPLAIN_blackList @"blackList" //VARCHAR
#define DTOCOMPLAIN_callLenght @"callLenght" //VARCHAR

///dtoproducttype  Field
#define DTOPRODUCTTYPE_code @"code" //VARCHAR
#define DTOPRODUCTTYPE_isActive @"isActive" //SMALLINT
#define DTOPRODUCTTYPE_name @"name" //VARCHAR
#define DTOPRODUCTTYPE_productTypeId @"productTypeId" //BIGINT
#define DTOPRODUCTTYPE_id @"id" //INTEGER

///dtoproductdetail  Field
#define DTOPRODUCTDETAIL_productDetailId @"productDetailId" //VARCHAR
#define DTOPRODUCTDETAIL_contractNumber @"contractNumber" //VARCHAR
#define DTOPRODUCTDETAIL_balance @"balance" //VARCHAR
#define DTOPRODUCTDETAIL_openDate @"openDate" //VARCHAR
#define DTOPRODUCTDETAIL_expiredDate @"expiredDate" //VARCHAR
#define DTOPRODUCTDETAIL_status @"status" //VARCHAR
#define DTOPRODUCTDETAIL_type @"type" //VARCHAR
#define DTOPRODUCTDETAIL_branchCode @"branchCode" //VARCHAR
#define DTOPRODUCTDETAIL_currency @"currency" //VARCHAR
#define DTOPRODUCTDETAIL_productCode @"productCode" //VARCHAR
#define DTOPRODUCTDETAIL_clientId @"clientId" //VARCHAR
#define DTOPRODUCTDETAIL_bussinessDate @"bussinessDate" //VARCHAR
#define DTOPRODUCTDETAIL_createdDate @"createdDate" //VARCHAR
#define DTOPRODUCTDETAIL_updatedDate @"updatedDate" //VARCHAR
#define DTOPRODUCTDETAIL_rmCode @"rmCode" //VARCHAR
#define DTOPRODUCTDETAIL_balanceQD @"balanceQD" //VARCHAR
#define DTOPRODUCTDETAIL_Khoi @"Khoi" //VARCHAR
#define DTOPRODUCTDETAIL_rmBancheo @"rmBancheo" //VARCHAR
#define DTOPRODUCTDETAIL_BalanceSum @"balanceSum" //VARCHAR

//dtoProTindungDetail Field
#define DTOProTinDungDetail_BRANCH_CODE                 @"BRANCH_CODE",
#define DTOProTinDungDetail_CONTRACT_NUMBER             @"CONTRACT_NUMBER",
#define DTOProTinDungDetail_OPEN_DATE                   @"OPEN_DATE",
#define DTOProTinDungDetail_EXPIRE_DATE                 @"EXPIRE_DATE",
#define DTOProTinDungDetail_EXTENSION_DATE              @"EXTENSION_DATE",
#define DTOProTinDungDetail_BALANCE                     @"BALANCE",
#define DTOProTinDungDetail_BALANCE_QD                  @"BALANCE_QD",
#define DTOProTinDungDetail_SOD_BALANCE                 @"SOD_BALANCE",
#define DTOProTinDungDetail_SOD_BALANCE_QD              @"SOD_BALANCE_QD",
#define DTOProTinDungDetail_CURRENCY                    @"CURRENCY",
#define DTOProTinDungDetail_CLIENT_ID                   @"CLIENT_ID",
#define DTOProTinDungDetail_TERM                        @"TERM",
#define DTOProTinDungDetail_TERM_TYPE                   @"TERM_TYPE",
#define DTOProTinDungDetail_DEPT_GROUP                  @"DEPT_GROUP",
#define DTOProTinDungDetail_DEPT_GROUP2                 @"DEPT_GROUP2",
#define DTOProTinDungDetail_FIXED_INTEREST              @"FIXED_INTEREST",
#define DTOProTinDungDetail_INTEREST_MARGIN             @"INTEREST_MARGIN",
#define DTOProTinDungDetail_INTEREST                    @"INTEREST",
#define DTOProTinDungDetail_RECEIVEABLE_AMOUNT          @"RECEIVEABLE_AMOUNT",
#define DTOProTinDungDetail_STATUS                      @"STATUS",
#define DTOProTinDungDetail_BUSSINESS_DATE              @"BUSSINESS_DATE",
#define DTOProTinDungDetail_INITIAL_BALANCE             @"INITIAL_BALANCE",
#define DTOProTinDungDetail_PREPAID_INTEREST            @"PREPAID_INTEREST",
#define DTOProTinDungDetail_OVERDUE_INTEREST            @"OVERDUE_INTEREST",
#define DTOProTinDungDetail_SECTOR                      @"SECTOR",
#define DTOProTinDungDetail_SOURCE_OF_FUND              @"SOURCE_OF_FUND",
#define DTOProTinDungDetail_SECURE                      @"SECURE",
#define DTOProTinDungDetail_GL                          @"GL",
#define DTOProTinDungDetail_INDUSTRY_CODE               @"INDUSTRY_CODE",
#define DTOProTinDungDetail_INTEREST_TYPE               @"INTEREST_TYPE",
#define DTOProTinDungDetail_INTEREST_KEY                @"INTEREST_KEY",
#define DTOProTinDungDetail_INPUTTER                    @"INPUTTER",
#define DTOProTinDungDetail_PRODUCT_CODE                @"PRODUCT_CODE",
#define DTOProTinDungDetail_RM_CODE                     @"RM_CODE",
#define DTOProTinDungDetail_KHOI                        @"KHOI",
#define DTOProTinDungDetail_ RM_BANCHEO                 @"RM_BANCHEO",
#define DTOProTinDungDetail_PURPOSE                     @"PURPOSE",

// dtoProThanhtoanDetail Field

#define DTOProThanhToanDetail_ID                @"ID",
#define DTOProThanhToanDetail_BRANCH_CODE       @"BRANCH_CODE",
#define DTOProThanhToanDetail_CONTRACT_NUMBER   @"CONTRACT_NUMBER",
#define DTOProThanhToanDetail_OPEN_DATE         @"OPEN_DATE",
#define DTOProThanhToanDetail_EXPIRED_DATE      @"EXPIRED_DATE",
#define DTOProThanhToanDetail_TRANSACTION_DATE  @"TRANSACTION_DATE",
#define DTOProThanhToanDetail_BALANCE           @"BALANCE",
#define DTOProThanhToanDetail_BALANCE_QD        @"BALANCE_QD",
#define DTOProThanhToanDetail_CARD_FLAG         @"CARD_FLAG",
#define DTOProThanhToanDetail_ACC_STATUS        @"ACC_STATUS",
#define DTOProThanhToanDetail_SOD_BALANCE       @"SOD_BALANCE",
#define DTOProThanhToanDetail_SOD_BALANCE_QD    @"SOD_BALANCE_QD",
#define DTOProThanhToanDetail_CURRENCY          @"CURRENCY",
#define DTOProThanhToanDetail_FOREX_RATE        @"FOREX_RATE",
#define DTOProThanhToanDetail_CLIENT_ID         @"CLIENT_ID",
#define DTOProThanhToanDetail_TERM_DAY          @"TERM_DAY",
#define DTOProThanhToanDetail_TERM_WEEK         @"TERM_WEEK",
#define DTOProThanhToanDetail_TERM_TXT          @"TERM_TXT",
#define DTOProThanhToanDetail_SUSPEND_INTEREST  @"SUSPEND_INTEREST",
#define DTOProThanhToanDetail_INTEREST          @"INTEREST",
#define DTOProThanhToanDetail_LINE_T24          @"LINE_T24",
#define DTOProThanhToanDetail_INDUSTRY_CODE     @"INDUSTRY_CODE",
#define DTOProThanhToanDetail_SECTOR            @"SECTOR",
#define DTOProThanhToanDetail_GL                @"GL",
#define DTOProThanhToanDetail_PRODUCT_CODE      @"PRODUCT_CODE",
#define DTOProThanhToanDetail_RM_CODE           @"RM_CODE",
#define DTOProThanhToanDetail_BUSSINESS_DATE    @"BUSSINESS_DATE",
#define DTOProThanhToanDetail_KHOI              @"KHOI",


// dtoProTietkiemDetail Field

#define DTOProTietkiemDetail_ID                                            @"ID",
#define DTOProTietkiemDetail_BRANCH_CODE                                   @"BRANCH_CODE",
#define DTOProTietkiemDetail_CONTRACT_NUMBER                               @"CONTRACT_NUMBER",
#define DTOProTietkiemDetail_OPEN_DATE                                     @"OPEN_DATE",
#define DTOProTietkiemDetail_EXPIRED_DATE                                  @"EXPIRED_DATE",
#define DTOProTietkiemDetail_TRANSACTION_DATE                              @"TRANSACTION_DATE",
#define DTOProTietkiemDetail_BALANCE                                       @"BALANCE",
#define DTOProTietkiemDetail_BALANCE_QD                                    @"BALANCE_QD",
#define DTOProTietkiemDetail_CARD_FLAG                                     @"CARD_FLAG",
#define DTOProTietkiemDetail_ACC_STATUS                                    @"ACC_STATUS",
#define DTOProTietkiemDetail_SOD_BALANCE                                   @"SOD_BALANCE",
#define DTOProTietkiemDetail_SOD_BALANCE_QD                                @"SOD_BALANCE_QD",
#define DTOProTietkiemDetail_CURRENCY                                      @"CURRENCY",
#define DTOProTietkiemDetail_CLIENT_ID                                     @"CLIENT_ID",
#define DTOProTietkiemDetail_TERM_DAY                                      @"TERM_DAY",
#define DTOProTietkiemDetail_TERM_WEEK                                     @"TERM_WEEK",
#define DTOProTietkiemDetail_TERM_TXT                                      @"TERM_TXT",
#define DTOProTietkiemDetail_SUSPEND_INTEREST                              @"SUSPEND_INTEREST",
#define DTOProTietkiemDetail_INTEREST                                      @"INTEREST",
#define DTOProTietkiemDetail_EXPENSE_INTEREST                              @"EXPENSE_INTEREST",
#define DTOProTietkiemDetail_LINE_T24                                      @"LINE_T24",
#define DTOProTietkiemDetail_INDUSTRY_CODE                                 @"INDUSTRY_CODE",
#define DTOProTietkiemDetail_SECTOR                                        @"SECTOR",
#define DTOProTietkiemDetail_GL                                            @"GL",
#define DTOProTietkiemDetail_PRODUCT_CODE                                  @"PRODUCT_CODE",
#define DTOProTietkiemDetail_RM_CODE                                       @"RM_CODE",
#define DTOProTietkiemDetail_BUSSINESS_DATE                                @"BUSSINESS_DATE",
#define DTOProTietkiemDetail_KHOI                                          @"KHOI",


///dtocontact  Field
#define DTOCONTACT_accountId @"accountId" //BIGINT
#define DTOCONTACT_address @"address" //VARCHAR
#define DTOCONTACT_birthday @"birthday" //VARCHAR
#define DTOCONTACT_clientContactId @"clientContactId" //BIGINT
#define DTOCONTACT_clientId @"clientId" //BIGINT
#define DTOCONTACT_contactId @"contactId" //BIGINT
#define DTOCONTACT_email @"email" //VARCHAR
#define DTOCONTACT_employeeId @"employeeId" //BIGINT
#define DTOCONTACT_favoriteLevel @"favoriteLevel" //INTEGER
#define DTOCONTACT_fullName @"fullName" //VARCHAR
#define DTOCONTACT_identifiedIssueArea @"identifiedIssueArea" //VARCHAR
#define DTOCONTACT_identifiedIssueDate @"identifiedIssueDate" //VARCHAR
#define DTOCONTACT_identifiedNumber @"identifiedNumber" //VARCHAR
#define DTOCONTACT_isActive @"isActive" //INTEGER
#define DTOCONTACT_avartar @"avartar" //varchar
#define DTOCONTACT_leadId @"leadId" //BIGINT
#define DTOCONTACT_mobile @"mobile" //VARCHAR
#define DTOCONTACT_organizationId @"organizationId" //BIGINT
#define DTOCONTACT_passport @"passport" //VARCHAR
#define DTOCONTACT_phone @"phone" //VARCHAR
#define DTOCONTACT_position @"position" //VARCHAR
#define DTOCONTACT_roleDescription @"roleDescription" //VARCHAR
#define DTOCONTACT_sex @"sex" //VARCHAR
#define DTOCONTACT_updatedDate @"updatedDate" //VARCHAR
#define DTOCONTACT_id @"id" //INTEGER
///dtoaccountcontact  Field
#define DTOACCOUNTCONTACT_accountContactId @"accountContactId" //BIGINT
#define DTOACCOUNTCONTACT_accountId @"accountId" //BIGINT
#define DTOACCOUNTCONTACT_clientAccountContactId @"clientAccountContactId" //BIGINT
#define DTOACCOUNTCONTACT_clientAccountId @"clientAccountId" //BIGINT
#define DTOACCOUNTCONTACT_clientLeadId @"clientLeadId" //BIGINT
#define DTOACCOUNTCONTACT_contactId @"contactId" //BIGINT
#define DTOACCOUNTCONTACT_isActive @"isActive" //SMALLINT
#define DTOACCOUNTCONTACT_leadId @"leadId" //BIGINT
#define DTOACCOUNTCONTACT_updatedDate @"updatedDate" //VARCHAR
#define DTOACCOUNTCONTACT_id @"id" //INTEGER
///dtoopportunitycontact  Field
#define DTOOPPORTUNITYCONTACT_clientOpportunityContactId @"clientOpportunityContactId" //BIGINT
#define DTOOPPORTUNITYCONTACT_contactId @"contactId" //BIGINT
#define DTOOPPORTUNITYCONTACT_clientContactId @"clientContactId" //BIGINT
#define DTOOPPORTUNITYCONTACT_createdBy @"createdBy" //BIGINT
#define DTOOPPORTUNITYCONTACT_createdDate @"createdDate" //VARCHAR
#define DTOOPPORTUNITYCONTACT_isActive @"isActive" //SMALLINT
#define DTOOPPORTUNITYCONTACT_opportunityContactId @"opportunityContactId" //BIGINT
#define DTOOPPORTUNITYCONTACT_opportunityId @"opportunityId" //BIGINT
#define DTOOPPORTUNITYCONTACT_clientOpportunityId @"clientOpportunityId" //BIGINT

#define DTOOPPORTUNITYCONTACT_updatedBy @"updatedBy" //BIGINT
#define DTOOPPORTUNITYCONTACT_updatedDate @"updatedDate" //VARCHAR
#define DTOOPPORTUNITYCONTACT_id @"id" //INTEGER
///dtocompetitor  Field
#define DTOCOMPETITOR_accountId @"accountId" //BIGINT
#define DTOCOMPETITOR_address @"address" //VARCHAR
#define DTOCOMPETITOR_birthday @"birthday" //VARCHAR
#define DTOCOMPETITOR_code @"code" //VARCHAR
#define DTOCOMPETITOR_competitorId @"competitorId" //BIGINT
#define DTOCOMPETITOR_email @"email" //VARCHAR
#define DTOCOMPETITOR_fax @"fax" //VARCHAR
#define DTOCOMPETITOR_fullName @"fullName" //VARCHAR
#define DTOCOMPETITOR_isActive @"isActive" //SMALLINT
#define DTOCOMPETITOR_leadId @"leadId" //BIGINT
#define DTOCOMPETITOR_mobile @"mobile" //VARCHAR
#define DTOCOMPETITOR_note @"note" //VARCHAR
#define DTOCOMPETITOR_phone @"phone" //VARCHAR
#define DTOCOMPETITOR_updatedDate @"updatedDate" //VARCHAR
#define DTOCOMPETITOR_website @"website" //VARCHAR
#define DTOCOMPETITOR_id @"id" //INTEGER
///dtoopportunitycompetitor  Field
#define DTOOPPORTUNITYCOMPETITOR_advantage @"advantage" //VARCHAR
#define DTOOPPORTUNITYCOMPETITOR_clientOpportunityCompetitorId @"clientOpportunityCompetitorId" //BIGINT
#define DTOOPPORTUNITYCOMPETITOR_competitorId @"competitorId" //BIGINT
#define DTOOPPORTUNITYCOMPETITOR_createdBy @"createdBy" //BIGINT
#define DTOOPPORTUNITYCOMPETITOR_createdDate @"createdDate" //VARCHAR
#define DTOOPPORTUNITYCOMPETITOR_description @"description" //VARCHAR
#define DTOOPPORTUNITYCOMPETITOR_disadvantage @"disadvantage" //VARCHAR
#define DTOOPPORTUNITYCOMPETITOR_isActive @"isActive" //SMALLINT
#define DTOOPPORTUNITYCOMPETITOR_opportunityCompetitorId @"opportunityCompetitorId" //BIGINT
#define DTOOPPORTUNITYCOMPETITOR_opportunityId @"opportunityId" //BIGINT
#define DTOOPPORTUNITYCOMPETITOR_updatedBy @"updatedBy" //BIGINT
#define DTOOPPORTUNITYCOMPETITOR_updatedDate @"updatedDate" //VARCHAR
#define DTOOPPORTUNITYCOMPETITOR_id @"id" //INTEGER
///dtoemployeeaccount  Field
#define DTOEMPLOYEEACCOUNT_accountId @"accountId" //BIGINT
#define DTOEMPLOYEEACCOUNT_assignedBy @"assignedBy" //BIGINT
#define DTOEMPLOYEEACCOUNT_assignedDate @"assignedDate" //VARCHAR
#define DTOEMPLOYEEACCOUNT_clientEmployeeAccountId @"clientEmployeeAccountId" //BIGINT
#define DTOEMPLOYEEACCOUNT_createdBy @"createdBy" //BIGINT
#define DTOEMPLOYEEACCOUNT_createdDate @"createdDate" //VARCHAR
#define DTOEMPLOYEEACCOUNT_employeeAccountId @"employeeAccountId" //BIGINT
#define DTOEMPLOYEEACCOUNT_employeeId @"employeeId" //BIGINT
#define DTOEMPLOYEEACCOUNT_endDate @"endDate" //VARCHAR
#define DTOEMPLOYEEACCOUNT_isOwner @"isOwner" //SMALLINT
#define DTOEMPLOYEEACCOUNT_isShared @"isShared" //SMALLINT
#define DTOEMPLOYEEACCOUNT_leadId @"leadId" //BIGINT
#define DTOEMPLOYEEACCOUNT_note @"note" //VARCHAR
#define DTOEMPLOYEEACCOUNT_updatedBy @"updatedBy" //BIGINT
#define DTOEMPLOYEEACCOUNT_updatedDate @"updatedDate" //VARCHAR
#define DTOEMPLOYEEACCOUNT_id @"id" //INTEGER
///dtorelationship  Field
#define DTORELATIONSHIP_address @"address" //VARCHAR
#define DTORELATIONSHIP_birthday @"birthday" //VARCHAR
#define DTORELATIONSHIP_clientId @"clientId" //BIGINT
#define DTORELATIONSHIP_clientRelationshipId @"clientRelationshipId" //BIGINT
#define DTORELATIONSHIP_code @"code" //VARCHAR
#define DTORELATIONSHIP_createdBy @"createdBy" //BIGINT
#define DTORELATIONSHIP_createdDate @"createdDate" //VARCHAR
#define DTORELATIONSHIP_email @"email" //VARCHAR
#define DTORELATIONSHIP_fax @"fax" //VARCHAR
#define DTORELATIONSHIP_fullName @"fullName" //VARCHAR
#define DTORELATIONSHIP_isActive @"isActive" //SMALLINT
#define DTORELATIONSHIP_mobile @"mobile" //VARCHAR
#define DTORELATIONSHIP_note @"note" //VARCHAR
#define DTORELATIONSHIP_phone @"phone" //VARCHAR
#define DTORELATIONSHIP_relationshipId @"relationshipId" //BIGINT
#define DTORELATIONSHIP_updatedBy @"updatedBy" //BIGINT
#define DTORELATIONSHIP_updatedDate @"updatedDate" //VARCHAR
#define DTORELATIONSHIP_website @"website" //VARCHAR
#define DTORELATIONSHIP_id @"id" //INTEGER
///dtoaccountrelationship  Field
#define DTOACCOUNTRELATIONSHIP_accountId @"accountId" //BIGINT
#define DTOACCOUNTRELATIONSHIP_accountRelationshipId @"accountRelationshipId" //BIGINT
#define DTOACCOUNTRELATIONSHIP_clientAccountId @"clientAccountId" //BIGINT
#define DTOACCOUNTRELATIONSHIP_clientAccountRelationshipId @"clientAccountRelationshipId" //BIGINT
#define DTOACCOUNTRELATIONSHIP_clientLeadId @"clientLeadId" //BIGINT
#define DTOACCOUNTRELATIONSHIP_createdBy @"createdBy" //BIGINT
#define DTOACCOUNTRELATIONSHIP_createdDate @"createdDate" //VARCHAR
#define DTOACCOUNTRELATIONSHIP_isActive @"isActive" //SMALLINT
#define DTOACCOUNTRELATIONSHIP_leadId @"leadId" //BIGINT
#define DTOACCOUNTRELATIONSHIP_relationshipId @"relationshipId" //BIGINT
#define DTOACCOUNTRELATIONSHIP_relationshipType @"relationshipType" //BIGINT
#define DTOACCOUNTRELATIONSHIP_updatedBy @"updatedBy" //BIGINT
#define DTOACCOUNTRELATIONSHIP_updatedDate @"updatedDate" //VARCHAR
#define DTOACCOUNTRELATIONSHIP_id @"id" //INTEGER
///dtocoi  Field
#define DTOCOI_clientCoiId @"clientCoiId" //BIGINT
#define DTOCOI_code @"code" //VARCHAR
#define DTOCOI_coiId @"coiId" //BIGINT
#define DTOCOI_collectionNo @"collectionNo" //VARCHAR
#define DTOCOI_createdBy @"createdBy" //BIGINT
#define DTOCOI_createdDate @"createdDate" //VARCHAR
#define DTOCOI_expiredDate @"expiredDate" //VARCHAR
#define DTOCOI_fromDateTime @"fromDateTime" //VARCHAR
#define DTOCOI_inventoryId @"inventoryId" //BIGINT
#define DTOCOI_productMasterId @"productMasterId" //BIGINT
#define DTOCOI_seriNo @"seriNo" //BIGINT
#define DTOCOI_status @"status" //INTEGER
#define DTOCOI_updatedBy @"updatedBy" //BIGINT
#define DTOCOI_updatedDate @"updatedDate" //VARCHAR
#define DTOCOI_id @"id" //INTEGER
///dtoimportexportcoi  Field
#define DTOIMPORTEXPORTCOI_clientImportExportCoiId @"clientImportExportCoiId" //BIGINT
#define DTOIMPORTEXPORTCOI_coiCount @"coiCount" //BIGINT
#define DTOIMPORTEXPORTCOI_collectionNo @"collectionNo" //VARCHAR
#define DTOIMPORTEXPORTCOI_createdBy @"createdBy" //BIGINT
#define DTOIMPORTEXPORTCOI_createdDate @"createdDate" //VARCHAR
#define DTOIMPORTEXPORTCOI_destinationInventory @"destinationInventory" //BIGINT
#define DTOIMPORTEXPORTCOI_importExportCoiId @"importExportCoiId" //BIGINT
#define DTOIMPORTEXPORTCOI_lat @"lat" //VARCHAR
#define DTOIMPORTEXPORTCOI_lon @"lon" //VARCHAR
#define DTOIMPORTEXPORTCOI_notes @"notes" //VARCHAR
#define DTOIMPORTEXPORTCOI_productMasterId @"productMasterId" //BIGINT
#define DTOIMPORTEXPORTCOI_requestCoiId @"requestCoiId" //BIGINT
#define DTOIMPORTEXPORTCOI_seriForm @"seriForm" //BIGINT
#define DTOIMPORTEXPORTCOI_seriTo @"seriTo" //BIGINT
#define DTOIMPORTEXPORTCOI_sourceInventory @"sourceInventory" //BIGINT
#define DTOIMPORTEXPORTCOI_status @"status" //INTEGER
#define DTOIMPORTEXPORTCOI_transactionDate @"transactionDate" //VARCHAR
#define DTOIMPORTEXPORTCOI_transactionType @"transactionType" //BIGINT
#define DTOIMPORTEXPORTCOI_transactionUser @"transactionUser" //BIGINT
#define DTOIMPORTEXPORTCOI_updatedBy @"updatedBy" //BIGINT
#define DTOIMPORTEXPORTCOI_updatedDate @"updatedDate" //VARCHAR
#define DTOIMPORTEXPORTCOI_id @"id" //INTEGER
///dtoinventory  Field
#define DTOINVENTORY_address @"address" //VARCHAR
#define DTOINVENTORY_branchId @"branchId" //BIGINT
#define DTOINVENTORY_clientInventoryId @"clientInventoryId" //BIGINT
#define DTOINVENTORY_createdBy @"createdBy" //BIGINT
#define DTOINVENTORY_createdDate @"createdDate" //VARCHAR
#define DTOINVENTORY_inventoryId @"inventoryId" //BIGINT
#define DTOINVENTORY_inventoryName @"inventoryName" //VARCHAR
#define DTOINVENTORY_lat @"lat" //BIGINT
#define DTOINVENTORY_lon @"lon" //BIGINT
#define DTOINVENTORY_ownId @"ownId" //BIGINT
#define DTOINVENTORY_ownType @"ownType" //VARCHAR
#define DTOINVENTORY_phone @"phone" //VARCHAR
#define DTOINVENTORY_status @"status" //INTEGER
#define DTOINVENTORY_updatedBy @"updatedBy" //BIGINT
#define DTOINVENTORY_updatedDate @"updatedDate" //VARCHAR
#define DTOINVENTORY_id @"id" //INTEGER
///dtoinventorycoi  Field
#define DTOINVENTORYCOI_clientInventoryCoiId @"clientInventoryCoiId" //BIGINT
#define DTOINVENTORYCOI_collectionNo @"collectionNo" //VARCHAR
#define DTOINVENTORYCOI_createdBy @"createdBy" //BIGINT
#define DTOINVENTORYCOI_createdDate @"createdDate" //VARCHAR
#define DTOINVENTORYCOI_inventoryCoiId @"inventoryCoiId" //BIGINT
#define DTOINVENTORYCOI_inventoryId @"inventoryId" //BIGINT
#define DTOINVENTORYCOI_notes @"notes" //VARCHAR
#define DTOINVENTORYCOI_productCount @"productCount" //BIGINT
#define DTOINVENTORYCOI_productMasterId @"productMasterId" //BIGINT
#define DTOINVENTORYCOI_seriForm @"seriForm" //BIGINT
#define DTOINVENTORYCOI_seriTo @"seriTo" //BIGINT
#define DTOINVENTORYCOI_status @"status" //INTEGER
#define DTOINVENTORYCOI_updatedBy @"updatedBy" //BIGINT
#define DTOINVENTORYCOI_updatedDate @"updatedDate" //VARCHAR
#define DTOINVENTORYCOI_id @"id" //INTEGER
///dtorequestcoi  Field
#define DTOREQUESTCOI_clientRequestCoiId @"clientRequestCoiId" //BIGINT
#define DTOREQUESTCOI_createdBy @"createdBy" //BIGINT
#define DTOREQUESTCOI_createdDate @"createdDate" //VARCHAR
#define DTOREQUESTCOI_inventoryId @"inventoryId" //BIGINT
#define DTOREQUESTCOI_productMasterId @"productMasterId" //BIGINT
#define DTOREQUESTCOI_requestCoiId @"requestCoiId" //BIGINT
#define DTOREQUESTCOI_requestContent @"requestContent" //VARCHAR
#define DTOREQUESTCOI_requestDate @"requestDate" //VARCHAR
#define DTOREQUESTCOI_requestNote @"requestNote" //VARCHAR
#define DTOREQUESTCOI_requestNum @"requestNum" //BIGINT
#define DTOREQUESTCOI_status @"status" //INTEGER
#define DTOREQUESTCOI_updatedBy @"updatedBy" //BIGINT
#define DTOREQUESTCOI_updatedDate @"updatedDate" //VARCHAR
#define DTOREQUESTCOI_id @"id" //INTEGER
///dtoreqclaims  Field
#define DTOREQCLAIMS_accidentAddress @"accidentAddress" //VARCHAR
#define DTOREQCLAIMS_accidentDate @"accidentDate" //VARCHAR
#define DTOREQCLAIMS_accidentLat @"accidentLat" //VARCHAR
#define DTOREQCLAIMS_accidentLon @"accidentLon" //VARCHAR
#define DTOREQCLAIMS_causeId @"causeId" //BIGINT
#define DTOREQCLAIMS_certificateNo @"certificateNo" //VARCHAR
#define DTOREQCLAIMS_clientReqClaimsId @"clientReqClaimsId" //BIGINT
#define DTOREQCLAIMS_coiId @"coiId" //BIGINT
#define DTOREQCLAIMS_contentApproved @"contentApproved" //VARCHAR
#define DTOREQCLAIMS_contentReqProcess @"contentReqProcess" //VARCHAR
#define DTOREQCLAIMS_createdBy @"createdBy" //BIGINT
#define DTOREQCLAIMS_createdDate @"createdDate" //VARCHAR
#define DTOREQCLAIMS_cusReqId @"cusReqId" //BIGINT
#define DTOREQCLAIMS_cusReqName @"cusReqName" //VARCHAR
#define DTOREQCLAIMS_customerId @"customerId" //BIGINT
#define DTOREQCLAIMS_descLoss @"descLoss" //VARCHAR
#define DTOREQCLAIMS_descProgressCause @"descProgressCause" //VARCHAR
#define DTOREQCLAIMS_employeeApproved @"employeeApproved" //BIGINT
#define DTOREQCLAIMS_employeeProcessed @"employeeProcessed" //BIGINT
#define DTOREQCLAIMS_employeeReceived @"employeeReceived" //BIGINT
#define DTOREQCLAIMS_forecastAccidentAmount @"forecastAccidentAmount" //BIGINT
#define DTOREQCLAIMS_insurancePersonNum @"insurancePersonNum" //BIGINT
#define DTOREQCLAIMS_keepScence @"keepScence" //BIGINT
#define DTOREQCLAIMS_licensePlate @"licensePlate" //VARCHAR
#define DTOREQCLAIMS_notes @"notes" //VARCHAR
#define DTOREQCLAIMS_orgProcessed @"orgProcessed" //BIGINT
#define DTOREQCLAIMS_policeProcessed @"policeProcessed" //VARCHAR
#define DTOREQCLAIMS_reqAttId @"reqAttId" //BIGINT
#define DTOREQCLAIMS_reqClaimsId @"reqClaimsId" //BIGINT
#define DTOREQCLAIMS_reqClaimsNo @"reqClaimsNo" //VARCHAR
#define DTOREQCLAIMS_reqContent @"reqContent" //VARCHAR
#define DTOREQCLAIMS_reqDate @"reqDate" //VARCHAR
#define DTOREQCLAIMS_witnessPhone @"witnessPhone" //VARCHAR
#define DTOREQCLAIMS_updatedBy @"updatedBy" //BIGINT
#define DTOREQCLAIMS_updatedDate @"updatedDate" //VARCHAR
#define DTOREQCLAIMS_verifyAddress @"verifyAddress" //VARCHAR
#define DTOREQCLAIMS_verifyLat @"verifyLat" //BIGINT
#define DTOREQCLAIMS_verifyLon @"verifyLon" //BIGINT
#define DTOREQCLAIMS_witnessAddr @"witnessAddr" //VARCHAR
#define DTOREQCLAIMS_witnessName @"witnessName" //VARCHAR
#define DTOREQCLAIMS_status @"status" //INTEGER
#define DTOREQCLAIMS_id @"id" //INTEGER
///dtoreqclaimsfile  Field
#define DTOREQCLAIMSFILE_clientReqClaimsFileId @"clientReqClaimsFileId" //BIGINT
#define DTOREQCLAIMSFILE_createdBy @"createdBy" //BIGINT
#define DTOREQCLAIMSFILE_createdDate @"createdDate" //VARCHAR
#define DTOREQCLAIMSFILE_fileId @"fileId" //BIGINT
#define DTOREQCLAIMSFILE_filePath @"filePath" //VARCHAR
#define DTOREQCLAIMSFILE_notes @"notes" //VARCHAR
#define DTOREQCLAIMSFILE_reqClaimsFileId @"reqClaimsFileId" //BIGINT
#define DTOREQCLAIMSFILE_reqClaimsId @"reqClaimsId" //BIGINT
#define DTOREQCLAIMSFILE_status @"status" //INTEGER
#define DTOREQCLAIMSFILE_topicId @"topicId" //BIGINT
#define DTOREQCLAIMSFILE_topicName @"topicName" //VARCHAR
#define DTOREQCLAIMSFILE_updatedBy @"updatedBy" //BIGINT
#define DTOREQCLAIMSFILE_updatedDate @"updatedDate" //VARCHAR
#define DTOREQCLAIMSFILE_id @"id" //INTEGER
///dtoreqclaimsquote  Field
#define DTOREQCLAIMSQUOTE_addressVerify @"addressVerify" //VARCHAR
#define DTOREQCLAIMSQUOTE_clientReqClaimsQuoteId @"clientReqClaimsQuoteId" //BIGINT
#define DTOREQCLAIMSQUOTE_createdBy @"createdBy" //BIGINT
#define DTOREQCLAIMSQUOTE_createdDate @"createdDate" //VARCHAR
#define DTOREQCLAIMSQUOTE_employeeVerify @"employeeVerify" //BIGINT
#define DTOREQCLAIMSQUOTE_fileQuoteId @"fileQuoteId" //BIGINT
#define DTOREQCLAIMSQUOTE_garageId @"garageId" //BIGINT
#define DTOREQCLAIMSQUOTE_latVerify @"latVerify" //VARCHAR
#define DTOREQCLAIMSQUOTE_lonVerify @"lonVerify" //VARCHAR
#define DTOREQCLAIMSQUOTE_notes @"notes" //VARCHAR
#define DTOREQCLAIMSQUOTE_orgQuoteId @"orgQuoteId" //BIGINT
#define DTOREQCLAIMSQUOTE_reqClaimsId @"reqClaimsId" //BIGINT
#define DTOREQCLAIMSQUOTE_reqClaimsQuoteId @"reqClaimsQuoteId" //BIGINT
#define DTOREQCLAIMSQUOTE_sendTime @"sendTime" //VARCHAR
#define DTOREQCLAIMSQUOTE_status @"status" //INTEGER
#define DTOREQCLAIMSQUOTE_summaryAmount @"summaryAmount" //VARCHAR
#define DTOREQCLAIMSQUOTE_updatedBy @"updatedBy" //BIGINT
#define DTOREQCLAIMSQUOTE_updatedDate @"updatedDate" //VARCHAR
#define DTOREQCLAIMSQUOTE_id @"id" //INTEGER
///dtoreqclaimsquotedetail  Field
#define DTOREQCLAIMSQUOTEDETAIL_amount @"amount" //VARCHAR
#define DTOREQCLAIMSQUOTEDETAIL_amountApprovedLevel1 @"amountApprovedLevel1" //VARCHAR
#define DTOREQCLAIMSQUOTEDETAIL_amountApprovedLevel2 @"amountApprovedLevel2" //VARCHAR
#define DTOREQCLAIMSQUOTEDETAIL_clientReqClaimsQuoteDetailId @"clientReqClaimsQuoteDetailId" //BIGINT
#define DTOREQCLAIMSQUOTEDETAIL_createdBy @"createdBy" //BIGINT
#define DTOREQCLAIMSQUOTEDETAIL_createdDate @"createdDate" //VARCHAR
#define DTOREQCLAIMSQUOTEDETAIL_itemContent @"itemContent" //VARCHAR
#define DTOREQCLAIMSQUOTEDETAIL_itemId @"itemId" //BIGINT
#define DTOREQCLAIMSQUOTEDETAIL_notes @"notes" //VARCHAR
#define DTOREQCLAIMSQUOTEDETAIL_quantity @"quantity" //VARCHAR
#define DTOREQCLAIMSQUOTEDETAIL_reqClaimsQuoteDetailId @"reqClaimsQuoteDetailId" //BIGINT
#define DTOREQCLAIMSQUOTEDETAIL_reqClaimsQuoteId @"reqClaimsQuoteId" //BIGINT
#define DTOREQCLAIMSQUOTEDETAIL_status @"status" //INTEGER
#define DTOREQCLAIMSQUOTEDETAIL_unitCurrency @"unitCurrency" //VARCHAR
#define DTOREQCLAIMSQUOTEDETAIL_updatedBy @"updatedBy" //BIGINT
#define DTOREQCLAIMSQUOTEDETAIL_updatedDate @"updatedDate" //VARCHAR
#define DTOREQCLAIMSQUOTEDETAIL_vat @"vat" //VARCHAR
#define DTOREQCLAIMSQUOTEDETAIL_id @"id" //INTEGER
///dtoreqclaimsverify  Field
#define DTOREQCLAIMSVERIFY_addressVerify @"addressVerify" //VARCHAR
#define DTOREQCLAIMSVERIFY_clientReqClaimsVerifyId @"clientReqClaimsVerifyId" //BIGINT
#define DTOREQCLAIMSVERIFY_content @"content" //VARCHAR
#define DTOREQCLAIMSVERIFY_createdBy @"createdBy" //BIGINT
#define DTOREQCLAIMSVERIFY_createdDate @"createdDate" //VARCHAR
#define DTOREQCLAIMSVERIFY_employeeVerify @"employeeVerify" //BIGINT
#define DTOREQCLAIMSVERIFY_fileAttId @"fileAttId" //BIGINT
#define DTOREQCLAIMSVERIFY_latVerify @"latVerify" //VARCHAR
#define DTOREQCLAIMSVERIFY_lonVerify @"lonVerify" //VARCHAR
#define DTOREQCLAIMSVERIFY_reqClaimsId @"reqClaimsId" //BIGINT
#define DTOREQCLAIMSVERIFY_reqClaimsVerifyId @"reqClaimsVerifyId" //BIGINT
#define DTOREQCLAIMSVERIFY_sendTime @"sendTime" //VARCHAR
#define DTOREQCLAIMSVERIFY_status @"status" //INTEGER
#define DTOREQCLAIMSVERIFY_suggestContent @"suggestContent" //VARCHAR
#define DTOREQCLAIMSVERIFY_summaryAfterAccident @"summaryAfterAccident" //VARCHAR
#define DTOREQCLAIMSVERIFY_summaryBeforeAccident @"summaryBeforeAccident" //VARCHAR
#define DTOREQCLAIMSVERIFY_updatedBy @"updatedBy" //BIGINT
#define DTOREQCLAIMSVERIFY_updatedDate @"updatedDate" //VARCHAR
#define DTOREQCLAIMSVERIFY_id @"id" //INTEGER
///dtoagent  Field
#define DTOAGENT_activeDate @"activeDate" //VARCHAR
#define DTOAGENT_address @"address" //VARCHAR
#define DTOAGENT_agentId @"agentId" //BIGINT
#define DTOAGENT_agentLevel @"agentLevel" //BIGINT
#define DTOAGENT_agentName @"agentName" //VARCHAR
#define DTOAGENT_agentRate @"agentRate" //BIGINT
#define DTOAGENT_agentType @"agentType" //VARCHAR
#define DTOAGENT_authorityDate @"authorityDate" //VARCHAR
#define DTOAGENT_authorizationDate @"authorizationDate" //VARCHAR
#define DTOAGENT_bankAccount @"bankAccount" //VARCHAR
#define DTOAGENT_bankName @"bankName" //VARCHAR
#define DTOAGENT_branchId @"branchId" //BIGINT
#define DTOAGENT_createdBy @"createdBy" //BIGINT
#define DTOAGENT_createdDate @"createdDate" //VARCHAR
#define DTOAGENT_email @"email" //VARCHAR
#define DTOAGENT_image @"image" //BIGINT
#define DTOAGENT_industryBusiness @"industryBusiness" //VARCHAR
#define DTOAGENT_lat @"lat" //VARCHAR
#define DTOAGENT_leaderSign @"leaderSign" //BIGINT
#define DTOAGENT_listStaff @"listStaff" //BIGINT
#define DTOAGENT_lon @"lon" //VARCHAR
#define DTOAGENT_mobile @"mobile" //VARCHAR
#define DTOAGENT_ownEmployeeId @"ownEmployeeId" //BIGINT
#define DTOAGENT_ownSign @"ownSign" //BIGINT
#define DTOAGENT_parentId @"parentId" //BIGINT
#define DTOAGENT_phone @"phone" //VARCHAR
#define DTOAGENT_profile @"profile" //BIGINT
#define DTOAGENT_registrationDate @"registrationDate" //VARCHAR
#define DTOAGENT_registrationNumber @"registrationNumber" //VARCHAR
#define DTOAGENT_registrationNumberDate @"registrationNumberDate" //VARCHAR
#define DTOAGENT_registrationNumberExpired @"registrationNumberExpired" //VARCHAR
#define DTOAGENT_registrationNumberType @"registrationNumberType" //VARCHAR
#define DTOAGENT_status @"status" //INTEGER
#define DTOAGENT_taxCode @"taxCode" //VARCHAR
#define DTOAGENT_taxIssuedArea @"taxIssuedArea" //VARCHAR
#define DTOAGENT_taxIssuedDate @"taxIssuedDate" //VARCHAR
#define DTOAGENT_taxPage @"taxPage" //BIGINT
#define DTOAGENT_updatedBy @"updatedBy" //BIGINT
#define DTOAGENT_updatedDate @"updatedDate" //VARCHAR
#define DTOAGENT_workPlace @"workPlace" //VARCHAR
#define DTOAGENT_id @"id" //INTEGER
///dtosaleorderverify  Field
#define DTOSALEORDERVERIFY_clientSalesOrderVerifyId @"clientSalesOrderVerifyId" //BIGINT
#define DTOSALEORDERVERIFY_contentComment @"contentComment" //VARCHAR
#define DTOSALEORDERVERIFY_createdBy @"createdBy" //BIGINT
#define DTOSALEORDERVERIFY_createdDate @"createdDate" //VARCHAR
#define DTOSALEORDERVERIFY_employeeVerify @"employeeVerify" //BIGINT
#define DTOSALEORDERVERIFY_fileAttId @"fileAttId" //BIGINT
#define DTOSALEORDERVERIFY_salesOderId @"salesOderId" //BIGINT
#define DTOSALEORDERVERIFY_salesOderVerifyId @"salesOderVerifyId" //BIGINT
#define DTOSALEORDERVERIFY_sendTime @"sendTime" //VARCHAR
#define DTOSALEORDERVERIFY_updatedBy @"updatedBy" //BIGINT
#define DTOSALEORDERVERIFY_updatedDate @"updatedDate" //VARCHAR
#define DTOSALEORDERVERIFY_verifyAddress @"verifyAddress" //VARCHAR
#define DTOSALEORDERVERIFY_verifyLat @"verifyLat" //VARCHAR
#define DTOSALEORDERVERIFY_verifyLon @"verifyLon" //VARCHAR
#define DTOSALEORDERVERIFY_id @"id" //INTEGER
///dtosaleorder  Field
#define DTOSALEORDER_addrLat @"addrLat" //VARCHAR
#define DTOSALEORDER_addrLon @"addrLon" //VARCHAR
#define DTOSALEORDER_clientSaleOrderId @"clientSaleOrderId" //BIGINT
#define DTOSALEORDER_contentComment @"contentComment" //VARCHAR
#define DTOSALEORDER_contentProcess @"contentProcess" //VARCHAR
#define DTOSALEORDER_contractId @"contractId" //BIGINT
#define DTOSALEORDER_contractNo @"contractNo" //VARCHAR
#define DTOSALEORDER_createDate @"createDate" //VARCHAR
#define DTOSALEORDER_createdBy @"createdBy" //BIGINT
#define DTOSALEORDER_currencyFee @"currencyFee" //VARCHAR
#define DTOSALEORDER_cusAddress @"cusAddress" //VARCHAR
#define DTOSALEORDER_cusName @"cusName" //VARCHAR
#define DTOSALEORDER_cusPhone @"cusPhone" //VARCHAR
#define DTOSALEORDER_cusType @"cusType" //INTEGER
#define DTOSALEORDER_customerId @"customerId" //BIGINT
#define DTOSALEORDER_employeeApproved @"employeeApproved" //BIGINT
#define DTOSALEORDER_employeeProcess @"employeeProcess" //BIGINT
#define DTOSALEORDER_employeeReceived @"employeeReceived" //BIGINT
#define DTOSALEORDER_employeeVerify @"employeeVerify" //BIGINT
#define DTOSALEORDER_expiredDate @"expiredDate" //VARCHAR
#define DTOSALEORDER_fromDateTime @"fromDateTime" //VARCHAR
#define DTOSALEORDER_houseValue @"houseValue" //BIGINT
#define DTOSALEORDER_idNo @"idNo" //VARCHAR
#define DTOSALEORDER_memberListAttId @"memberListAttId" //BIGINT
#define DTOSALEORDER_orderAttId @"orderAttId" //BIGINT
#define DTOSALEORDER_orgProcess @"orgProcess" //VARCHAR
#define DTOSALEORDER_paidStatus @"paidStatus" //INTEGER
#define DTOSALEORDER_personInsuranceNum @"personInsuranceNum" //BIGINT
#define DTOSALEORDER_productId @"productId" //BIGINT
#define DTOSALEORDER_propertyValue @"propertyValue" //BIGINT
#define DTOSALEORDER_saleOrderCode @"saleOrderCode" //VARCHAR
#define DTOSALEORDER_saleOrderId @"saleOrderId" //BIGINT
#define DTOSALEORDER_salesOrderTime @"salesOrderTime" //VARCHAR
#define DTOSALEORDER_status @"status" //INTEGER
#define DTOSALEORDER_sysOrgId @"sysOrgId" //BIGINT
#define DTOSALEORDER_timeUsed @"timeUsed" //BIGINT
#define DTOSALEORDER_updatedBy @"updatedBy" //BIGINT
#define DTOSALEORDER_updatedDate @"updatedDate" //VARCHAR
#define DTOSALEORDER_id @"id" //INTEGER
///dtosaleorderdetail  Field
#define DTOSALEORDERDETAIL_attribute1 @"attribute1" //VARCHAR
#define DTOSALEORDERDETAIL_attribute2 @"attribute2" //VARCHAR
#define DTOSALEORDERDETAIL_attribute3 @"attribute3" //VARCHAR
#define DTOSALEORDERDETAIL_attributeDate6 @"attributeDate6" //VARCHAR
#define DTOSALEORDERDETAIL_attributeDatetime7 @"attributeDatetime7" //VARCHAR
#define DTOSALEORDERDETAIL_attributeNum4 @"attributeNum4" //BIGINT
#define DTOSALEORDERDETAIL_attributeNum5 @"attributeNum5" //BIGINT
#define DTOSALEORDERDETAIL_baseValue @"baseValue" //BIGINT
#define DTOSALEORDERDETAIL_clientSaleOrderDetailId @"clientSaleOrderDetailId" //BIGINT
#define DTOSALEORDERDETAIL_createBy @"createBy" //BIGINT
#define DTOSALEORDERDETAIL_createDate @"createDate" //VARCHAR
#define DTOSALEORDERDETAIL_extValue @"extValue" //BIGINT
#define DTOSALEORDERDETAIL_manufactureYear @"manufactureYear" //VARCHAR
#define DTOSALEORDERDETAIL_manufacturer @"manufacturer" //VARCHAR
#define DTOSALEORDERDETAIL_moneyPerPersonAccident @"moneyPerPersonAccident" //VARCHAR
#define DTOSALEORDERDETAIL_objectRelId @"objectRelId" //BIGINT
#define DTOSALEORDERDETAIL_productLine @"productLine" //VARCHAR
#define DTOSALEORDERDETAIL_saleOrderDetailId @"saleOrderDetailId" //BIGINT
#define DTOSALEORDERDETAIL_saleOrderId @"saleOrderId" //BIGINT
#define DTOSALEORDERDETAIL_seatNum @"seatNum" //BIGINT
#define DTOSALEORDERDETAIL_status @"status" //INTEGER
#define DTOSALEORDERDETAIL_updatedBy @"updatedBy" //BIGINT
#define DTOSALEORDERDETAIL_updatedDate @"updatedDate" //VARCHAR
#define DTOSALEORDERDETAIL_vehicleType @"vehicleType" //VARCHAR
#define DTOSALEORDERDETAIL_id @"id" //INTEGER
///dtotransaction  Field
#define DTOTRANSACTION_IdNo @"IdNo" //VARCHAR
#define DTOTRANSACTION_cerAttId @"cerAttId" //BIGINT
#define DTOTRANSACTION_certificateNo @"certificateNo" //VARCHAR
#define DTOTRANSACTION_clientTransactionId @"clientTransactionId" //BIGINT
#define DTOTRANSACTION_createdBy @"createdBy" //BIGINT
#define DTOTRANSACTION_createdDate @"createdDate" //VARCHAR
#define DTOTRANSACTION_currency @"currency" //BIGINT
#define DTOTRANSACTION_currencyFee @"currencyFee" //VARCHAR
#define DTOTRANSACTION_cusAddress @"cusAddress" //VARCHAR
#define DTOTRANSACTION_cusName @"cusName" //VARCHAR
#define DTOTRANSACTION_cusPhone @"cusPhone" //VARCHAR
#define DTOTRANSACTION_cusType @"cusType" //INTEGER
#define DTOTRANSACTION_customerId @"customerId" //BIGINT
#define DTOTRANSACTION_expiredDate @"expiredDate" //VARCHAR
#define DTOTRANSACTION_fromDate @"fromDate" //VARCHAR
#define DTOTRANSACTION_houseValue @"houseValue" //BIGINT
#define DTOTRANSACTION_licensePlate @"licensePlate" //VARCHAR
#define DTOTRANSACTION_paidStatus @"paidStatus" //INTEGER
#define DTOTRANSACTION_personInsuranceNum @"personInsuranceNum" //INTEGER
#define DTOTRANSACTION_productId @"productId" //BIGINT
#define DTOTRANSACTION_propertyValue @"propertyValue" //BIGINT
#define DTOTRANSACTION_salesAttId @"salesAttId" //BIGINT
#define DTOTRANSACTION_salesDate @"salesDate" //VARCHAR
#define DTOTRANSACTION_salesOrderNo @"salesOrderNo" //BIGINT
#define DTOTRANSACTION_salesOrderNoClient @"salesOrderNoClient" //BIGINT
#define DTOTRANSACTION_smsSendStatus @"smsSendStatus" //INTEGER
#define DTOTRANSACTION_status @"status" //BIGINT
#define DTOTRANSACTION_timeUsed @"timeUsed" //BIGINT
#define DTOTRANSACTION_transAddress @"transAddress" //VARCHAR
#define DTOTRANSACTION_transLat @"transLat" //VARCHAR
#define DTOTRANSACTION_transLon @"transLon" //VARCHAR
#define DTOTRANSACTION_transactionId @"transactionId" //BIGINT
#define DTOTRANSACTION_updatedBy @"updatedBy" //BIGINT
#define DTOTRANSACTION_updatedDate @"updatedDate" //VARCHAR
#define DTOTRANSACTION_userSales @"userSales" //VARCHAR
#define DTOTRANSACTION_vehicleFrameNo @"vehicleFrameNo" //VARCHAR
#define DTOTRANSACTION_vehicleNo @"vehicleNo" //VARCHAR
#define DTOTRANSACTION_id @"id" //INTEGER
///dtosmsunsent  Field
#define DTOSMSUNSENT_clientSmsId @"clientSmsId" //BIGINT
#define DTOSMSUNSENT_countError @"countError" //INTEGER
#define DTOSMSUNSENT_createdTime @"createdTime" //VARCHAR
#define DTOSMSUNSENT_message @"message" //VARCHAR
#define DTOSMSUNSENT_objectId @"objectId" //BIGINT
#define DTOSMSUNSENT_objectType @"objectType" //VARCHAR
#define DTOSMSUNSENT_sendTime @"sendTime" //VARCHAR
#define DTOSMSUNSENT_smsId @"smsId" //BIGINT
#define DTOSMSUNSENT_smsTo @"smsTo" //VARCHAR
#define DTOSMSUNSENT_id @"id" //INTEGER
///dtotransdetail  Field
#define DTOTRANSDETAIL_baseValue @"baseValue" //BIGINT
#define DTOTRANSDETAIL_clientTransDetailId @"clientTransDetailId" //BIGINT
#define DTOTRANSDETAIL_createdBy @"createdBy" //BIGINT
#define DTOTRANSDETAIL_createdDate @"createdDate" //VARCHAR
#define DTOTRANSDETAIL_extValue @"extValue" //BIGINT
#define DTOTRANSDETAIL_manufactureYear @"manufactureYear" //VARCHAR
#define DTOTRANSDETAIL_manufacturer @"manufacturer" //VARCHAR
#define DTOTRANSDETAIL_moneyPerPersonAccident @"moneyPerPersonAccident" //VARCHAR
#define DTOTRANSDETAIL_numberOfSeats @"numberOfSeats" //INTEGER
#define DTOTRANSDETAIL_objectRelId @"objectRelId" //BIGINT
#define DTOTRANSDETAIL_productLine @"productLine" //VARCHAR
#define DTOTRANSDETAIL_status @"status" //INTEGER
#define DTOTRANSDETAIL_transDetailId @"transDetailId" //BIGINT
#define DTOTRANSDETAIL_transactionId @"transactionId" //BIGINT
#define DTOTRANSDETAIL_updatedBy @"updatedBy" //BIGINT
#define DTOTRANSDETAIL_updatedDate @"updatedDate" //VARCHAR
#define DTOTRANSDETAIL_vehicleType @"vehicleType" //VARCHAR
#define DTOTRANSDETAIL_id @"id" //INTEGER
///dtoobjectfavorite  Field
#define DTOOBJECTFAVORITE_createdBy @"createdBy" //BIGINT
#define DTOOBJECTFAVORITE_createdDate @"createdDate" //VARCHAR
#define DTOOBJECTFAVORITE_employeeId @"employeeId" //BIGINT
#define DTOOBJECTFAVORITE_favoriteLevel @"favoriteLevel" //INTEGER
#define DTOOBJECTFAVORITE_objectFavoriteId @"objectFavoriteId" //BIGINT
#define DTOOBJECTFAVORITE_objectId @"objectId" //BIGINT
#define DTOOBJECTFAVORITE_objectName @"objectName" //VARCHAR
#define DTOOBJECTFAVORITE_objectType @"objectType" //VARCHAR
#define DTOOBJECTFAVORITE_updatedBy @"updatedBy" //BIGINT
#define DTOOBJECTFAVORITE_updatedDate @"updatedDate" //VARCHAR
#define DTOOBJECTFAVORITE_id @"id" //INTEGER
///dtogarage  Field
#define DTOGARAGE_address @"address" //VARCHAR
#define DTOGARAGE_clientGarageId @"clientGarageId" //BIGINT
#define DTOGARAGE_createdBy @"createdBy" //BIGINT
#define DTOGARAGE_createdDate @"createdDate" //VARCHAR
#define DTOGARAGE_fax @"fax" //VARCHAR
#define DTOGARAGE_fax2 @"fax2" //VARCHAR
#define DTOGARAGE_garageId @"garageId" //BIGINT
#define DTOGARAGE_garageLat @"garageLat" //VARCHAR
#define DTOGARAGE_garageLon @"garageLon" //VARCHAR
#define DTOGARAGE_garageName @"garageName" //VARCHAR
#define DTOGARAGE_hotline @"hotline" //VARCHAR
#define DTOGARAGE_phone @"phone" //VARCHAR
#define DTOGARAGE_phone2 @"phone2" //VARCHAR
#define DTOGARAGE_status @"status" //BIGINT
#define DTOGARAGE_taxCode @"taxCode" //VARCHAR
#define DTOGARAGE_updatedBy @"updatedBy" //BIGINT
#define DTOGARAGE_updatedDate @"updatedDate" //VARCHAR
#define DTOGARAGE_id @"id" //INTEGER
///TABLETEST  Field
#define TABLETEST_ID @"ID" //TEXT
#define TABLETEST_TITLE @"TITLE" //TEXT


@interface DataField : NSObject

@end
