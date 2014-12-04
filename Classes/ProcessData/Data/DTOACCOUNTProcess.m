//
//  DTOACCOUNTProcess.m
//  OfficeOneStudy
//
//  Created by viettel on 11/11/14.
//
//

#import "DTOACCOUNTProcess.h"
#import "DataUtil.h"

//remove
#import "DataField.h"

#define TABLENAME_DTOACCOUNT @"dtoaccount"

@implementation DTOACCOUNTProcess


-(NSArray*) getAllFields {
    
    return  [NSArray arrayWithObjects: DTOACCOUNT_accountId ,//accountId" //BIGINT
 DTOACCOUNT_accountLevel ,//accountLevel" //VARCHAR
 DTOACCOUNT_accountType ,//accountType" //VARCHAR
 DTOACCOUNT_activityStatus ,//activityStatus" //BIGINT
 DTOACCOUNT_address ,//address" //VARCHAR
 DTOACCOUNT_areaId ,//areaId" //BIGINT
 DTOACCOUNT_assetTotal ,//assetTotal" //VARCHAR
 DTOACCOUNT_birthday ,//birthday" //VARCHAR
 DTOACCOUNT_branchCode ,//branchCode" //VARCHAR
 DTOACCOUNT_charter ,//charter" //VARCHAR
 DTOACCOUNT_clientAccountId ,//clientAccountId" //BIGINT
 DTOACCOUNT_clientId ,//clientId" //BIGINT
 DTOACCOUNT_code ,//code" //VARCHAR
 DTOACCOUNT_createdBy ,//createdBy" //BIGINT
 DTOACCOUNT_createdDate ,//createdDate" //VARCHAR
 DTOACCOUNT_disableEmail ,//disableEmail" //SMALLINT
 DTOACCOUNT_disableMeeting ,//disableMeeting" //SMALLINT
 DTOACCOUNT_disablePhone ,//disablePhone" //SMALLINT
 DTOACCOUNT_disableSms ,//disableSms" //SMALLINT
 DTOACCOUNT_email ,//email" //VARCHAR
 DTOACCOUNT_employeeCode ,//employeeCode" //VARCHAR
 DTOACCOUNT_employeeNumber ,//employeeNumber" //VARCHAR
 DTOACCOUNT_familyIncome ,//familyIncome" //VARCHAR
 DTOACCOUNT_fax ,//fax" //VARCHAR
 DTOACCOUNT_identifiedIssueArea ,//identifiedIssueArea" //VARCHAR
 DTOACCOUNT_identifiedIssueDate ,//identifiedIssueDate" //VARCHAR
 DTOACCOUNT_identifiedNumber ,//identifiedNumber" //VARCHAR
 DTOACCOUNT_industryBusiness ,//industryBusiness" //VARCHAR
 DTOACCOUNT_isActive ,//isActive" //SMALLINT
 DTOACCOUNT_languageId ,//languageId" //BIGINT
 DTOACCOUNT_lastTransaction ,//lastTransaction" //VARCHAR
 DTOACCOUNT_lat ,//lat" //VARCHAR
 DTOACCOUNT_lon ,//lon" //VARCHAR
 DTOACCOUNT_marialStatus ,//marialStatus" //SMALLINT
 DTOACCOUNT_mnemonic ,//mnemonic" //VARCHAR
 DTOACCOUNT_mobile ,//mobile" //VARCHAR
 DTOACCOUNT_name ,//name" //VARCHAR
 DTOACCOUNT_openCodeDate ,//openCodeDate" //VARCHAR
 DTOACCOUNT_orgType ,//orgType" //BIGINT
 DTOACCOUNT_ownerEmployeeId ,//ownerEmployeeId" //BIGINT
 DTOACCOUNT_personalIncome ,//personalIncome" //VARCHAR
 DTOACCOUNT_personalIndustry ,//personalIndustry" //VARCHAR
 DTOACCOUNT_phone ,//phone" //VARCHAR
 DTOACCOUNT_registrationAddress ,//registrationAddress" //VARCHAR
 DTOACCOUNT_registrationDate ,//registrationDate" //VARCHAR
 DTOACCOUNT_registrationNumber ,//registrationNumber" //VARCHAR
 DTOACCOUNT_revenue ,//revenue" //VARCHAR
 DTOACCOUNT_sector ,//sector" //VARCHAR
 DTOACCOUNT_setupDate ,//setupDate" //VARCHAR
 DTOACCOUNT_sex ,//sex" //VARCHAR
 DTOACCOUNT_shareholderNumber ,//shareholderNumber" //BIGINT
 DTOACCOUNT_status ,//status" //INTEGER
 DTOACCOUNT_swiftCode ,//swiftCode" //VARCHAR
 DTOACCOUNT_sysOrganizationId ,//sysOrganizationId" //BIGINT
 DTOACCOUNT_taxCode ,//taxCode" //VARCHAR
 DTOACCOUNT_taxIssuedDate ,//taxIssuedDate" //VARCHAR
 DTOACCOUNT_updatedBy ,//updatedBy" //BIGINT
 DTOACCOUNT_updatedDate ,//updatedDate" //VARCHAR
 DTOACCOUNT_website ,//website" //VARCHAR
 DTOACCOUNT_id , nil];//id" //INTEGER
              //id" //INTEGER, nil]
}


