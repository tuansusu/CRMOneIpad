//
//  DTOFLLOWUPProcess.m
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/21/14.
//
//

#import "DTOFLLOWUPProcess.h"
#import "DataUtil.h"
#import "DataField.h"

#define TABLENAME_FOLLOWUP @"dtoFollowup"

@implementation DTOFLLOWUPProcess

-(NSArray*) getAllFields {
    
    return  [NSArray arrayWithObjects:DTOFOLLOWUP_clientFollowUpId,DTOFOLLOWUP_createdBy,DTOFOLLOWUP_createdDate,DTOFOLLOWUP_employeeId,DTOFOLLOWUP_endDate,DTOFOLLOWUP_followUpId,DTOFOLLOWUP_followUpState,DTOFOLLOWUP_isEmail,DTOFOLLOWUP_isNotify,DTOFOLLOWUP_isReminder,   DTOFOLLOWUP_isSms,DTOFOLLOWUP_notifyDate,DTOFOLLOWUP_objectId,DTOFOLLOWUP_objectName,DTOFOLLOWUP_objectType,DTOFOLLOWUP_startDate,DTOFOLLOWUP_sysCatId,DTOFOLLOWUP_updatedBy,DTOFOLLOWUP_updatedDate,DTOFOLLOWUP_id,nil];
}


-(BOOL) deleteEntity:(NSString *)followid{
    
    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOFOLLOWUP_followUpState, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:followid, nil] forKeys:[NSArray arrayWithObjects:DTOFOLLOWUP_id, nil]];
    
    
    return [super updateToTableName:TABLENAME_FOLLOWUP withFields:dicFieldSet withCondition:dicFieldCondition];
}


-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    if ([[entity allKeys] containsObject:DTOFOLLOWUP_id]) {
        return [self updateToDBWithEntity:entity];
    }
    
    return [super addToDBWithTableName:TABLENAME_FOLLOWUP dictionary:entity];
    
}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOFOLLOWUP_id] , DTOFOLLOWUP_id, nil];
    
    return [super updateToTableName:TABLENAME_FOLLOWUP withFields:entity withCondition:dicCondition];
    
}

-(NSMutableArray*) filter{
    
    NSArray *allFields =[NSArray arrayWithObjects:DTONOTE_id, DTONOTE_content, DTONOTE_title, DTONOTE_noteId, DTONOTE_contentFormated, DTONOTE_createdDate, DTONOTE_updatedDate, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@  order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_FOLLOWUP, DTOFOLLOWUP_updatedDate];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}


-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue{
    NSArray *allFields =[NSArray arrayWithObjects:DTOFOLLOWUP_id, DTOFOLLOWUP_clientFollowUpId, DTOFOLLOWUP_createdBy, DTOFOLLOWUP_createdDate, DTOFOLLOWUP_employeeId, DTOFOLLOWUP_endDate,DTOFOLLOWUP_followUpId, DTOFOLLOWUP_followUpState,DTOFOLLOWUP_isEmail,DTOFOLLOWUP_isNotify,DTOFOLLOWUP_isReminder,DTOFOLLOWUP_isSms,DTOFOLLOWUP_notifyDate,DTOFOLLOWUP_objectId,DTOFOLLOWUP_objectName,DTOFOLLOWUP_objectType,DTOFOLLOWUP_startDate,DTOFOLLOWUP_sysCatId,DTOFOLLOWUP_updatedBy,DTOFOLLOWUP_updatedDate, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isactive = 1 and %@  like ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_FOLLOWUP, strKey, DTOFOLLOWUP_updatedDate];
    
    NSLog(@"query = %@", query);
    NSString *value = @"%";
    value = [value stringByAppendingString:[strValue stringByAppendingString:@"%"]];
    
    NSLog(@"param = %@", value);
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:value, nil]];
    
    
}

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue{
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    listDic = [super getAllItemsWithTableName:TABLENAME_FOLLOWUP withFields:[self getAllFields] withConditionString:[NSString stringWithFormat:@" Where  objecttype='LEAD' and %@ = ?", inputKey] withParameter:[NSArray arrayWithObjects:inputValue, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        
        return [listDic objectAtIndex:0];
        
    }
    
    return nil;
}
-(NSDictionary*) getDataAccountWithKey : (NSString*) inputKey withValue : (NSString*) inputValue{
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    listDic = [super getAllItemsWithTableName:TABLENAME_FOLLOWUP withFields:[self getAllFields] withConditionString:[NSString stringWithFormat:@" Where  objecttype='ACCOUNT' and %@ = ?", inputKey] withParameter:[NSArray arrayWithObjects:inputValue, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        
        return [listDic objectAtIndex:0];
        
    }
    
    return nil;
}
-(NSInteger) getClientId {
    return [super getMaxClientIdWithTableName:TABLENAME_FOLLOWUP withField:DTOFOLLOWUP_clientFollowUpId];
}

//filter with lay danh sach lien he cua 1 cai khach hang dau moi
-(NSMutableArray*) filterWithClientLeaderId:(NSString *)leadId objectType:(NSString *)type{
    NSArray *allFields =[NSArray arrayWithObjects:DTOFOLLOWUP_id, DTOFOLLOWUP_clientFollowUpId, DTOFOLLOWUP_createdBy, DTOFOLLOWUP_createdDate, DTOFOLLOWUP_employeeId, DTOFOLLOWUP_endDate,DTOFOLLOWUP_followUpId, DTOFOLLOWUP_followUpState,DTOFOLLOWUP_isEmail,DTOFOLLOWUP_isNotify,DTOFOLLOWUP_isReminder,DTOFOLLOWUP_isSms,DTOFOLLOWUP_notifyDate,DTOFOLLOWUP_objectId,DTOFOLLOWUP_objectName,DTOFOLLOWUP_objectType,DTOFOLLOWUP_startDate,DTOFOLLOWUP_sysCatId,DTOFOLLOWUP_updatedBy,DTOFOLLOWUP_updatedDate, nil];
    
    NSString *query = [NSString stringWithFormat:@"SELECT %@ FROM %@ where objectid = ? and objecttype=?  order by updatedDate  desc", [allFields componentsJoinedByString:@"," ], TABLENAME_FOLLOWUP];
    
    NSLog(@"query:%@",query);
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:leadId,type, nil]];
    
    
}
-(BOOL) checkFollowUp:(NSString *)leadId objectType:(NSString *)type{
    
    int count=0;
    NSString *query=[NSString stringWithFormat:@"SELECT objectid FROM dtofollowup where objectid=%@ and objecttype='%@'",leadId,type];
    BOOL check=NO;
    count=  [DataUtil getCountItemsselectQuery:query valueParamemter:nil];
    NSLog(@"leadId:%@",leadId);
    NSLog(@"query:%@",query);
    NSLog(@"count:%i",count);
    if (count>0) {
        check=YES;
    }
    return check;
}

@end
