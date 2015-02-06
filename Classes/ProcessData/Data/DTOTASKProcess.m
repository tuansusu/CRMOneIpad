//
//  DTOTASKProcess.m
//  OfficeOneMB
//
//  Created by viettel on 12/7/14.
//
//

#import "DTOTASKProcess.h"
#import "DataUtil.h"
#import "DataField.h"

#define TABLENAME_DTOTASK @"dtotask"

@implementation DTOTASKProcess

-(NSArray*) getAllFields {
    
    return  [NSArray arrayWithObjects:DTOTASK_accountId, //accountId" //BIGINT
             DTOTASK_campaignId, //campaignId" //BIGINT
             DTOTASK_clientId, //clientId" //BIGINT
             DTOTASK_clientTaskId, //clientTaskId" //BIGINT
             DTOTASK_code, //code" //VARCHAR
             DTOTASK_content, //content" //VARCHAR
             DTOTASK_createdBy, //createdBy" //BIGINT
             DTOTASK_createdDate, //createdDate" //VARCHAR
             DTOTASK_dayIndex, //dayIndex" //INTEGER
             DTOTASK_employeeCreated, //employeeCreated" //BIGINT
             DTOTASK_employeeId, //employeeId" //BIGINT
             DTOTASK_endDate, //endDate" //VARCHAR
             DTOTASK_formal, //formal" //INTEGER
DTOTASK_groupId, //groupId" //BIGINT
DTOTASK_hourIndex, //hourIndex" //INTEGER
DTOTASK_isActive, //isActive" //SMALLINT
DTOTASK_isChance, //isChance" //SMALLINT
DTOTASK_isEmail, //isEmail" //SMALLINT
DTOTASK_isException, //isException" //SMALLINT
DTOTASK_isMarkSendmail, //isMarkSendmail" //SMALLINT
DTOTASK_isNotification, //isNotification" //SMALLINT
DTOTASK_isPublic, //isPublic" //SMALLINT
DTOTASK_isRecurrence, //isRecurrence" //SMALLINT
DTOTASK_isReminder, //isReminder" //SMALLINT
DTOTASK_isRepeat, //isRepeat" //SMALLINT
DTOTASK_isSms, //isSms" //SMALLINT
DTOTASK_leadId, //leadId" //BIGINT
DTOTASK_location, //location" //VARCHAR
DTOTASK_masterId, //masterId" //BIGINT
DTOTASK_minuteIndex, //minuteIndex" //INTEGER
DTOTASK_opportunityId, //opportunityId" //BIGINT
DTOTASK_percentComplete, //percentComplete" //INTEGER
DTOTASK_productsMasterId, //productsMasterId" //BIGINT
DTOTASK_relationObject, //relationObject" //INTEGER
DTOTASK_reminderEmail, //reminderEmail" //SMALLINT
DTOTASK_reminderNofify, //reminderNofify" //SMALLINT
DTOTASK_reminderSMS, //reminderSMS" //SMALLINT
DTOTASK_reminderTime, //reminderTime" //BIGINT
DTOTASK_reminderUnit, //reminderUnit" //INTEGER
DTOTASK_repeatDuration, //repeatDuration" //INTEGER
DTOTASK_repeatMode, //repeatMode" //INTEGER
DTOTASK_repeatUntil, //repeatUntil" //VARCHAR
DTOTASK_repeatWeekFri, //repeatWeekFri" //SMALLINT
DTOTASK_repeatWeekMon, //repeatWeekMon" //SMALLINT
DTOTASK_repeatWeekSat, //repeatWeekSat" //SMALLINT
DTOTASK_repeatWeekSun, //repeatWeekSun" //SMALLINT
DTOTASK_repeatWeekThu, //repeatWeekThu" //SMALLINT
DTOTASK_repeatWeekTue, //repeatWeekTue" //SMALLINT
DTOTASK_repeatWeekWed, //repeatWeekWed" //SMALLINT
DTOTASK_rpMonthDayOfWeek, //rpMonthDayOfWeek" //INTEGER
DTOTASK_rpMonthFirstDay, //rpMonthFirstDay" //INTEGER
DTOTASK_rpMonthIndexDay, //rpMonthIndexDay" //INTEGER
DTOTASK_rpMonthRdFirstDay, //rpMonthRdFirstDay" //SMALLINT
DTOTASK_rpMonthRdIndexDay, //rpMonthRdIndexDay" //SMALLINT
DTOTASK_startDate, //startDate" //VARCHAR
DTOTASK_taskId, //taskId" //BIGINT
DTOTASK_taskPriority, //taskPriority" //BIGINT
DTOTASK_taskStatus, //taskStatus" //INTEGER
DTOTASK_title, //title" //VARCHAR
DTOTASK_typeTask, //typeTask" //INTEGER
DTOTASK_updatedBy, //updatedBy" //BIGINT
DTOTASK_updatedDate, //updatedDate" //VARCHAR
             DTOTASK_id,nil]; //id" //INTEGER]; //id" //INTEGER

}


-(BOOL) deleteEntity:(NSString *)contactId{
    
    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOTASK_isActive, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:contactId, nil] forKeys:[NSArray arrayWithObjects:DTOTASK_id, nil]];
    
    
    return [super updateToTableName:TABLENAME_DTOTASK withFields:dicFieldSet withCondition:dicFieldCondition];
}


