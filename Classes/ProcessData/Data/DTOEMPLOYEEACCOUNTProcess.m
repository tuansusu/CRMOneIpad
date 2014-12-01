//
//  DTOEMPLOYEEACCOUNT.m
//  OfficeOneStudy
//
//  Created by viettel on 10/30/14.
//
//

#import "DTOEMPLOYEEACCOUNTProcess.h"
#import <sqlite3.h>
#import "DataUtil.h"
#import "DataField.h"

#define TableName_DTOEMPLOYEEACCOUNT @"DTOEMPLOYEEACCOUNT"

@implementation DTOEMPLOYEEACCOUNTProcess


-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    return [super addToDBWithTableName:TableName_DTOEMPLOYEEACCOUNT dictionary:entity];
    
}
-(NSDictionary*) getObjectWithDataID : (NSString*) dataID {
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    
    BaseDataProcess *baseBussinessProcess = [[BaseDataProcess alloc]init];
    
    listDic =[baseBussinessProcess getAllItemsWithTableName:TableName_DTOEMPLOYEEACCOUNT withFields:[NSArray arrayWithObjects:DTOEMPLOYEEACCOUNT_leadId, DTOEMPLOYEEACCOUNT_id, nil] withConditionString:@"Where id = ?" withParameter:[NSArray arrayWithObjects:dataID, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        
        return [listDic objectAtIndex:0];
    }
    
    return nil;
}

-(NSMutableArray*) getAllItems{
    //NSMutableArray *listDic = nil;
    //NSArray *orderBy = [NSArray array];
    
    BaseDataProcess *baseBussinessProcess = [[BaseDataProcess alloc]init];
    
    return  [baseBussinessProcess getAllItemsWithTableName:TableName_DTOEMPLOYEEACCOUNT withFields:[NSArray arrayWithObjects:DTOEMPLOYEEACCOUNT_id, DTOEMPLOYEEACCOUNT_leadId, DTOEMPLOYEEACCOUNT_note, nil]];
    
//    listDic =[baseBussinessProcess getAllItemsWithTableName:TableName_DTOEMPLOYEEACCOUNT withFields:[NSArray arrayWithObjects:DTOEMPLOYEEACCOUNT_employeeAccountId, DTOEMPLOYEEACCOUNT_id, nil] withConditionString:@"Where id = ?" withParameter:[NSArray arrayWithObjects:dataID, nil] withOrderByFields:orderBy];
}

@end
