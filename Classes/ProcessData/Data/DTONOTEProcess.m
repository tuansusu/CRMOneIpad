//
//  DTONOTEProcess.m
//  OfficeOneMB
//
//  Created by viettel on 12/8/14.
//
//

#import "DTONOTEProcess.h"

#import "DataUtil.h"
#import "DataField.h"

#define TABLENAME_DTONOTE @"dtonote"

@implementation DTONOTEProcess



-(NSArray*) getAllFields {
    
    return  [NSArray arrayWithObjects: DTONOTE_accountId , //accountId" //BIGINT
 DTONOTE_campaignId , //campaignId" //BIGINT
 DTONOTE_clientNoteId , //clientNoteId" //BIGINT
 DTONOTE_content , //content" //VARCHAR
 DTONOTE_contentFormated , //contentFormated" //BLOB
 DTONOTE_createdBy , //createdBy" //BIGINT
 DTONOTE_createdDate , //createdDate" //VARCHAR
 DTONOTE_employeeId , //employeeId" //BIGINT
 DTONOTE_isActive , //isActive" //SMALLINT
 DTONOTE_leadId , //leadId" //BIGINT
 DTONOTE_noteId , //noteId" //BIGINT
 DTONOTE_opportunityId , //opportunityId" //BIGINT
 DTONOTE_title , //title" //VARCHAR
 DTONOTE_updatedBy , //updatedBy" //BIGINT
 DTONOTE_updatedDate , //updatedDate" //VARCHAR
 DTONOTE_id, nil  //id" //INTEGER
             ]; //id" //INTEGER
}


-(BOOL) deleteEntity:(NSString *)contactId{
    
    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTONOTE_isActive, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:contactId, nil] forKeys:[NSArray arrayWithObjects:DTONOTE_id, nil]];
    
    
    return [super updateToTableName:TABLENAME_DTONOTE withFields:dicFieldSet withCondition:dicFieldCondition];
}


-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    if ([[entity allKeys] containsObject:DTONOTE_id]) {
        return [self updateToDBWithEntity:entity];
    }
    
    return [super addToDBWithTableName:TABLENAME_DTONOTE dictionary:entity];
    
}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTONOTE_id] , DTONOTE_id, nil];
    
    return [super updateToTableName:TABLENAME_DTONOTE withFields:entity withCondition:dicCondition];
    
}

-(NSMutableArray*) filter{
    
    NSArray *allFields =[NSArray arrayWithObjects:DTONOTE_id, DTONOTE_content, DTONOTE_title, DTONOTE_noteId, DTONOTE_contentFormated, DTONOTE_createdDate, DTONOTE_updatedDate, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isActive = 1 order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTONOTE, DTONOTE_updatedDate];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}


-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue{
   NSArray *allFields =[NSArray arrayWithObjects:DTONOTE_id, DTONOTE_content, DTONOTE_title, DTONOTE_noteId, DTONOTE_contentFormated, DTONOTE_createdDate, DTONOTE_updatedDate, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 and %@  like ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTONOTE, strKey, DTOLEAD_updatedDate];
    
    NSLog(@"query = %@", query);
    NSString *value = @"%";
    value = [value stringByAppendingString:[strValue stringByAppendingString:@"%"]];
    
    NSLog(@"param = %@", value);
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:value, nil]];
    
    
}

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue{
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    listDic = [super getAllItemsWithTableName:TABLENAME_DTONOTE withFields:[self getAllFields] withConditionString:[NSString stringWithFormat:@" Where %@ = ?", inputKey] withParameter:[NSArray arrayWithObjects:inputValue, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        
        return [listDic objectAtIndex:0];
        
    }
    
    return nil;
}

-(NSInteger) getClientId {
    return [super getMaxClientIdWithTableName:TABLENAME_DTONOTE withField:DTONOTE_clientNoteId];
}

//filter with lay danh sach lien he cua 1 cai khach hang dau moi
-(NSMutableArray*) filterWithClientLeaderId: (NSString*) strValue{
     NSArray *allFields =[NSArray arrayWithObjects:DTONOTE_id, DTONOTE_content, DTONOTE_title, DTONOTE_noteId, DTONOTE_contentFormated, DTONOTE_createdDate, DTONOTE_updatedDate, nil];
    
    NSString *query = [NSString stringWithFormat:@"SELECT %@ FROM %@ where clientLeadId = ? order by dtoaccountcontact.updatedDate  desc", [allFields componentsJoinedByString:@"," ], TABLENAME_DTONOTE];
    
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
    
    
}


@end
