//
//  SyncDataUtil.m
//  OfficeOneMB
//
//  Created by admin on 5/1/15.
//
//

#import "SyncDataUtil.h"
#import "DataUtil.h"
//remove
#import "DataField.h"

@implementation SyncDataUtil

-(void) synchonizeDatabase: (NSArray*) arrayDataSync withActionEvent : (ActionEvent*) actionEvent withTableName : (NSString *) tabelName withKeyColumn : (NSString*) keyColumn withArrayColumn : (NSArray*) arrayAllColumn{
    
    sqlite3 *database ;// = [DataUtil openDatabase];
    @try {
        
        char *sErrMsg = "";
        clock_t  cStartClock = clock();
        NSString *filePath = [DataUtil getPathFileSqlLite];
        if (sqlite3_shutdown() == SQLITE_OK) {
            if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
                sqlite3_initialize();
                if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
                    
                }
            }
        }
        if (database==nil) {
            NSLog(@"kpi data database nil");
            return;
        }
        
        NSDictionary *dicFirstEntity = [arrayDataSync objectAtIndex:0];
        NSArray *arrayColumnInService = [dicFirstEntity allKeys];
        
        NSMutableArray *arrayColumnField = [NSMutableArray new];
        for (NSString *fieldNameInService in arrayColumnInService) {
            if ([arrayAllColumn containsObject:fieldNameInService]) {
                [arrayColumnField addObject:fieldNameInService];
            }
        }
        
        
        NSString *queryListColumns = @"(";
        NSInteger start = 0;
        NSInteger countFields = arrayColumnField.count;
        
        for (NSInteger i=0; i<countFields; i++) {
            start = i +1;
            
            NSString *fieldName = [arrayColumnField objectAtIndex:i];
            
            if (start != countFields) {
                queryListColumns = [queryListColumns stringByAppendingString:[NSString stringWithFormat:@"%@,",fieldName]];
            }else{
                queryListColumns = [queryListColumns stringByAppendingString:[NSString stringWithFormat:@"%@)", fieldName]];
            }
            
        }
        
        NSString *queryListPara = @"(";
        for (NSInteger i=0; i<countFields; i++) {
            if (i+1<countFields) {
                queryListPara = [queryListPara stringByAppendingString:@"?,"];
            }else{
                queryListPara = [queryListPara stringByAppendingString:@"?)"];
            }
        }
        NSString *query = [NSString stringWithFormat:@"insert  INTO %@%@ VALUES %@", tabelName, queryListColumns,queryListPara];
        
        
        //sinh ra cau update csdl
        
        
        
        NSString *queryUpdate = [NSString stringWithFormat:@"update %@ set ", tabelName];
        
        for (NSInteger i=0; i<countFields; i++) {
            NSString *fieldName = [arrayColumnField objectAtIndex:i];
            if (i==0) {
                queryUpdate = [queryUpdate stringByAppendingFormat:@"%@=? ", fieldName];
            }else{
                queryUpdate = [queryUpdate stringByAppendingFormat:@", %@=? ", fieldName];
            }
        }
        
        queryUpdate = [queryUpdate stringByAppendingFormat:@" where %@=?", keyColumn];
        
        
        NSMutableArray *arrayUpdate = [NSMutableArray new];
        NSMutableArray *arrayInsert = [NSMutableArray new];
        
        for (int i=0; i<arrayDataSync.count; i++) {
            NSDictionary *entity = [arrayDataSync objectAtIndex:i];
            
            //kiem tra xem dtoaccountid  da ton tai trong csdl hay chua?
            BOOL checkExist = [DataUtil checkExistItem:tabelName withKeyColumn:keyColumn withKeyValue:[entity objectForKey:keyColumn]];
            
            if (checkExist==NO) {
                //truong hop them moi
                [arrayInsert addObject:entity];
            }else{
                //truong hop sua
                [arrayUpdate addObject:entity];
            }
        }
        
        
        sqlite3_stmt *compiledStatement;
        
        
        //insert vao csdl
        if (arrayInsert.count>0) {
            if(sqlite3_prepare_v2(database,[ query UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK )
            {
                sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, &sErrMsg);
                
                for (int i=0; i<arrayInsert.count; i++) {
                    
                    NSDictionary *entity = [arrayInsert objectAtIndex:i];
                    
                    int columnIndex = 0;
                    
                    for (NSInteger i=0; i<countFields; i++) {
                        columnIndex ++;
                        
                        NSString *keyField = [arrayColumnField objectAtIndex:i];
                        if ([[entity allKeys] containsObject:keyField]) {
                            
                            sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", [entity objectForKey:keyField]] UTF8String], -1, SQLITE_TRANSIENT);
                        }else{
                            sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", @""] UTF8String], -1, SQLITE_TRANSIENT);
                        }
                    }
                    
                    
                    
                    sqlite3_step(compiledStatement) ;
                    
                    
                    sqlite3_clear_bindings(compiledStatement);
                    sqlite3_reset(compiledStatement);
                }
                
                sqlite3_exec(database, "END TRANSACTION", NULL, NULL, &sErrMsg);
                
                NSLog(@"Imported %d records m_kpi in %4ld seconds\n", arrayDataSync.count , (clock() - cStartClock));
            }  //end of if(sqlite3_prepare_v2
            else{
                NSLog(@"end of if(sqlite3_prepare_v2 none");
            }
        }
        
        //update vao csdl
        if (arrayUpdate.count>0) {
            
            if(sqlite3_prepare_v2(database,[ queryUpdate UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK )
            {
                sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, &sErrMsg);
                
                for (int i=0; i<arrayUpdate.count; i++) {
                    
                    NSDictionary *entity = [arrayUpdate objectAtIndex:i];
                    
                    int columnIndex = 0;
                    
                    for (NSInteger i=0; i<countFields; i++) {
                        columnIndex ++;
                        
                        NSString *keyField = [arrayColumnField objectAtIndex:i];
                        if ([[entity allKeys] containsObject:keyField]) {
                            
                            sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", [entity objectForKey:keyField]] UTF8String], -1, SQLITE_TRANSIENT);
                        }else{
                            sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", @""] UTF8String], -1, SQLITE_TRANSIENT);
                        }
                    }
                    
                    //
                    columnIndex++;
                    sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", [entity objectForKey:keyColumn]] UTF8String], -1, SQLITE_TRANSIENT);
                    
                    sqlite3_step(compiledStatement) ;
                    
                    
                    sqlite3_clear_bindings(compiledStatement);
                    sqlite3_reset(compiledStatement);
                }
                
                sqlite3_exec(database, "END TRANSACTION", NULL, NULL, &sErrMsg);
                
                NSLog(@"Imported %d records m_kpi in %4ld seconds\n", arrayDataSync.count , (clock() - cStartClock));
            }  //end of if(sqlite3_prepare_v2
            
        }
        
        
        
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"M_KPI DATA - Exception : %@", exception.description);
    }
    @finally {
        sqlite3_close(database);
    }
    
}

@end
