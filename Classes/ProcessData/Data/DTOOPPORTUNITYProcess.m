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
-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    return [super addToDBWithTableName:TableName_DTOOPPORTUNTITY dictionary:entity];
    
}
-(NSMutableArray*) filterOpportunity:(NSString*)keyword addStartDate:(NSDate*)startDate addEndDate:(NSDate*)endDate userType:(NSString*)type{
    
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOOPPORTUNITY_id, DTOOPPORTUNITY_clientOpportunityId, DTOCONTACT_fullName, DTOOPPORTUNITY_code, DTOOPPORTUNITY_name, DTOOPPORTUNITY_endDate, DTOOPPORTUNITY_startDate,@"StatusName", DTOOPPORTUNITY_status,@"Account", nil];
    
    NSMutableString *query = [[NSMutableString alloc] initWithString:@"SELECT op.id,clientOpportunityId,fullName,op.code,op.name,endDate,startDate \
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
    if(type != nil)
    {
        if([type isEqualToString:@"1"]) //Khachs hang 360
        {
            [query appendString:@"AND op.accountId is not null "];
        }
        else if([type isEqualToString:@"2"])
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
    
    NSString *query = [NSString stringWithFormat: @"Select clientOpportunityId,fullName,op.code,op.name,endDate,startDate,catLevel.name as Level,catTask.name as NextTask,catStatus.name as Status,successPercent,ac.name as Account \
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

@end
