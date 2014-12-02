//
//  DTOACCCONTACTProcess.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/2/14.
//
//

#import "DTOACCCONTACTProcess.h"
#import "DataUtil.h"
#import "DataField.h"

#define TABLENAME_DTOACCCONTACT @"dtoaccountcontact"

@implementation DTOACCCONTACTProcess

-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    if ([[entity allKeys] containsObject:DTOACCOUNTCONTACT_id]) {
        return [self updateToDBWithEntity:entity];
    }
    return [super addToDBWithTableName:TABLENAME_DTOACCCONTACT dictionary:entity];
}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOACCOUNTCONTACT_id] , DTOACCOUNTCONTACT_id, nil];
    
    return [super updateToTableName:TABLENAME_DTOACCCONTACT withFields:entity withCondition:dicCondition];
    
}

-(NSInteger) getClientId {
    return [super getMaxClientIdWithTableName:TABLENAME_DTOACCCONTACT withField:DTOACCOUNTCONTACT_clientAccountContactId];
}

@end
