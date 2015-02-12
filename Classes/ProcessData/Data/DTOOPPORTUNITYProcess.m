//
//  DTOOPPORTUNITYProcess.m
//  OfficeOneStudy
//
//  Created by viettel on 11/3/14.
//
//

#import "DTOOPPORTUNITYProcess.h"
#import "DataUtil.h"
#import "DataField.h"
#import <sqlite3.h>

#define TableName_DTOOPPORTUNTITY @"dtoopportunity"

@implementation DTOOPPORTUNITYProcess

-(NSArray*) getAllFields {
    return  [NSArray arrayWithObjects: DTOOPPORTUNITY_accountId, //BIGINT
 DTOOPPORTUNITY_campaignId,  //BIGINT
DTOOPPORTUNITY_client, //BIGINT
DTOOPPORTUNITY_clientOpportunityId,//BIGINT
 DTOOPPORTUNITY_code, //VARCHAR
 DTOOPPORTUNITY_createdBy, //BIGINT
DTOOPPORTUNITY_createdDate,//VARCHAR
DTOOPPORTUNITY_description, //VARCHAR
 DTOOPPORTUNITY_employeeId,//BIGINT
 DTOOPPORTUNITY_endDate, //VARCHAR
 DTOOPPORTUNITY_endDateReal, //VARCHAR
 DTOOPPORTUNITY_isActive, //SMALLINT
 DTOOPPORTUNITY_languageId, //BIGINT
DTOOPPORTUNITY_leadId, //BIGINT
DTOOPPORTUNITY_name, //VARCHAR
DTOOPPORTUNITY_needSupport, //SMALLINT
 DTOOPPORTUNITY_nextTask, //BIGINT
 DTOOPPORTUNITY_opportunityId,//BIGINT
 DTOOPPORTUNITY_opportunityLevelId, //BIGINT
DTOOPPORTUNITY_resultDescription, //VARCHAR
DTOOPPORTUNITY_startDate, //VARCHAR
 DTOOPPORTUNITY_startDateReal, //VARCHAR
 DTOOPPORTUNITY_status, //INTEGER
 DTOOPPORTUNITY_successPercent, //INTEGER
 DTOOPPORTUNITY_sysOrganizationId, //BIGINT
DTOOPPORTUNITY_type, //BIGINT
DTOOPPORTUNITY_updatedBy, //BIGINT
DTOOPPORTUNITY_updatedDate, //VARCHAR
             DTOOPPORTUNITY_id,nil]; //INTEGER
}


