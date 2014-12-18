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
-(NSMutableArray*) filterOpportunity:(NSString*)keyword addStartDate:(NSDate*)startDate addEndDate:(NSDate*)endDate userType:(int)type{
    
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOOPPORTUNITY_id, DTOOPPORTUNITY_clientOpportunityId, DTOCONTACT_fullName, DTOOPPORTUNITY_code, DTOOPPORTUNITY_name, DTOOPPORTUNITY_endDate, DTOOPPORTUNITY_startDate,@"StatusName", DTOOPPORTUNITY_status,@"Account", nil];
    
    NSMutableString *query = [[NSMutableString alloc] initWithString:@"SELECT op.id,op.clientOpportunityId,fullName,op.code,op.name,endDate,startDate \
                        ,catStatus.name as StatusName \
                        ,op.status \
                        ,case \
                            when op.accountId is null then ld.name \
                            when op.leadId is null then ac.name \
                        end as Account \
                FROM  dtoopportunity op \
                LEFT JOIN dtoopportunitycontact opc ON op.clientOpportunityId=opc.clientOpportunityContactId \
                LEFT JOIN dtocontact con ON opc.clientOpportunityContactId = con.clientContactId \
                LEFT JOIN dtosyscat catStatus ON op.status = catStatus.value \
                        AND catStatus.sysCatTypeId = 10 \
                LEFT JOIN dtoaccount ac ON op.accountId = ac.accountId \
                LEFT JOIN dtolead ld on op.leadId = ld.leadId \
        WHERE op.isActive = 1 "];
    
    if(![StringUtil stringIsEmpty:keyword])
    {
        [query appendString:[NSString stringWithFormat:@"AND op.name like '%%%@%%' ",keyword]];
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:@"yyyy-MM-dd"];
    if(startDate != nil)
    {
        [query appendString:[NSString stringWithFormat:@"AND op.startDate >= '%@' ",[NSString stringWithFormat:@"%@",[df stringFromDate:startDate]]]];
    }
    if(endDate != nil)
    {
        [query appendString:[NSString stringWithFormat:@"AND op.endDate <= '%@' ",[NSString stringWithFormat:@"%@",[df stringFromDate:endDate]]]];
    }
    if(type != 0)
    {
        if(type == 1) //Khachs hang 360
        {
            [query appendString:@"AND op.accountId is not null "];
        }
        else if(type == 2)
        {
            [query appendString:@"AND op.leadId is not null "];
        }
    }
    
    [query appendString:@"ORDER BY op.id DESC"];
    
      return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

-(NSDictionary*) getById:(NSString*)itemId {
    
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOOPPORTUNITY_clientOpportunityId, DTOCONTACT_fullName, DTOOPPORTUNITY_code, DTOOPPORTUNITY_name, DTOOPPORTUNITY_endDate, DTOOPPORTUNITY_startDate
                         ,@"Level",@"NextTask",@"Status",DTOOPPORTUNITY_successPercent,@"Account", nil];
    
    NSString *query = [NSString stringWithFormat: @"Select op.clientOpportunityId,fullName,op.code,op.name,endDate,startDate,catLevel.name as Level,catTask.name as NextTask,catStatus.name as Status,successPercent,ac.name as Account \
                       from  dtoopportunity op \
                       left join dtoopportunitycontact opc on op.clientOpportunityId=opc.clientOpportunityContactId \
                       left join dtocontact con on opc.clientOpportunityContactId = con.clientContactId \
                       left join dtosyscat catLevel on op.opportunityLevelId = catLevel.sysCatId \
                       left join dtosyscat catTask on op.nextTask = catTask.sysCatId \
                       left join dtosyscat catStatus on op.status = catStatus.value and catStatus.sysCatTypeId = 10 \
                       left join dtoaccount ac on op.accountId = ac.accountId \
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

@end
