//
//  DTOComplainProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import "DTOComplainProcess.h"

#import "DTOComplainObject.h"
#import "DataUtil.h"

#define TABLENAME_DTOCOMPLAIN @"dtocomplain"

@implementation DTOComplainProcess

-(NSMutableArray*) filterWithLeadId:(NSString*)leadId{
    NSString *query = @"";
    if ([leadId isEqualToString:@""]) {
        query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 order by %@ asc",[[DTOComplainObject allFields] componentsJoinedByString:@"," ] ,TABLENAME_DTOCOMPLAIN,DTOCOMPLAIN_fromReceived];
    }else{
        query = [NSString stringWithFormat:@"Select %@ from %@ where accountId=%@ and  status = 1 order by %@ asc",[[DTOComplainObject allFields] componentsJoinedByString:@"," ] ,TABLENAME_DTOCOMPLAIN,leadId,DTOCOMPLAIN_fromReceived];
    }

    return [DataUtil BuilQueryGetListWithListFields:[DTOComplainObject allFields] selectQuery:query valueParameter:nil];
}

-(NSMutableArray*) filterWithLeadId:(NSString*)leadId WithKey : (NSString*) strKey withValue : (NSString*) strValue {
    NSString *query = @"";
    if ([leadId isEqualToString:@""]) {
        query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 and %@  like ? order by %@ desc",[[DTOComplainObject allFields] componentsJoinedByString:@"," ] , TABLENAME_DTOCOMPLAIN, strKey, DTOCOMPLAIN_fromReceived];
    }else{
        query = [NSString stringWithFormat:@"Select %@ from %@ where accountId=%@ and status = 1 and %@  like ? order by %@ desc",[[DTOComplainObject allFields] componentsJoinedByString:@"," ] , TABLENAME_DTOCOMPLAIN,leadId, strKey, DTOCOMPLAIN_fromReceived];
    }
    NSLog(@"query = %@", query);
    NSString *value = @"%";
    value = [value stringByAppendingString:[strValue stringByAppendingString:@"%"]];

    NSLog(@"param = %@", value);
    return [DataUtil BuilQueryGetListWithListFields:[DTOComplainObject allFields] selectQuery:query valueParameter:[NSArray arrayWithObjects:value, nil]];
}

-(NSMutableArray*) filterWithLimitRecord:(int)limitRecord{

    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 order by %@ desc limit %d",[[DTOComplainObject allFields] componentsJoinedByString:@"," ] , TABLENAME_DTOCOMPLAIN, DTOCOMPLAIN_fromReceived,limitRecord];

    return [DataUtil BuilQueryGetListWithListFields:[DTOComplainObject allFields] selectQuery:query valueParameter:nil];
}

-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{

    if ([[entity allKeys] containsObject:DTOCOMPLAIN_casesId]) {
        return [self updateToDBWithEntity:entity];
    }

    return [super addToDBWithTableName:TABLENAME_DTOCOMPLAIN dictionary:entity];

}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{

    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOCOMPLAIN_casesId] , DTOCOMPLAIN_casesId, nil];

    return [super updateToTableName:TABLENAME_DTOCOMPLAIN withFields:entity withCondition:dicCondition];

}

-(BOOL) deleteEntityWithCasesId:(NSString *)casesId{


    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOCOMPLAIN_status, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:casesId, nil] forKeys:[NSArray arrayWithObjects:DTOCOMPLAIN_casesId, nil]];


    return [super updateToTableName:TABLENAME_DTOCOMPLAIN withFields:dicFieldSet withCondition:dicFieldCondition];
}

@end
