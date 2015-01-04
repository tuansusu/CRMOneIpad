//
//  DTOOPPORTUNITYCONTACTProcess.m
//  OfficeOneMB
//
//  Created by viettel on 12/17/14.
//
//



#import "DTOOPPORTUNITYCONTACTProcess.h"
#import "DataUtil.h"
#import "DataField.h"

#define TABLENAME_DTOOPPORTUNITYCONTACT @"dtoopportunitycontact"

@implementation DTOOPPORTUNITYCONTACTProcess

-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    if ([[entity allKeys] containsObject:DTOACCOUNTCONTACT_id]) {
        return [self updateToDBWithEntity:entity];
    }
    return [super addToDBWithTableName:TABLENAME_DTOOPPORTUNITYCONTACT dictionary:entity];
}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOOPPORTUNITYCONTACT_id] , DTOOPPORTUNITYCONTACT_id, nil];
    
    return [super updateToTableName:TABLENAME_DTOOPPORTUNITYCONTACT withFields:entity withCondition:dicCondition];
    
}

-(NSInteger) getClientId {
    NSInteger *result;
   
  //  @try {
        result = [super getMaxClientIdWithTableName:TABLENAME_DTOOPPORTUNITYCONTACT withField:DTOOPPORTUNITYCONTACT_clientOpportunityContactId];
//    }
//    @catch (NSException *exception) {
//        result = 1;
//        NSLog([NSString stringWithFormat:@"OpportunityContact:getClientId:Error:%@",exception]);
//    }
//    
    return  result;
}
-(BOOL) deleteEntity:(NSString *)opportunityContactId{
    
    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOOPPORTUNITYCONTACT_isActive, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:opportunityContactId, nil] forKeys:[NSArray arrayWithObjects:DTOOPPORTUNITYCONTACT_id, nil]];
    
    
    return [super updateToTableName:TABLENAME_DTOOPPORTUNITYCONTACT withFields:dicFieldSet withCondition:dicFieldCondition];
}


@end