-(BOOL) deleteEntity:(NSString *)leadId{
    
    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOACCOUNT_status, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:leadId, nil] forKeys:[NSArray arrayWithObjects:DTOACCOUNT_id, nil]];
    
    
    return [super updateToTableName:TABLENAME_DTOACCOUNT withFields:dicFieldSet withCondition:dicFieldCondition];
}


-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    if ([[entity allKeys] containsObject:DTOACCOUNT_id]) {
        return [self updateToDBWithEntity:entity];
    }
    
    return [super addToDBWithTableName:TABLENAME_DTOACCOUNT dictionary:entity];
    
}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOACCOUNT_id] , DTOACCOUNT_id, nil];
    
    return [super updateToTableName:TABLENAME_DTOACCOUNT withFields:entity withCondition:dicCondition];
    
}

-(NSMutableArray*) filter{

    
    NSArray *allFields =[NSArray arrayWithObjects:DTOACCOUNT_accountId, DTOACCOUNT_address, DTOACCOUNT_email, DTOACCOUNT_mobile, DTOACCOUNT_name,DTOACCOUNT_updatedBy,DTOACCOUNT_code, DTOACCOUNT_accountType,DTOACCOUNT_clientAccountId, DTOACCOUNT_lat, DTOACCOUNT_lon, DTOACCOUNT_id, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOACCOUNT, DTOACCOUNT_updatedDate];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}


-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue{

    NSArray *allFields =[NSArray arrayWithObjects:DTOACCOUNT_accountId, DTOACCOUNT_address, DTOACCOUNT_email, DTOACCOUNT_mobile, DTOACCOUNT_name,DTOACCOUNT_updatedBy,DTOACCOUNT_code, DTOACCOUNT_accountType,DTOACCOUNT_clientAccountId, DTOACCOUNT_lat, DTOACCOUNT_lon, DTOACCOUNT_id, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 and %@  like ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOACCOUNT, strKey, DTOACCOUNT_updatedDate];
    
    NSLog(@"query = %@", query);
    NSString *value = @"%";
    value = [value stringByAppendingString:[strValue stringByAppendingString:@"%"]];
    
    NSLog(@"param = %@", value);
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:value, nil]];
    
    
}

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue{
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    listDic = [super getAllItemsWithTableName:TABLENAME_DTOACCOUNT withFields:[self getAllFields] withConditionString:[NSString stringWithFormat:@" Where %@ = ?", inputKey] withParameter:[NSArray arrayWithObjects:inputValue, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        
        return [listDic objectAtIndex:0];
        
    }
    
    return nil;
}

-(NSInteger) getClientId {
    return [super getMaxClientIdWithTableName:TABLENAME_DTOACCOUNT withField:DTOACCOUNT_clientAccountId];
}

@end