-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    return [super addToDBWithTableName:TableName_DTOOPPORTUNTITY dictionary:entity];
    
}
-(NSMutableArray*) filterOpportunity:(NSString*)keyword addStartDate:(NSDate*)startDate addEndDate:(NSDate*)endDate userType:(int)type withStart : (int) start withLimit : (int) limit withOutTotal : (int*) totalCount{
    
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOOPPORTUNITY_id, DTOOPPORTUNITY_clientOpportunityId, DTOCONTACT_fullName, DTOOPPORTUNITY_code, DTOOPPORTUNITY_name, DTOOPPORTUNITY_endDate, DTOOPPORTUNITY_startDate,@"StatusName", DTOOPPORTUNITY_status,@"Contact",@"ContactCode",@"Level",@"LevelValue",@"Type", nil];
    
    NSMutableString *query = [[NSMutableString alloc] initWithString:@"SELECT op.id,op.clientOpportunityId,fullName,op.code,op.name,endDate,startDate \
                        ,catStatus.name as StatusName \
                        ,op.status \
                        ,case \
                            when op.accountId is null then ld.name \
                            when op.leadId is null then ac.name \
                        end as Contact \
                       ,case \
                            when op.accountId is null then ld.clientId \
                            when op.leadId is null then ac.clientAccountId \
                        end as ContactCode \
                       ,catLevel.name as Level \
                       ,catLevel.value as LevelValue \
                       ,catType.name as Type \
                FROM  dtoopportunity op \
                LEFT JOIN dtoopportunitycontact opc ON op.clientOpportunityId=opc.clientOpportunityContactId \
                LEFT JOIN dtocontact con ON opc.clientOpportunityContactId = con.clientContactId \
                LEFT JOIN dtosyscat catStatus ON op.status = catStatus.value \
                        AND catStatus.sysCatTypeId = 10 \
                LEFT JOIN dtosyscat catLevel on op.opportunityLevelId = catLevel.sysCatId \
                LEFT JOIN dtoaccount ac ON op.accountId = ac.accountId \
                LEFT JOIN dtolead ld on op.leadId = ld.leadId \
                LEFT JOIN dtosyscat catType on op.type = catType.value and catType.sysCatTypeId = 9 \
        WHERE op.isActive = 1 "];
    
    NSMutableString *countQuery = [[NSMutableString alloc] initWithString:@"SELECT count(*) \
                              FROM  dtoopportunity op \
                              WHERE op.isActive = 1 "];
    
    if(![StringUtil stringIsEmpty:keyword])
    {
        [query appendString:[NSString stringWithFormat:@"AND (op.name like '%%%@%%'or op.code like '%%%@%%')  ",keyword,keyword]];
        [countQuery appendString:[NSString stringWithFormat:@"AND (op.name like '%%%@%%'or op.code like '%%%@%%')  ",keyword,keyword]];
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:@"yyyy-MM-dd"];
    if(startDate != nil)
    {
        [query appendString:[NSString stringWithFormat:@"AND op.startDate >= '%@' ",[NSString stringWithFormat:@"%@",[df stringFromDate:startDate]]]];
        [countQuery appendString:[NSString stringWithFormat:@"AND op.startDate >= '%@' ",[NSString stringWithFormat:@"%@",[df stringFromDate:startDate]]]];
    }
    if(endDate != nil)
    {
        [query appendString:[NSString stringWithFormat:@"AND op.endDate <= '%@' ",[NSString stringWithFormat:@"%@",[df stringFromDate:endDate]]]];
        [countQuery appendString:[NSString stringWithFormat:@"AND op.endDate <= '%@' ",[NSString stringWithFormat:@"%@",[df stringFromDate:endDate]]]];
    }
    if(type != 0)
    {
        if(type == 1) //Khachs hang 360
        {
            [query appendString:@"AND op.accountId is not null "];
            [countQuery appendString:@"AND op.accountId is not null "];
        }
        else if(type == 2) //Lead
        {
            [query appendString:@"AND op.leadId is not null "];
            [countQuery appendString:@"AND op.leadId is not null "];
        }
    }
    
    [query appendString:@"ORDER BY op.id DESC  "];
    *totalCount = [DataUtil getCountItemsselectQuery:countQuery valueParamemter:nil];
    query = [query stringByAppendingString:[NSString stringWithFormat:@" limit %d offset %d", limit,start ]];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

