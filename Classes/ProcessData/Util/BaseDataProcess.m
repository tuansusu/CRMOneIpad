//
//  BaseDataProcess.m
//  Voffice2.1
//
//  Created by VTIT on 7/31/13.
//
//
#import <Foundation/Foundation.h>
#import <sqlite3.h>
//#import "sqlite3.h"
#import "BaseDataProcess.h"
#import "DataUtil.h"
#import "OrderByObject.h"

@implementation BaseDataProcess

//Them hoac sua vao CSDL - 
-(BOOL) addToDBWithTableName:(NSString*) tableName dictionary : (NSMutableDictionary*) dic{
    
    sqlite3 *database;
    @try {
        
        //database = [DataUtil openDatabase];
        
        NSString *filePath = [DataUtil getPathFileSqlLite];
        
        if (sqlite3_shutdown() == SQLITE_OK) {
            if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
                sqlite3_initialize();
                if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
                    NSLog(@"open ok");
                }else{
                    NSLog(@"not open db");
                    return NO;
                }
            }
        }
        
        NSString *queryListColumns = @"(";
        NSInteger start = 0;
        NSInteger countFields = dic.allKeys.count;
        
        for (NSString* fieldName in dic.allKeys) {
            start = start +1;
            
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
        
        NSString *query = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@%@ VALUES %@", tableName, queryListColumns,queryListPara];
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database,[ query UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
		{
            start = 0;
            for (NSString* fieldName in dic.allKeys) {
                start ++;
                sqlite3_bind_text(compiledStatement, start, [[dic valueForKey:fieldName] UTF8String], -1, SQLITE_TRANSIENT);
            }
            
		}
		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
            return NO;
		}
		sqlite3_finalize(compiledStatement);
        sqlite3_close(database);
    }
    @catch (NSException *exception) {
        
        return NO;
    }
    return YES;
    }


//Them vao CSDL - chi them vao csdl
-(BOOL) addPureToDBWithTableName:(NSString*) tableName dictionary : (NSMutableDictionary*) dic{
    sqlite3 *database;
    @try {
        //sqlite3 *database;
        //database = [DataUtil openDatabase];
        NSString *filePath = [DataUtil getPathFileSqlLite];
        if (sqlite3_shutdown() == SQLITE_OK) {
            if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
                sqlite3_initialize();
                if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
                    
                }else{
                    //khong mo duoc file database
                    NSLog(@"khong mo fuoc file database");
                }
            }
        }
        
        NSString *queryListColumns = @"(";
        NSInteger start = 0;
        NSInteger countFields = dic.allKeys.count;
        
        for (NSString* fieldName in dic.allKeys) {
            start = start +1;
            
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
        
        NSString *query = [NSString stringWithFormat:@"INSERT INTO %@%@ VALUES %@", tableName, queryListColumns,queryListPara];
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database,[ query UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
		{
            start = 0;
            for (NSString* fieldName in dic.allKeys) {
                start ++;
                sqlite3_bind_text(compiledStatement, start, [[dic valueForKey:fieldName] UTF8String], -1, SQLITE_TRANSIENT);
            }
            
		}
		if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
            return NO;
		}
		sqlite3_finalize(compiledStatement);
    }
    @catch (NSException *exception) {
        return NO;
    }@finally {
        @try {
            sqlite3_close(database);
        }
        @catch (NSException *exception) {
            
        }
        
    }
    
        return YES;
    
}


-(BOOL) checkExistObjectWithTableName: (NSString*) tableName dictionaryKeys : (NSMutableDictionary*) dicKeys{
    
     NSInteger totalCount=0;
    sqlite3 *database;
    @try {
        
        NSString *filePath = [DataUtil getPathFileSqlLite];
        if (sqlite3_shutdown() == SQLITE_OK) {
            if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
                sqlite3_initialize();
                if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
                    
                }else{
                    //khong mo duoc file database
                    NSLog(@"khong mo fuoc file database");
                }
            }
        }
            
            NSString *buildWhere = @"";
            NSInteger start=0;
            for (NSString *field in dicKeys.allKeys) {
                if (start==0) {
                    buildWhere = [buildWhere stringByAppendingString:[NSString stringWithFormat:@" %@=?", field]];
                }else{
                    buildWhere = [buildWhere stringByAppendingString:[NSString stringWithFormat:@" and %@=?", field]];
                }
                
            }
            
            NSString *query = [NSString stringWithFormat:@"Select count(*) from %@", tableName];
            if (dicKeys.allKeys.count>0) {
                query = [query stringByAppendingString:[NSString stringWithFormat:@" where %@", buildWhere]];
            }
            
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
                start = 0;
                for (NSString* fieldName in dicKeys.allKeys) {
                    start ++;
                    sqlite3_bind_text(statement, start, [[dicKeys valueForKey:fieldName] UTF8String], -1, SQLITE_TRANSIENT);
                }
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    totalCount = sqlite3_column_int(statement, 0);
                }
                sqlite3_finalize(statement);
            }
            
       
        
    }
    @catch (NSException *exception) {
        [LogUtil writeLogWithException:exception];
    }@finally {
        @try {
            sqlite3_close(database);
        }
        @catch (NSException *exception) {
            
        }
        
    }
    
   
    return totalCount>0;
}

