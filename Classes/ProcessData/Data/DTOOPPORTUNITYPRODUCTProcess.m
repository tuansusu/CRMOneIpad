//
//  DTOOPPORTUNITYPRODUCTProcess.m
//  OfficeOneMB
//
//  Created by viettel on 12/25/14.
//
//

#import "DTOOPPORTUNITYPRODUCTProcess.h"
#import "DataUtil.h"
#import "DataField.h"

#define TABLENAME_DTOOPPORTUNITYPRODUCT @"dtoopportunityProduct"

@implementation DTOOPPORTUNITYPRODUCTProcess

-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    if ([[entity allKeys] containsObject:DTOOPPORTUNITYPRODUCT_id]) {
        return [self updateToDBWithEntity:entity];
    }
    return [super addToDBWithTableName:TABLENAME_DTOOPPORTUNITYPRODUCT dictionary:entity];
}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOOPPORTUNITYPRODUCT_id] , DTOOPPORTUNITYPRODUCT_id, nil];
    
    return [super updateToTableName:TABLENAME_DTOOPPORTUNITYPRODUCT withFields:entity withCondition:dicCondition];
    
}

-(NSInteger) getClientId {
    NSInteger *result;
    result = [super getMaxClientIdWithTableName:TABLENAME_DTOOPPORTUNITYPRODUCT withField:DTOOPPORTUNITYPRODUCT_clientOpportunityProductId];

    return  result;
}

-(NSMutableArray*) filterWithClientOpportunityId: (NSString*) strValue{
    NSArray *allFields =[NSArray arrayWithObjects:DTOOPPORTUNITYPRODUCT_id,DTOOPPORTUNITYPRODUCT_clientOpportunityProductId,DTOPRODUCTMASTER_name,DTOOPPORTUNITYPRODUCT_revenue, nil];
    
    NSString *query = [NSString stringWithFormat:@"select opp.id,opp.clientOpportunityProductId,pm.name,opp.revenue \
                       from dtoopportunity op \
                       inner join dtoopportunityproduct opp on op.clientOpportunityId = opp.clientOpportunityId \
                       inner join dtoproductmaster pm on pm.productMasterId = opp.productMasterId \
                       where op.clientOpportunityId = ? and opp.isActive = 1 \
                       order by opp.Id  desc"];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
    
    
}

-(NSMutableArray*) getById: (NSString*) strValue{
    NSArray *allFields =[NSArray arrayWithObjects:DTOOPPORTUNITYPRODUCT_id,DTOOPPORTUNITYPRODUCT_clientOpportunityProductId,DTOPRODUCTMASTER_name,DTOOPPORTUNITYPRODUCT_revenue,DTOOPPORTUNITYPRODUCT_productMasterId,DTOOPPORTUNITYPRODUCT_quantity,DTOOPPORTUNITYPRODUCT_currencyId,DTOOPPORTUNITY_clientOpportunityId,nil];
    
    NSString *query = [NSString stringWithFormat:@"select opp.id,opp.clientOpportunityProductId,pm.name,opp.revenue,opp.productMasterId,opp.quantity,opp.currencyId,op.clientOpportunityId \
                       from dtoopportunity op \
                       inner join dtoopportunityproduct opp on op.clientOpportunityId = opp.clientOpportunityId \
                       inner join dtoproductmaster pm on pm.productMasterId = opp.productMasterId \
                       where opp.id = ? \
                       and opp.isActive = 1 \
                       order by opp.Id  desc"];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
    
    
}
-(BOOL) deleteEntity:(NSString *)opportunityProductId{
    
    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOOPPORTUNITYPRODUCT_isActive, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:opportunityProductId, nil] forKeys:[NSArray arrayWithObjects:DTOOPPORTUNITYPRODUCT_id, nil]];
    
    
    return [super updateToTableName:TABLENAME_DTOOPPORTUNITYPRODUCT withFields:dicFieldSet withCondition:dicFieldCondition];
}

@end
