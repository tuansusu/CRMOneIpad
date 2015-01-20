//
//  DTOATTACHMENTProcess.m
//  OfficeOneMB
//
//  Created by viettel on 12/12/14.
//
//

#import "DTOATTACHMENTProcess.h"
#import "DataUtil.h"

#define TABLENAME_DTOATTACHMENT @"dtoattachment"

@implementation DTOATTACHMENTProcess


-(NSArray*) getAllFields {
    return  [NSArray arrayWithObjects: DTOATTACHMENT_attachmentId, // @"attachmentId" //BIGINT
             DTOATTACHMENT_checkSum , //checkSum" //SMALLINT
             DTOATTACHMENT_clientAttachmentId , //clientAttachmentId" //BIGINT
             DTOATTACHMENT_clientFilePath , //clientFilePath" //VARCHAR
             DTOATTACHMENT_createdBy , //createdBy" //BIGINT
             DTOATTACHMENT_createdDate , //createdDate" //VARCHAR
             DTOATTACHMENT_fileName , //fileName" //VARCHAR
             DTOATTACHMENT_isActive , //isActive" //SMALLINT
             DTOATTACHMENT_note , //note" //VARCHAR
             DTOATTACHMENT_objectId , //objectId" //BIGINT
             DTOATTACHMENT_objectType , //objectType" //VARCHAR
             DTOATTACHMENT_serverFilePath , //serverFilePath" //VARCHAR
             DTOATTACHMENT_updatedBy , //updatedBy" //BIGINT
             DTOATTACHMENT_updatedDate , //updatedDate" //VARCHAR
             DTOATTACHMENT_verifyLat , //verifyLat" //VARCHAR
             DTOATTACHMENT_verifyLon , //verifyLon" //VARCHAR
             DTOATTACHMENT_clientObjectId ,//
             DTOATTACHMENT_id, nil //id" //INTEGER
             ]; //id" //INTEGER]; //id" //INTEGER
    
}


-(BOOL) deleteEntity:(NSString *)attachmentId{
    
    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOATTACHMENT_isActive, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:attachmentId, nil] forKeys:[NSArray arrayWithObjects:DTOATTACHMENT_id, nil]];
    
    
    return [super updateToTableName:TABLENAME_DTOATTACHMENT withFields:dicFieldSet withCondition:dicFieldCondition];
}


-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSLog(@"Vao day roi");
    if ([[entity allKeys] containsObject:DTOATTACHMENT_id]) {
        NSLog(@"sua");
        return [self updateToDBWithEntity:entity];
    }
    NSLog(@"them moi %@:",entity);
    
    return [super addToDBWithTableName:TABLENAME_DTOATTACHMENT dictionary:entity];
    
}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOATTACHMENT_id] , DTOATTACHMENT_id, nil];
    
    return [super updateToTableName:TABLENAME_DTOATTACHMENT withFields:entity withCondition:dicCondition];
    
}

-(NSMutableArray*) filter{
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOATTACHMENT_id, DTOATTACHMENT_attachmentId, DTOATTACHMENT_checkSum, DTOATTACHMENT_clientAttachmentId, DTOATTACHMENT_clientFilePath, DTOATTACHMENT_createdBy, DTOATTACHMENT_fileName, DTOATTACHMENT_note, DTOATTACHMENT_objectId, DTOATTACHMENT_objectType, DTOATTACHMENT_serverFilePath, DTOATTACHMENT_verifyLat,DTOATTACHMENT_verifyLon, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isActive = 1 order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOATTACHMENT, DTOLEAD_updatedDate];
    
    NSLog(@"query attach:%@", query);
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}


-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue{
    NSArray *allFields =[NSArray arrayWithObjects:DTOATTACHMENT_id, DTOATTACHMENT_attachmentId, DTOATTACHMENT_checkSum, DTOATTACHMENT_clientAttachmentId, DTOATTACHMENT_clientFilePath, DTOATTACHMENT_createdBy, DTOATTACHMENT_fileName, DTOATTACHMENT_note, DTOATTACHMENT_objectId, DTOATTACHMENT_objectType, DTOATTACHMENT_serverFilePath, DTOATTACHMENT_verifyLat,DTOATTACHMENT_verifyLon, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isActive = 1 and %@  like ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOATTACHMENT, strKey, DTOATTACHMENT_updatedDate];
    
    NSLog(@"query = %@", query);
    NSString *value = @"%";
    value = [value stringByAppendingString:[strValue stringByAppendingString:@"%"]];
    
    NSLog(@"param = %@", value);
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:value, nil]];
    
    
}

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue{
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    listDic = [super getAllItemsWithTableName:TABLENAME_DTOATTACHMENT withFields:[self getAllFields] withConditionString:[NSString stringWithFormat:@" Where %@ = ?", inputKey] withParameter:[NSArray arrayWithObjects:inputValue, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        
        return [listDic objectAtIndex:0];
        
    }
    
    return nil;
}

-(NSInteger) getClientId {
    return [super getMaxClientIdWithTableName:TABLENAME_DTOATTACHMENT withField:DTOTASK_clientTaskId];
}

//filter with lay danh sach lien he cua 1 cai khach hang dau moi
//(ham nay chua tinh duoc)
-(NSMutableArray*) filterWithClientLeaderId: (NSString*) strValue{
    
   NSArray *allFields =[NSArray arrayWithObjects:DTOATTACHMENT_id, DTOATTACHMENT_attachmentId, DTOATTACHMENT_checkSum, DTOATTACHMENT_clientAttachmentId, DTOATTACHMENT_clientFilePath, DTOATTACHMENT_createdBy, DTOATTACHMENT_fileName, DTOATTACHMENT_note, DTOATTACHMENT_objectId, DTOATTACHMENT_objectType, DTOATTACHMENT_serverFilePath, DTOATTACHMENT_verifyLat,DTOATTACHMENT_verifyLon, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isActive = 1 and clientLeadId = ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOATTACHMENT, DTOLEAD_updatedDate];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
}

@end