//getAllItemsWithTableName

-(NSMutableArray*) getAllItemsWithTableName : (NSString*) tableName withFields: (NSArray*) allFields{
    return  [self getAllItemsWithTableNameAndCondition:tableName withFields:allFields withCondition:@""];
}

-(NSMutableArray*) getAllItemsWithTableNameAndCondition : (NSString*) tableName withFields: (NSArray*) allFields withCondition : (NSString*) condition{
    NSMutableArray *listDic = [[NSMutableArray alloc]init];
    sqlite3 *database;
    @try {
        

        NSString *filePath = [DataUtil getPathFileSqlLite];
        if (sqlite3_shutdown() == SQLITE_OK) {
            if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
                sqlite3_initialize();
                if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
                    
                }else{
                    //khong mo duoc file database
                    NSLog(@"khong mo fuoc file database");
                }
            }
        }
        
            
            NSString *query = [NSString stringWithFormat:@"Select %@ from %@",[allFields componentsJoinedByString:@"," ] ,tableName];
            
            query = [query stringByAppendingString:condition];
            
            sqlite3_stmt *statement;
            NSMutableDictionary *dic;
            if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
                
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    dic = [[NSMutableDictionary alloc]init];
                    NSInteger start = 0;
                    for (NSString* field in allFields) {
                        if (sqlite3_column_text(statement, start) != NULL) {
                            // NSString *field = [[self getAllFields] objectAtIndex:start];
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
        [LogUtil writeLogWithException:exception];
    }@finally {
        @try {
            sqlite3_close(database);
        }
        @catch (NSException *exception) {
            
        }
        
    }
    
    return listDic;
}


-(NSMutableArray*) getAllItemsWithTableName : (NSString*) tableName withFields: (NSArray*) allFields withOrderBy : (NSArray*) orderByFields{
    
    NSMutableArray *listDic = [[NSMutableArray alloc]init];
    sqlite3 *database;
    @try {
        
    //sqlite3 *database=[DataUtil openDatabase];
        NSString *filePath = [DataUtil getPathFileSqlLite];
        if (sqlite3_shutdown() == SQLITE_OK) {
            if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
                sqlite3_initialize();
                if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
                    
                }else{
                    //khong mo duoc file database
                    NSLog(@"khong mo fuoc file database");
                }
            }
        }
    
            
            NSString *query = [NSString stringWithFormat:@"Select %@ from %@",[allFields componentsJoinedByString:@","] ,tableName];
            
           
            if (orderByFields!=nil && orderByFields.count>0) {
              //Cai dictionary
            //   NSMutable
                //them cai orderby
                
                    NSString *orderQuery = @" order by ";
                    NSInteger count = 0;
                    for (OrderByObject *object in orderByFields) {
                        count ++;
                        if (count<orderByFields.count) {
                            orderQuery = [orderQuery stringByAppendingString:[NSString stringWithFormat:@" %@ %@,", object.fieldName, object.typeOrder]];
                        }else{
                            orderQuery = [orderQuery stringByAppendingString:[NSString stringWithFormat:@" %@ %@", object.fieldName, object.typeOrder]];
                        }
                    }//end of for
                    query = [query stringByAppendingString:orderQuery];
                    
                
            }
            
            sqlite3_stmt *statement;
            NSMutableDictionary *dic;
            if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
                
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    dic = [[NSMutableDictionary alloc]init];
                    NSInteger start = 0;
                    if (allFields.count==1) {
                         NSString *value = [NSString stringWithUTF8String:( char *) sqlite3_column_text(statement, start)];
                        [listDic addObject:value];
                    }else{
                    
                    for (NSString* field in allFields) {
                        if (sqlite3_column_text(statement, start) != NULL) {
                            // NSString *field = [[self getAllFields] objectAtIndex:start];
                            NSString *value = [NSString stringWithUTF8String:( char *) sqlite3_column_text(statement, start)];
                            [dic setObject:value forKey:field];
                            
                        }
                        start++;
                    }
                    [listDic addObject:dic];
                    } //end of else
                }
                sqlite3_finalize(statement);
            }
        
    }
    @catch (NSException *exception) {
        [LogUtil writeLogWithException:exception];
    }@finally {
        @try {
            sqlite3_close(database);
        }
        @catch (NSException *exception) {
            
        }
        
    }
    
    return listDic;
}


