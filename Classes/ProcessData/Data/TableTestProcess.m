//
//  TableTestProcess.m
//  OfficeOneStudy
//
//  Created by viettel on 10/30/14.
//
//

#import "TableTestProcess.h"
#import <sqlite3.h>
#import "DataUtil.h"
#import "DataField.h"

#define Tablename_TableTest  @"TABLETEST"




@implementation TableTestProcess

-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    return [super addToDBWithTableName:Tablename_TableTest dictionary:entity];
    
}
-(NSDictionary*) getObjectWithDataID : (NSString*) dataID {
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    
    BaseDataProcess *baseBussinessProcess = [[BaseDataProcess alloc]init];
    //listDic = [DataBussinessUtil BuilQueryGetListWithListFields:[self getAllFields] selectQuery:query valueParameter:paramemters];
    listDic =[baseBussinessProcess getAllItemsWithTableName:Tablename_TableTest withFields:[NSArray arrayWithObjects:TABLETEST_ID, TABLETEST_TITLE, nil] withConditionString:@"Where ID = ?" withParameter:[NSArray arrayWithObjects:dataID, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        
        return [listDic objectAtIndex:0];
    }
    
    return nil;
}

@end
