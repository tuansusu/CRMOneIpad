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
    return [super getMaxClientIdWithTableName:TABLENAME_DTOOPPORTUNITYCONTACT withField:DTOOPPORTUNITYCONTACT_clientOpportunityContactId];
}

@end
