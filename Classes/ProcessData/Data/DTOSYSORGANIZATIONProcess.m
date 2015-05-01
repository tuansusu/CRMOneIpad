//
//  DTOSYSORGANIZATIONProcess.m
//  OfficeOneMB
//
//  Created by admin on 4/29/15.
//
//

#import "DTOSYSORGANIZATIONProcess.h"
#import "DataUtil.h"
#import "DataField.h"

#define TABLENAME_DTOSYSORGANIZATION @"dtosysorganization"

@implementation DTOSYSORGANIZATIONProcess



-(NSArray*) getAllFields{
    
    return  [NSArray arrayWithObjects:DTOSYSORGANIZATION_address, DTOSYSORGANIZATION_code, DTOSYSORGANIZATION_createdBy,DTOSYSORGANIZATION_createdDate, DTOSYSORGANIZATION_description, DTOSYSORGANIZATION_isActive, DTOSYSORGANIZATION_mnemomic, DTOSYSORGANIZATION_name, DTOSYSORGANIZATION_parentCode, DTOSYSORGANIZATION_parentId, DTOSYSORGANIZATION_status, DTOSYSORGANIZATION_sysOrganizationId,DTOSYSORGANIZATION_taxCode, DTOSYSORGANIZATION_type, DTOSYSORGANIZATION_updatedBy, DTOSYSORGANIZATION_updatedDate, nil];
}

-(void) synchonizeDatabase: (id) listData withActionEvent : (ActionEvent*) actionEvent{
    
    sqlite3 *database ;// = [DataUtil openDatabase];
    @try {
        
        NSArray *arrayDataSync = [listData objectForKey:@"sysOrganizationList"];
        
        
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
        
        NSString *queryListColumns = @"(";
        NSInteger start = 0;
        NSInteger countFields = [self getAllFields].count;
        
        
        for (NSString* fieldName in [self getAllFields]) {
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
        //kiem tra xem id
        
        NSString *query = [NSString stringWithFormat:@"insert or replace  INTO %@%@ VALUES %@", TABLENAME_DTOSYSORGANIZATION, queryListColumns,queryListPara];
        
        
        
        
        
        
        
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database,[ query UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK )
        {
            sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, &sErrMsg);
           
            for (int i=0; i<arrayDataSync.count; i++) {
                
                NSDictionary *entity = [arrayDataSync objectAtIndex:i];
                
                sqlite3_bind_text(compiledStatement, 1, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_address]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 2, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_code]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 3, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_createdBy]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 4, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_createdDate]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 5, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_description]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 6, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_isActive]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 7, [[NSString stringWithFormat:@"%@", @""] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 8, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_name]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 9, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_parentCode]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 10, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_parentId]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 11, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_status]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 12, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_sysOrganizationId]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 13, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_taxCode]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 14, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_type]] UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(compiledStatement, 15, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_updatedBy]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_bind_text(compiledStatement, 16, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOSYSORGANIZATION_updatedDate]] UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_step(compiledStatement) ;
                
                
                sqlite3_clear_bindings(compiledStatement);
                sqlite3_reset(compiledStatement);
            }
            
            sqlite3_exec(database, "END TRANSACTION", NULL, NULL, &sErrMsg);
        
        NSLog(@"Imported %d records m_kpi in %4ld seconds\n", arrayDataSync.count , (clock() - cStartClock));
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
