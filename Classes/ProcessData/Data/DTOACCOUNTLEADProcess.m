//
//  DTOACCOUNTLEADProcess.m
//  OfficeOneStudy
//
//  Created by ADMIN on 11/13/14.
//
//

#import "DTOACCOUNTLEADProcess.h"
#import "DataUtil.h"

#define TABLENAME_DTOACCOUNTLEAD @"dtolead"

@implementation DTOACCOUNTLEADProcess

-(NSArray*) getAllFields {
    return  [NSArray arrayWithObjects:DTOLEAD_accountId, //BIGINT
 DTOLEAD_address ,
 DTOLEAD_areaId ,
 DTOLEAD_assetTotal ,
 DTOLEAD_auditId ,
 DTOLEAD_birthday ,
 DTOLEAD_campaignId ,
 DTOLEAD_charter ,
 DTOLEAD_clientId ,
 DTOLEAD_clientLeadId ,//clientLeadId" //BIGINT
 DTOLEAD_code ,//code" //VARCHAR
 DTOLEAD_companyPhone ,//companyPhone" //VARCHAR
 DTOLEAD_createdBy ,//createdBy" //BIGINT
 DTOLEAD_createdDate ,//createdDate" //VARCHAR
 DTOLEAD_disableEmail ,//disableEmail" //SMALLINT
 DTOLEAD_disableMeeting ,//disableMeeting" //SMALLINT
 DTOLEAD_disablePhone ,//disablePhone" //SMALLINT
 DTOLEAD_disableSms ,//disableSms" //SMALLINT
 DTOLEAD_email ,//email" //VARCHAR
 DTOLEAD_employeeNumber ,//employeeNumber" //BIGINT
 DTOLEAD_equityOwner ,//equityOwner" //VARCHAR
 DTOLEAD_fax ,//fax" //VARCHAR
 DTOLEAD_identifiedNumber ,//identifiedNumber" //VARCHAR
 DTOLEAD_isFi ,//isFi" //SMALLINT
 DTOLEAD_languageId ,//languageId" //BIGINT
 DTOLEAD_lat ,//lat" //VARCHAR
 DTOLEAD_leadId ,//leadId" //BIGINT
 DTOLEAD_leadStatusId //leadStatusId" //BIGINT
, DTOLEAD_leadType //leadType" //INTEGER
, DTOLEAD_lon //lon" //VARCHAR
, DTOLEAD_marialStatus //marialStatus" //SMALLINT
, DTOLEAD_mergedLeadId //mergedLeadId" //BIGINT
, DTOLEAD_mobile //mobile" //VARCHAR
, DTOLEAD_monthlyIncome //monthlyIncome" //VARCHAR
, DTOLEAD_name //name" //VARCHAR
, DTOLEAD_orgTypeId //orgTypeId" //BIGINT
, DTOLEAD_organization //organization" //VARCHAR
, DTOLEAD_ownerEmployeeId //ownerEmployeeId" //BIGINT
, DTOLEAD_passport //passport" //VARCHAR
, DTOLEAD_personalJob //personalJob" //BIGINT
, DTOLEAD_personalPosition //personalPosition" //BIGINT
, DTOLEAD_phone //phone" //VARCHAR
, DTOLEAD_pinMilitary //pinMilitary" //VARCHAR
, DTOLEAD_profitNonTax //profitNonTax" //VARCHAR
, DTOLEAD_registrationNumber //registrationNumber" //VARCHAR
, DTOLEAD_revenue //revenue" //VARCHAR
, DTOLEAD_sector //sector" //VARCHAR
, DTOLEAD_sex //sex" //VARCHAR
, DTOLEAD_shareholderNumber //shareholderNumber" //VARCHAR
, DTOLEAD_sourceDescription //sourceDescription" //VARCHAR
, DTOLEAD_sourceId //sourceId" //BIGINT
, DTOLEAD_status //status" //INTEGER
, DTOLEAD_statusDescription //statusDescription" //VARCHAR
, DTOLEAD_swiftCode //swiftCode" //VARCHAR
, DTOLEAD_sysOrganizationId //sysOrganizationId" //BIGINT
, DTOLEAD_taxCode //taxCode" //VARCHAR
, DTOLEAD_updatedBy //updatedBy" //BIGINT
, DTOLEAD_updatedDate //updatedDate" //VARCHAR
, DTOLEAD_website //website" //VARCHAR
             , DTOLEAD_id, nil]; //id" //INTEGER, nil]
}


-(BOOL) deleteEntity:(NSString *)leadId{
    
    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOLEAD_status, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:leadId, nil] forKeys:[NSArray arrayWithObjects:DTOLEAD_id, nil]];
    
    
    return [super updateToTableName:TABLENAME_DTOACCOUNTLEAD withFields:dicFieldSet withCondition:dicFieldCondition];
}


-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    if ([[entity allKeys] containsObject:DTOLEAD_id]) {
        return [self updateToDBWithEntity:entity];
    }
    
    return [super addToDBWithTableName:TABLENAME_DTOACCOUNTLEAD dictionary:entity];
    
}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOLEAD_id] , DTOLEAD_id, nil];
    
    return [super updateToTableName:TABLENAME_DTOACCOUNTLEAD withFields:entity withCondition:dicCondition];
    
}

-(NSMutableArray*) filter{
//    NSArray *allFields =[NSArray arrayWithObjects:DTOLEAD_accountId, DTOLEAD_address, DTOLEAD_companyPhone, DTOLEAD_email, DTOLEAD_mobile, DTOLEAD_name,DTOLEAD_updatedBy,DTOLEAD_code, DTOLEAD_leadId, DTOLEAD_leadType,DTOLEAD_clientLeadId, DTOLEAD_id, nil];
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOLEAD_accountId, DTOLEAD_address, DTOLEAD_companyPhone, DTOLEAD_email, DTOLEAD_mobile, DTOLEAD_name,DTOLEAD_updatedBy,DTOLEAD_code, DTOLEAD_leadId, DTOLEAD_leadType,DTOLEAD_clientLeadId, DTOLEAD_lat, DTOLEAD_lon, DTOLEAD_id, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOACCOUNTLEAD, DTOLEAD_updatedDate];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}


-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue{
    NSArray *allFields =[NSArray arrayWithObjects:DTOLEAD_accountId, DTOLEAD_address, DTOLEAD_companyPhone, DTOLEAD_email, DTOLEAD_mobile, DTOLEAD_name,DTOLEAD_updatedBy,DTOLEAD_code, DTOLEAD_leadId, DTOLEAD_leadType,DTOLEAD_clientLeadId, DTOLEAD_lat, DTOLEAD_lon, DTOLEAD_id, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 and %@  like ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOACCOUNTLEAD, strKey, DTOLEAD_updatedDate];
    
    NSLog(@"query = %@", query);
    NSString *value = @"%";
    value = [value stringByAppendingString:[strValue stringByAppendingString:@"%"]];
    
    NSLog(@"param = %@", value);
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:value, nil]];
    
    
}

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue{
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    listDic = [super getAllItemsWithTableName:TABLENAME_DTOACCOUNTLEAD withFields:[self getAllFields] withConditionString:[NSString stringWithFormat:@" Where %@ = ?", inputKey] withParameter:[NSArray arrayWithObjects:inputValue, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        
        return [listDic objectAtIndex:0];
        
    }
    
    return nil;
}

@end