-(NSMutableArray*) getAllItemsWithTableName : (NSString*) tableName withFields: (NSArray*) allFields withConditionString : (NSString*) condition withParameter: (NSArray*) parameters withOrderByFields: (NSArray*) orderFields{
    
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@",[allFields componentsJoinedByString:@"," ] ,tableName];
    
    query = [query stringByAppendingString:[NSString stringWithFormat:@" %@",condition]];
    
    //them cai orderby
    if (orderFields!=nil && orderFields.count>0) {
        NSString *orderQuery = @" order by ";
        NSInteger count = 0;
        for (OrderByObject *object in orderFields) {
            count ++;
            if (count<orderFields.count) {
               orderQuery = [orderQuery stringByAppendingString:[NSString stringWithFormat:@" %@ %@,", object.fieldName, object.typeOrder]];
            }else{
                orderQuery = [orderQuery stringByAppendingString:[NSString stringWithFormat:@" %@ %@", object.fieldName, object.typeOrder]];
            }
        }//end of for
        query = [query stringByAppendingString:orderQuery];
        
    }
    
    NSMutableArray *listDic = [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:parameters];
    return listDic;
}


-(NSMutableArray*) getAllItemsWithTableName : (NSString*) tableName withFields: (NSArray*) allFields withConditionString : (NSString*) condition withParameter: (NSArray*) parameters withOrderByFields: (NSArray*) orderFields withCurpage : (NSInteger) curPage withItemsPerpage : (NSInteger) limit{
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@",[allFields componentsJoinedByString:@"," ] ,tableName];
    
    query = [query stringByAppendingString:[NSString stringWithFormat:@" %@",condition]];
    
    //them cai orderby
    if (orderFields!=nil && orderFields.count>0) {
        NSString *orderQuery = @" order by ";
        NSInteger count = 0;
        for (OrderByObject *object in orderFields) {
            count ++;
            if (count<orderFields.count) {
                orderQuery = [orderQuery stringByAppendingString:[NSString stringWithFormat:@" %@ %@,", object.fieldName, object.typeOrder]];
            }else{
                orderQuery = [orderQuery stringByAppendingString:[NSString stringWithFormat:@" %@ %@", object.fieldName, object.typeOrder]];
            }
        }//end of for
        query = [query stringByAppendingString:orderQuery];
        
    }
    
    query = [query stringByAppendingString:[NSString stringWithFormat:@" limit %d offset %d", limit,curPage ]];
 
    
    
    NSMutableArray *listDic = [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:parameters];
    return listDic;
    
}

-(BOOL) updateToTableName : (NSString*) tableName withFields: (NSMutableDictionary*) fieldsConditions withCondition : (NSDictionary*) condition
{
    sqlite3 *database;
    @try {
       
        //sqlite3 *database=[DataUtil openDatabase];
        NSString *filePath = [DataUtil getPathFileSqlLite];
        if (sqlite3_shutdown() == SQLITE_OK) {
            if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
                sqlite3_initialize();
                if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
                    
                }else{
                    //khong mo duoc file database
                    NSLog(@"khong mo fuoc file database");
                }
            }
        }
        
            
            NSString *query = [NSString stringWithFormat:@"Update %@ SET", tableName];
            
            
           // NSString *buildWhere = @"";
            NSInteger start=0;
            for (NSString *field in fieldsConditions.allKeys) {
                start++;
                    if (start<fieldsConditions.allKeys.count) {
                        query = [query stringByAppendingString:[NSString stringWithFormat:@" %@=?,", field]];
                    }else{
                        query = [query stringByAppendingString:[NSString stringWithFormat:@"  %@=?", field]];
                    }
            }
            
            query = [query stringByAppendingString:[NSString stringWithFormat:@" Where %@=?", [condition.allKeys objectAtIndex:0]]];
            
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
                //gan tham so
                start = 0;
                for (NSString* fieldName in fieldsConditions.allKeys) {
                    start ++;
                    sqlite3_bind_text(statement, start, [[fieldsConditions valueForKey:fieldName] UTF8String], -1, SQLITE_TRANSIENT);
                }
                start++;
                sqlite3_bind_text(statement, start, [[condition valueForKey:[condition.allKeys objectAtIndex:0]] UTF8String], -1, SQLITE_TRANSIENT);
                
                if(sqlite3_step(statement) != SQLITE_DONE ) {
                    return NO;
                } 

                sqlite3_finalize(statement);
            }
        
        
    }
    @catch (NSException *exception) {
        [LogUtil writeLogWithException:exception];
    }@finally {
        @try {
            sqlite3_close(database);
        }
        @catch (NSException *exception) {
            
        }
        
    }
    
    return YES;
}

-(NSInteger) getMaxClientIdWithTableName : (NSString*) tableName withField : (NSString*) fieldName{
    @try {
        
        OrderByObject *orderBy = [OrderByObject new];
        orderBy.fieldName = fieldName;
        orderBy.typeOrder = order_desc;
        
       NSArray *arrayResult =  [self getAllItemsWithTableName:tableName withFields:[NSArray arrayWithObjects:fieldName, nil] withOrderBy:[NSArray arrayWithObjects:orderBy, nil] ];
        
        if (arrayResult!=nil && arrayResult.count>0) {
            NSInteger result = [[arrayResult objectAtIndex:0] integerValue] + 1;
            return result;
        }
        
    }
    @catch (NSException *exception) {
        return 1;
    }
    return 1;
}

@end
