//
//  DTOCONTACTProcess.m
//  OfficeOneStudy
//
//  Created by viettel on 10/31/14.
//
//

#import "DTOCONTACTProcess.h"
#import <sqlite3.h>
#import "DataUtil.h"



@implementation DTOCONTACTProcess

-(void) RenderDataField{
    
    sqlite3 *database = [DataUtil openDatabase];
    //lay danh sach tat ca table
    NSArray *arrayTableName = [DataUtil BuilQueryGetListWithListFields:[NSArray arrayWithObjects:@"name", nil] selectQuery:@"SELECT name FROM sqlite_master where type='table'" valueParameter:nil];
    for (NSDictionary *dicTable in arrayTableName) {
        [self DetailTable:[dicTable objectForKey:@"name"] withDatabase:database];
    }
    
    [DataUtil closeDatabase];
    
    //NSLog(@"table info = %@", arrayColumn);
    
}

-(void) DetailTable  : (NSString*) strTableName  withDatabase : (sqlite3*) database {
    
    [LogUtil writeLogWithContent:[NSString stringWithFormat:@"///%@  Field\n", strTableName]];
    
    strTableName =   [strTableName uppercaseString];
    NSString *query = [NSString stringWithFormat:@"PRAGMA table_info('%@')", strTableName] ;
    
    NSArray *allFields = [[NSArray alloc]initWithObjects:@"cid", @"name", @"type", nil];
    
    NSMutableArray *listDic = [[NSMutableArray alloc]init];
    
    @try {
        sqlite3_stmt *statement;
        NSMutableDictionary *dic;
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSInteger start = 0;
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                dic = [[NSMutableDictionary alloc]init];
                start = 0;
                for (NSString* field in allFields) {
                    if (sqlite3_column_text(statement, start) != NULL) {
                        NSString *value = [NSString stringWithUTF8String:( char *) sqlite3_column_text(statement, start)];
                        [dic setObject:value forKey:field];
                    }
                    start++;
                }
                [listDic addObject:dic];
            }
            sqlite3_finalize(statement);
        }
    }
    @catch (NSException *exception) {
        [LogUtil writeLogWithException:exception ];
    }
    
    
    //NSLog(@"table info = %@", listDic);
    //#define DTOCONTACT_accountId @"accountId"
    
    
    
    //NSMutableArray *arrayColumn = [NSMutableArray new];
    for (NSDictionary *dicField in listDic) {
        //        [arrayColumn addObject: [NSString stringWithFormat:@"#define DTOCONTACT_%@ @\"%@\" //%@",  [dicField objectForKey:@"name"], [dicField objectForKey:@"name"], [dicField objectForKey:@"type"]] ];
        [LogUtil writeLogWithContent:[NSString stringWithFormat:@"#define %@_%@ @\"%@\" //%@ \n",strTableName,  [dicField objectForKey:@"name"], [dicField objectForKey:@"name"], [dicField objectForKey:@"type"]]];
        
    }
}

@end
