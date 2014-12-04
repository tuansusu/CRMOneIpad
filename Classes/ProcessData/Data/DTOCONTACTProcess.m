//
//  DTOCONTACTProcess.m
//  OfficeOneStudy
//
//  Created by viettel on 10/31/14.
//
//

#import "DTOCONTACTProcess.h"
#import "DataUtil.h"
#import "DataField.h"

#define TABLENAME_DTOCONTACT @"dtocontact"

@implementation DTOCONTACTProcess



-(NSArray*) getAllFields {
    return  [NSArray arrayWithObjects:DTOCONTACT_accountId,// @"accountId" //BIGINT
             DTOCONTACT_address, //address" //VARCHAR
             DTOCONTACT_birthday, //birthday" //VARCHAR
             DTOCONTACT_clientContactId, //clientContactId" //BIGINT
             DTOCONTACT_clientId, //clientId" //BIGINT
             DTOCONTACT_contactId, //contactId" //BIGINT
             DTOCONTACT_email, //email" //VARCHAR
             DTOCONTACT_employeeId, //employeeId" //BIGINT
             DTOCONTACT_favoriteLevel, //favoriteLevel" //INTEGER
             DTOCONTACT_fullName, //fullName" //VARCHAR
             DTOCONTACT_identifiedIssueArea, //identifiedIssueArea" //VARCHAR
             DTOCONTACT_identifiedIssueDate, //identifiedIssueDate" //VARCHAR
             DTOCONTACT_identifiedNumber, //identifiedNumber" //VARCHAR
             DTOCONTACT_isActive, //isActive" //INTEGER
             DTOCONTACT_leadId, //leadId" //BIGINT
             DTOCONTACT_mobile, //mobile" //VARCHAR
             DTOCONTACT_organizationId, //organizationId" //BIGINT
             DTOCONTACT_passport, //passport" //VARCHAR
             DTOCONTACT_phone, //phone" //VARCHAR
             DTOCONTACT_position, //position" //VARCHAR
             DTOCONTACT_roleDescription, //roleDescription" //VARCHAR
             DTOCONTACT_sex, //sex" //VARCHAR
             DTOCONTACT_updatedDate, //updatedDate" //VARCHAR
             DTOCONTACT_id]; //id" //INTEGER
}


-(BOOL) deleteEntity:(NSString *)contactId{
    
    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOCONTACT_isActive, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:contactId, nil] forKeys:[NSArray arrayWithObjects:DTOCONTACT_id, nil]];
    
    
    return [super updateToTableName:TABLENAME_DTOCONTACT withFields:dicFieldSet withCondition:dicFieldCondition];
}


-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    if ([[entity allKeys] containsObject:DTOCONTACT_id]) {
        return [self updateToDBWithEntity:entity];
    }
    
    return [super addToDBWithTableName:TABLENAME_DTOCONTACT dictionary:entity];
    
}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOCONTACT_id] , DTOCONTACT_id, nil];
    
    return [super updateToTableName:TABLENAME_DTOCONTACT withFields:entity withCondition:dicCondition];
    
}

-(NSMutableArray*) filter{

    NSArray *allFields =[NSArray arrayWithObjects:DTOCONTACT_id, DTOCONTACT_fullName, DTOCONTACT_address, DTOCONTACT_birthday, DTOCONTACT_mobile, DTOCONTACT_position, DTOCONTACT_clientContactId, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isActive = 1 order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOCONTACT, DTOLEAD_updatedDate];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}


-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue{
    NSArray *allFields =[NSArray arrayWithObjects:DTOCONTACT_id, DTOCONTACT_fullName, DTOCONTACT_address, DTOCONTACT_birthday, DTOCONTACT_mobile, DTOCONTACT_position, DTOCONTACT_clientContactId, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 and %@  like ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOCONTACT, strKey, DTOLEAD_updatedDate];
    
    NSLog(@"query = %@", query);
    NSString *value = @"%";
    value = [value stringByAppendingString:[strValue stringByAppendingString:@"%"]];
    
    NSLog(@"param = %@", value);
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:value, nil]];
    
    
}

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue{
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    listDic = [super getAllItemsWithTableName:TABLENAME_DTOCONTACT withFields:[self getAllFields] withConditionString:[NSString stringWithFormat:@" Where %@ = ?", inputKey] withParameter:[NSArray arrayWithObjects:inputValue, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        
        return [listDic objectAtIndex:0];
        
    }
    
    return nil;
}

-(NSInteger) getClientId {
    return [super getMaxClientIdWithTableName:TABLENAME_DTOCONTACT withField:DTOCONTACT_clientContactId];
}

//filter with lay danh sach lien he cua 1 cai khach hang dau moi
-(NSMutableArray*) filterWithClientLeaderId: (NSString*) strValue{
    NSArray *allFields =[NSArray arrayWithObjects:DTOCONTACT_id, DTOCONTACT_fullName, DTOCONTACT_address, DTOCONTACT_birthday, DTOCONTACT_mobile, DTOCONTACT_position, DTOCONTACT_clientContactId, nil];
    
    NSString *query = [NSString stringWithFormat:@"SELECT dtocontact.id,fullName,address,birthday,mobile,position,clientContactId FROM dtoaccountcontact inner join dtocontact on clientAccountId = clientContactId where clientLeadId = ? order by dtoaccountcontact.updatedDate  desc"];
    
   
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
    
    
}


@end