-(NSDictionary*) getById:(NSString*)itemId {
    
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOOPPORTUNITY_id,DTOOPPORTUNITY_clientOpportunityId,DTOOPPORTUNITY_name,DTOOPPORTUNITY_startDate,DTOOPPORTUNITY_endDateReal,DTOOPPORTUNITY_endDate
                         ,@"Level",@"NextTaskName",@"Type",@"StatusName",@"Customer",@"CustomerId",@"Description",@"ResultDescription",@"accountId",@"leadId",@"status",@"nextTask",@"opportunityLevelId",@"TypeCode",@"clientLeadId",nil];
    
    NSString *query = [NSString stringWithFormat: @"Select op.id,op.clientOpportunityId,op.name,startDate,endDateReal,endDate,catLevel.name as Level,catTask.name as NextTask,catType.name as Type,catStatus.name as Status \
                       ,case  \
                            when op.accountId is null then l.name  \
                            when op.leadId is null then ac.name \
                       end as Customer \
                       ,case \
                            when op.accountId is null then l.leadId \
                            when op.leadId is null then ac.accountId \
                       end as CustomerId,op.description as Description,op.resultDescription as ResultDescription \
                       ,op.accountId,op.leadId,op.status,op.nextTask,op.opportunityLevelId,op.type,op.clientLeadId \
                       from  dtoopportunity op \
                       left join dtoopportunitycontact opc on op.clientOpportunityId=opc.clientOpportunityContactId \
                       left join dtocontact con on opc.clientOpportunityContactId = con.clientContactId \
                       left join dtosyscat catLevel on op.opportunityLevelId = catLevel.sysCatId \
                       left join dtosyscat catTask on op.nextTask = catTask.sysCatId \
                       left join dtosyscat catStatus on op.status = catStatus.value and catStatus.sysCatTypeId = 10 \
                       left join dtosyscat catType on op.type = catType.value and catType.sysCatTypeId = 9 \
                       left join dtoaccount ac on op.accountId = ac.accountId \
                       left join dtolead l on op.leadId = l.leadId \
                       Where op.id = %@",itemId ];
    
    NSMutableArray *array = [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
    if(array != nil && array.count > 0)
    {
        return [array objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}
-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue{
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    listDic = [super getAllItemsWithTableName:TableName_DTOOPPORTUNTITY withFields:[self getAllFields] withConditionString:[NSString stringWithFormat:@" Where %@ = ?", inputKey] withParameter:[NSArray arrayWithObjects:inputValue, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        
        return [listDic objectAtIndex:0];
        
    }
    
    return nil;
}
-(NSInteger) getClientId {
    return [super getMaxClientIdWithTableName:TableName_DTOOPPORTUNTITY withField:DTOOPPORTUNITY_clientOpportunityId];
}
-(BOOL) deleteEntity:(NSString *)opportunityId{
    
    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOOPPORTUNITY_isActive, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:opportunityId, nil] forKeys:[NSArray arrayWithObjects:DTOOPPORTUNITY_id, nil]];
    
    
    return [super updateToTableName:TableName_DTOOPPORTUNTITY withFields:dicFieldSet withCondition:dicFieldCondition];
}

//lay danh sach co hoi cua khach hang 360
-(NSMutableArray*) filterWith360Id: (NSString*) strValue{
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOOPPORTUNITY_id, DTOOPPORTUNITY_clientOpportunityId, DTOCONTACT_fullName, DTOOPPORTUNITY_code, DTOOPPORTUNITY_name, DTOOPPORTUNITY_endDate, DTOOPPORTUNITY_startDate,@"StatusName", DTOOPPORTUNITY_status,@"Contact",@"ContactCode",@"Level", nil];
    
    NSString *query = [NSString stringWithFormat:@"SELECT op.id,op.clientOpportunityId,fullName,op.code,op.name,endDate,startDate \
                       ,catStatus.name as StatusName \
                       ,op.status \
                       ,case \
                       when op.accountId is null then ld.name \
                       when op.leadId is null then ac.name \
                       end as Contact \
                       ,case \
                       when op.accountId is null then ld.clientId \
                       when op.leadId is null then ac.clientAccountId \
                       end as ContactCode \
                       ,catLevel.name as Level \
                       FROM  dtoopportunity op \
                       LEFT JOIN dtoopportunitycontact opc ON op.clientOpportunityId=opc.clientOpportunityContactId \
                       LEFT JOIN dtocontact con ON opc.clientOpportunityContactId = con.clientContactId \
                       LEFT JOIN dtosyscat catStatus ON op.status = catStatus.value \
                       AND catStatus.sysCatTypeId = 10 \
                       LEFT JOIN dtosyscat catLevel on op.opportunityLevelId = catLevel.sysCatId \
                       LEFT JOIN dtoaccount ac ON op.accountId = ac.accountId \
                       LEFT JOIN dtolead ld on op.leadId = ld.leadId \
                    where op.accountid = ? order by op.%@ desc", DTOOPPORTUNITY_id];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
}

//lay danh sach co hoi cua khach hang tiem nang
-(NSMutableArray*) filterWithClienLeadId: (NSString*) strValue{
    NSArray *allFields =[NSArray arrayWithObjects:DTOOPPORTUNITY_id, DTOOPPORTUNITY_clientOpportunityId, DTOCONTACT_fullName, DTOOPPORTUNITY_code, DTOOPPORTUNITY_name, DTOOPPORTUNITY_endDate, DTOOPPORTUNITY_startDate,@"StatusName", DTOOPPORTUNITY_status,@"Contact",@"ContactCode",@"Level", nil];
    
    NSString *query = [NSString stringWithFormat:@"SELECT op.id,op.clientOpportunityId,fullName,op.code,op.name,endDate,startDate \
                       ,catStatus.name as StatusName \
                       ,op.status \
                       ,case \
                       when op.accountId is null then ld.name \
                       when op.leadId is null then ac.name \
                       end as Contact \
                       ,case \
                       when op.accountId is null then ld.clientId \
                       when op.leadId is null then ac.clientAccountId \
                       end as ContactCode \
                       ,catLevel.name as Level \
                       FROM  dtoopportunity op \
                       LEFT JOIN dtoopportunitycontact opc ON op.clientOpportunityId=opc.clientOpportunityContactId \
                       LEFT JOIN dtocontact con ON opc.clientOpportunityContactId = con.clientContactId \
                       LEFT JOIN dtosyscat catStatus ON op.status = catStatus.value \
                       AND catStatus.sysCatTypeId = 10 \
                       LEFT JOIN dtosyscat catLevel on op.opportunityLevelId = catLevel.sysCatId \
                       LEFT JOIN dtoaccount ac ON op.accountId = ac.accountId \
                       LEFT JOIN dtolead ld on op.leadId = ld.leadId \
                       where op.clientLeadId = ? order by op.%@ desc", DTOOPPORTUNITY_id];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
}
@end