-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    if ([[entity allKeys] containsObject:DTOTASK_id]) {
        return [self updateToDBWithEntity:entity];
    }
    
    return [super addToDBWithTableName:TABLENAME_DTOTASK dictionary:entity];
    
}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOTASK_id] , DTOTASK_id, nil];
    
    return [super updateToTableName:TABLENAME_DTOTASK withFields:entity withCondition:dicCondition];
    
}

-(NSMutableArray*) filter{

    NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate,DTOTASK_taskStatus, nil];

    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isActive = 1 order by %@ asc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, DTOLEAD_updatedDate];

    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

-(NSMutableArray*) filterTheNewestRecord{
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isActive = 1 order by %@ desc limit 1",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, DTOLEAD_updatedDate];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}


-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue{
   NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate,DTOTASK_taskStatus, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isActive = 1 and %@  like ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, strKey, DTOTASK_updatedDate];
    
    NSLog(@"query = %@", query);
    NSString *value = @"%";
    value = [value stringByAppendingString:[strValue stringByAppendingString:@"%"]];
    
    NSLog(@"param = %@", value);
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:value, nil]];
    
    
}

-(NSMutableArray*) filterTaskWithAccountId:(NSString*)accountId WithKey : (NSString*) strKey withValue : (NSString*) strValue{
    NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate,DTOTASK_taskStatus, nil];

    NSString *query;
    if (([strValue isEqualToString:@""] || !strValue) && ![accountId isEqualToString:@""]) {
        query = [NSString stringWithFormat:@"Select %@ from %@ where accountId=%@ and isActive = 1 and typeTask = 1 order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK,accountId, DTOTASK_updatedDate];
    }else{
        query= [NSString stringWithFormat:@"Select %@ from %@ where isActive = 1 and typeTask = 1 and %@  like '%%%@%%' order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, strKey,strValue, DTOTASK_updatedDate];
    }
        return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue{
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    listDic = [super getAllItemsWithTableName:TABLENAME_DTOTASK withFields:[self getAllFields] withConditionString:[NSString stringWithFormat:@" Where %@ = ?", inputKey] withParameter:[NSArray arrayWithObjects:inputValue, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        
        return [listDic objectAtIndex:0];
        
    }
    
    return nil;
}

-(NSInteger) getClientId {
    return [super getMaxClientIdWithTableName:TABLENAME_DTOTASK withField:DTOTASK_clientTaskId];
}

//filter with lay danh sach lien he cua 1 cai khach hang dau moi
//-(NSMutableArray*) filterWithClientLeaderId: (NSString*) strValue{
//    
//    NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate,DTOTASK_taskStatus, nil];
//    
//    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isActive = 1 and clientLeadId = ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, DTOLEAD_updatedDate];
//    
//    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
//}

- (NSMutableArray *) filterCalendarWithClientLeaderId: (NSString *) strValue
{
    NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate,DTOTASK_taskStatus, nil];

    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where typeTask = 0 and isActive = 1 and clientLeadId = ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, DTOLEAD_updatedDate];

    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
}

- (NSMutableArray *) filterTaskWithClientLeaderId: (NSString *) strValue
{
    NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate,DTOTASK_taskStatus, nil];

    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where typeTask = 1 and isActive = 1 and clientLeadId = ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, DTOLEAD_updatedDate];

    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
}

- (NSMutableArray *) filterCalendarWithAccountId: (NSString *) strValue
{
    NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate,DTOTASK_taskStatus, nil];

    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where typeTask = 0 and isActive = 1 and accountId = ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, DTOLEAD_updatedDate];

    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
}

- (NSMutableArray *) filterTaskWithClientOpportunityId: (NSString *) strValue
{
    NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate,DTOTASK_taskStatus, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where typeTask = 0 and isActive = 1 and clientOpportunityId = ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, DTOLEAD_updatedDate];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
}

- (NSMutableArray *) filterTaskWithAccountId: (NSString *) strValue
{
    NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate,DTOTASK_taskStatus, nil];

    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where typeTask = 1 and isActive = 1 and accountId = ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, DTOLEAD_updatedDate];

    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
}

- (NSMutableArray*) filterAllTask{
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate, DTOTASK_taskStatus, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where typeTask = 1 and isActive = 1 order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, DTOLEAD_updatedDate];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}
//lay danh sach cong viec cua khach hang 360
-(NSMutableArray*) filterWith360Id: (NSString*) strValue{
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOTASK_id, DTOTASK_code, DTOTASK_clientTaskId, DTOTASK_clientLeadId, DTOTASK_content, DTOTASK_title, DTOTASK_typeTask, DTOTASK_startDate, DTOTASK_percentComplete, DTOTASK_location, DTOTASK_leadId, DTOTASK_content,DTOTASK_taskPriority, DTOTASK_taskId, DTOTASK_endDate,DTOTASK_taskStatus, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isActive = 1 and accountid = ? order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOTASK, DTOLEAD_updatedDate];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:[NSArray arrayWithObjects:strValue, nil]];
}
@end
