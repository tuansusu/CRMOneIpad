//
//  DataUtil.m
//  Voffice2.1
//
//  Created by VTIT on 7/31/13.
//
//

#import "DataUtil.h"
#import <Foundation/Foundation.h>
#import <sqlite3.h>

@implementation DataUtil

static sqlite3 *myDataBase = nil;
static NSString *lock = @"data lock";
+ (NSString*)databaseLock {
    return lock;
}
static BOOL checkInsertCache = NO;
//set ca insert vao bang cache
+(void) setCheckInsertedCache : (BOOL) checkInsert{
    @synchronized ([DataUtil databaseLock]) {
    checkInsertCache = checkInsert;
    }
}
//kiem tra xem da insert vao bang cach hay chua?
+(BOOL) getCheckInsertCache {
    @synchronized ([DataUtil databaseLock]) {
    return checkInsertCache;
    }
}




//ham mo database
+(sqlite3*)openDatabase {
    
        // Code that writes to an sqlite3 database goes here...
        if (myDataBase==nil) {
            NSString *filePath = [DataUtil getPathFileSqlLite];
            if (sqlite3_shutdown() == SQLITE_OK) {
                if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
                    sqlite3_initialize();
                    if(sqlite3_open([filePath UTF8String], &myDataBase) == SQLITE_OK) {
                        return myDataBase;
                    }
                }
            }
        }
        return  myDataBase;
    
}
//ham dong database
+(BOOL) closeDatabase{
    @try {
        sqlite3_close(myDataBase);
    }
    @catch (NSException *exception) {
        return NO;
    }
    
        return YES;
    
    
}


//Lay duong dan cua file sqlite
+(NSString*) getPathFileSqlLite{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    return path;
}
//Lay tong so item cua bang
+(NSInteger) getCountItemsByTableName : (NSString*) tableName{
    
    sqlite3 *database;
    NSInteger totalCount=0;
    
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
    
        NSString *query = [NSString stringWithFormat: @"select count(*) from %@",tableName];
        sqlite3_stmt *statement;
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil)==SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW) {
                totalCount = sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        }
    
    
    @try {
        sqlite3_close(database);
    }
    @catch (NSException *exception) {
        [LogUtil writeLogWithContent:@"khong close duoc db"];
    }
    
    
    return  totalCount;
}

+(BOOL) checkExistItem : (NSString*)tableName withKeyColumn : (NSString*) keyColumn withKeyValue : (NSString*) keyValue{
    @synchronized ([DataUtil databaseLock]) {
    sqlite3 *database;
    NSInteger totalCount=0;
    
    NSString *filePath = [DataUtil getPathFileSqlLite];
    if (sqlite3_shutdown() == SQLITE_OK) {
        if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
            sqlite3_initialize();
            if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
                
            }else{
                //khong mo duoc file database
                
                NSLog(@"khong mo fuoc file database");
                return NO;
            }
        }
    }
    
    NSString *query = [NSString stringWithFormat: @"select count(*) from %@ where %@=%@",tableName, keyColumn, keyValue];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil)==SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            totalCount = sqlite3_column_int(statement, 0);
        }
        sqlite3_finalize(statement);
    }
    
    
    @try {
        sqlite3_close(database);
    }
    @catch (NSException *exception) {
        [LogUtil writeLogWithContent:@"khong close duoc db"];
    }
    
    
    return  totalCount>0;
    }
}


+(NSInteger) getCountItemsselectQuery : (NSString*) query valueParamemter : (NSArray*) paramemters{
    
    sqlite3 *database;
    NSInteger totalCount=0;
    
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
    
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil)==SQLITE_OK){
        
        NSInteger start = 0;
        for (NSString* value in paramemters) {
            start ++;
            sqlite3_bind_text(statement, start, [value UTF8String], -1, SQLITE_TRANSIENT);
        }
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            totalCount = sqlite3_column_int(statement, 0);
        }
        sqlite3_finalize(statement);
    }
    
    @try {
        sqlite3_close(database);
    }
    @catch (NSException *exception) {
        [LogUtil writeLogWithContent:@"Khong close duoc db"];
    }
    
    return  totalCount;
    
}

//tu cau query - tra ve danh sach dictionary (key la cac fields) truyen vao
+(NSMutableArray*) BuilQueryGetListWithListFields : (NSArray*) allFields  selectQuery : (NSString*) query valueParameter : (NSArray*) parameters{
    
    NSMutableArray *listDic = [[NSMutableArray alloc]init];
    sqlite3 *database ;
    
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
        
            sqlite3_stmt *statement;
            NSMutableDictionary *dic;
            if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
               
               NSInteger start = 0;
                for (NSString* value in parameters) {
                    start ++;
                    sqlite3_bind_text(statement, start, [[NSString stringWithFormat:@"%@", value] UTF8String], -1, SQLITE_TRANSIENT);
                }
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
    }@finally {
        @try {
            sqlite3_close(database);
        }
        @catch (NSException *exception) {
            [LogUtil writeLogWithContent:@"khong close duoc db"];
        }
    }
    return listDic;
    
}

+(BOOL) exeQuery:(NSString *)query{
    sqlite3 *database;
    @try {
        
        //sqlite3 *database;
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
        sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database,[ query UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
		{
            if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
                return NO;
            } 
		}
		
		sqlite3_finalize(compiledStatement);
        
        
    }
    @catch (NSException *exception) {
        [LogUtil writeLogWithException:exception];
        return false;
    }@finally {
        @try {
            sqlite3_close(database);
        }
        @catch (NSException *exception) {
            [LogUtil writeLogWithContent:@"Khong close duoc db"];
        }
    }
    
    return  true;
}

+(BOOL) vacuumDatabase {
    
    return [DataUtil exeQuery:@"VACUUM"];
}


//////////RENDER DATA ///////
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
