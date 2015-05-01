//
//  DTOACCOUNTProcess.m
//  OfficeOneStudy
//
//  Created by viettel on 11/11/14.
//
//

#import "DTOACCOUNTProcess.h"
#import "DataUtil.h"

//remove
#import "DataField.h"

#define TABLENAME_DTOACCOUNT @"dtoaccount"

@implementation DTOACCOUNTProcess


-(NSArray*) getAllFields {
    
    return  [NSArray arrayWithObjects: DTOACCOUNT_accountId ,//accountId" //BIGINT -- accountId
 DTOACCOUNT_accountLevel ,//accountLevel" //VARCHAR  --  clientAccountId
 DTOACCOUNT_accountType ,//accountType" //VARCHAR
 DTOACCOUNT_activityStatus ,//activityStatus" //BIGINT
 DTOACCOUNT_address ,//address" //VARCHAR
 DTOACCOUNT_areaId ,//areaId" //BIGINT
 DTOACCOUNT_assetTotal ,//assetTotal" //VARCHAR
 DTOACCOUNT_birthday ,//birthday" //VARCHAR
 DTOACCOUNT_branchCode ,//branchCode" //VARCHAR
 DTOACCOUNT_charter ,//charter" //VARCHAR
 DTOACCOUNT_clientAccountId ,//clientAccountId" //BIGINT
 DTOACCOUNT_clientId ,//clientId" //BIGINT
 DTOACCOUNT_code ,//code" //VARCHAR   --- code
 DTOACCOUNT_createdBy ,//createdBy" //BIGINT
 DTOACCOUNT_createdDate ,//createdDate" //VARCHAR
 DTOACCOUNT_disableEmail ,//disableEmail" //SMALLINT
 DTOACCOUNT_disableMeeting ,//disableMeeting" //SMALLINT
 DTOACCOUNT_disablePhone ,//disablePhone" //SMALLINT
 DTOACCOUNT_disableSms ,//disableSms" //SMALLINT
 DTOACCOUNT_email ,//email" //VARCHAR
 DTOACCOUNT_employeeCode ,//employeeCode" //VARCHAR
 DTOACCOUNT_employeeNumber ,//employeeNumber" //VARCHAR
 DTOACCOUNT_familyIncome ,//familyIncome" //VARCHAR
 DTOACCOUNT_fax ,//fax" //VARCHAR
 DTOACCOUNT_identifiedIssueArea ,//identifiedIssueArea" //VARCHAR
 DTOACCOUNT_identifiedIssueDate ,//identifiedIssueDate" //VARCHAR
 DTOACCOUNT_identifiedNumber ,//identifiedNumber" //VARCHAR
 DTOACCOUNT_industryBusiness ,//industryBusiness" //VARCHAR
 DTOACCOUNT_isActive ,//isActive" //SMALLINT
 DTOACCOUNT_languageId ,//languageId" //BIGINT
 DTOACCOUNT_lastTransaction ,//lastTransaction" //VARCHAR
 DTOACCOUNT_lat ,//lat" //VARCHAR
 DTOACCOUNT_lon ,//lon" //VARCHAR
 DTOACCOUNT_marialStatus ,//marialStatus" //SMALLINT
 DTOACCOUNT_mnemonic ,//mnemonic" //VARCHAR  -- mnemonic
 DTOACCOUNT_mobile ,//mobile" //VARCHAR
 DTOACCOUNT_name ,//name" //VARCHAR   --- name
 DTOACCOUNT_openCodeDate ,//openCodeDate" //VARCHAR
 DTOACCOUNT_orgType ,//orgType" //BIGINT
 DTOACCOUNT_ownerEmployeeId ,//ownerEmployeeId" //BIGINT
 DTOACCOUNT_personalIncome ,//personalIncome" //VARCHAR
 DTOACCOUNT_personalIndustry ,//personalIndustry" //VARCHAR
 DTOACCOUNT_phone ,//phone" //VARCHAR
 DTOACCOUNT_registrationAddress ,//registrationAddress" //VARCHAR
 DTOACCOUNT_registrationDate ,//registrationDate" //VARCHAR
 DTOACCOUNT_registrationNumber ,//registrationNumber" //VARCHAR
 DTOACCOUNT_revenue ,//revenue" //VARCHAR
 DTOACCOUNT_sector ,//sector" //VARCHAR  --- sector
 DTOACCOUNT_setupDate ,//setupDate" //VARCHAR
 DTOACCOUNT_sex ,//sex" //VARCHAR  --  sex
 DTOACCOUNT_shareholderNumber ,//shareholderNumber" //BIGINT
 DTOACCOUNT_status ,//status" //INTEGER
 DTOACCOUNT_swiftCode ,//swiftCode" //VARCHAR
 DTOACCOUNT_sysOrganizationId ,//sysOrganizationId" //BIGINT
 DTOACCOUNT_taxCode ,//taxCode" //VARCHAR
 DTOACCOUNT_taxIssuedDate ,//taxIssuedDate" //VARCHAR
 DTOACCOUNT_updatedBy ,//updatedBy" //BIGINT
 DTOACCOUNT_updatedDate ,//updatedDate" //VARCHAR
 DTOACCOUNT_website ,//website" //VARCHAR
 DTOACCOUNT_id , nil];//id" //INTEGER
              //id" //INTEGER, nil]
    
    
}


-(BOOL) deleteEntity:(NSString *)leadId{
    
    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOACCOUNT_status, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:leadId, nil] forKeys:[NSArray arrayWithObjects:DTOACCOUNT_id, nil]];
    
    
    return [super updateToTableName:TABLENAME_DTOACCOUNT withFields:dicFieldSet withCondition:dicFieldCondition];
}


-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{
    
    if ([[entity allKeys] containsObject:DTOACCOUNT_id]) {
        return [self updateToDBWithEntity:entity];
    }
    
    return [super addToDBWithTableName:TABLENAME_DTOACCOUNT dictionary:entity];
    
}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{
    
    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOACCOUNT_id] , DTOACCOUNT_id, nil];
    
    return [super updateToTableName:TABLENAME_DTOACCOUNT withFields:entity withCondition:dicCondition];
    
}

-(NSMutableArray*) filter{

    
    NSArray *allFields =[NSArray arrayWithObjects:DTOACCOUNT_accountId, DTOACCOUNT_address, DTOACCOUNT_email, DTOACCOUNT_mobile, DTOACCOUNT_name,DTOACCOUNT_updatedBy,DTOACCOUNT_code, DTOACCOUNT_accountType,DTOACCOUNT_clientAccountId, DTOACCOUNT_lat, DTOACCOUNT_lon, DTOACCOUNT_id, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOACCOUNT, DTOACCOUNT_updatedDate];
    NSLog(@"query123:%@",query);
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}


-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue{

    NSArray *allFields =[NSArray arrayWithObjects:DTOACCOUNT_accountId, DTOACCOUNT_address, DTOACCOUNT_email, DTOACCOUNT_mobile, DTOACCOUNT_name,DTOACCOUNT_updatedBy,DTOACCOUNT_code, DTOACCOUNT_accountType,DTOACCOUNT_clientAccountId, DTOACCOUNT_lat, DTOACCOUNT_lon, DTOACCOUNT_id, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 and %@  like '%%%@%%' order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOACCOUNT, strKey,strValue,DTOACCOUNT_updatedDate];
    
       return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
    
    
}

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue{
    NSMutableArray *listDic = nil;
    NSArray *orderBy = [NSArray array];
    listDic = [super getAllItemsWithTableName:TABLENAME_DTOACCOUNT withFields:[self getAllFields] withConditionString:[NSString stringWithFormat:@" Where %@ = ?", inputKey] withParameter:[NSArray arrayWithObjects:inputValue, nil] withOrderByFields:orderBy];
    
    if (listDic.count>0) {
        return [listDic objectAtIndex:0];
    }
    
    return nil;
}

-(NSInteger) getClientId {
    return [super getMaxClientIdWithTableName:TABLENAME_DTOACCOUNT withField:DTOACCOUNT_clientAccountId];
}




-(NSMutableArray*) filterWithArrayCondition : (NSDictionary *) dicCondition{
    NSArray *allFields =[NSArray arrayWithObjects:DTOACCOUNT_accountId, DTOACCOUNT_address, DTOACCOUNT_email, DTOACCOUNT_mobile, DTOACCOUNT_name,DTOACCOUNT_updatedBy,DTOACCOUNT_code, DTOACCOUNT_accountType,DTOACCOUNT_clientAccountId, DTOACCOUNT_lat, DTOACCOUNT_lon, DTOACCOUNT_id, nil];
    
    
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 ",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOACCOUNT];
    
    NSMutableArray *arrayValue = [[NSMutableArray alloc]init];
    
    for (NSString *strKey in dicCondition.allKeys) {
        if ([StringUtil stringIsEmpty:[dicCondition objectForKey:strKey]]) {
            continue;
        }
        
        query = [query stringByAppendingString:[NSString stringWithFormat:@" and %@ like ?", strKey]];
        
        NSString *value = @"%";
        value = [value stringByAppendingString:[[dicCondition objectForKey:strKey] stringByAppendingString:@"%"]];
        [arrayValue addObject:value];
        
    }
    
    
    query = [query stringByAppendingString:[NSString stringWithFormat:@" order by %@ desc", DTOACCOUNT_updatedDate]];
    
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:arrayValue];
    
}

/*
 *Ham tim kiem theo nhieu dieu kien or
 */
/*
 *Ham tim kiem theo nhieu dieu kien or (phan trang)
 */
-(NSMutableArray*) filterWithOrArrayCondition : (NSDictionary *) dicCondition withStart : (int) start withLimit : (int) limit withOutTotal : (int*) totalCount{
    
       NSArray *allFields =[NSArray arrayWithObjects:DTOACCOUNT_accountId, DTOACCOUNT_address, DTOACCOUNT_email, DTOACCOUNT_mobile, DTOACCOUNT_name,DTOACCOUNT_updatedBy,DTOACCOUNT_code, DTOACCOUNT_accountType,DTOACCOUNT_clientAccountId, DTOACCOUNT_lat, DTOACCOUNT_lon, DTOACCOUNT_id, nil];
    
    
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 ",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOACCOUNT];
    
    NSMutableArray *arrayValue = [[NSMutableArray alloc]init];
    
    BOOL isCheckCondition = NO;
    
    for (NSString *strKey in dicCondition.allKeys) {
        if ([StringUtil stringIsEmpty:[dicCondition objectForKey:strKey]]) {
            continue;
        }
        
        if (isCheckCondition==NO) {
            query = [query stringByAppendingString:@" and ( "];
            isCheckCondition = YES;
            query = [query stringByAppendingString:[NSString stringWithFormat:@" %@ like ?", strKey]];
        }else{
            query = [query stringByAppendingString:[NSString stringWithFormat:@" or %@ like ?", strKey]];
        }
        
        
        
        NSString *value = @"%";
        value = [value stringByAppendingString:[[dicCondition objectForKey:strKey] stringByAppendingString:@"%"]];
        [arrayValue addObject:value];
        
    }
    
    if (isCheckCondition) {
        query = [query stringByAppendingString:@" ) "];
    }
    
    
    query = [query stringByAppendingString:[NSString stringWithFormat:@" order by %@ desc", DTONOTE_updatedDate]];
    
    
    
    
    if (start == 0) {
        NSString *countQuery = [NSString stringWithFormat:@"Select count(*) from %@ where status = 1 " , TABLENAME_DTOACCOUNT];
        
        
        
        isCheckCondition = NO;
        
        for (NSString *strKey in dicCondition.allKeys) {
            if ([StringUtil stringIsEmpty:[dicCondition objectForKey:strKey]]) {
                continue;
            }
            
            if (isCheckCondition==NO) {
                countQuery = [countQuery stringByAppendingString:@" and ( "];
                isCheckCondition = YES;
                countQuery = [countQuery stringByAppendingString:[NSString stringWithFormat:@" %@ like ?", strKey]];
            }else{
                countQuery = [countQuery stringByAppendingString:[NSString stringWithFormat:@" or %@ like ?", strKey]];
            }
        }
        
        if (isCheckCondition) {
            countQuery = [countQuery stringByAppendingString:@" ) "];
        }
        
        *totalCount = [DataUtil getCountItemsselectQuery:countQuery valueParamemter:arrayValue] ;
    }
    
    query = [query stringByAppendingString:[NSString stringWithFormat:@" limit %d offset %d", limit,start ]];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:arrayValue];
    
}
//filter(all) co phan trang
-(NSMutableArray*) filterWithStart : (int) start withLimit : (int) limit withOutTotal : (int*) totalCount {
       NSArray *allFields =[NSArray arrayWithObjects:DTOACCOUNT_accountId, DTOACCOUNT_address, DTOACCOUNT_email, DTOACCOUNT_mobile, DTOACCOUNT_name,DTOACCOUNT_updatedBy,DTOACCOUNT_code, DTOACCOUNT_accountType,DTOACCOUNT_clientAccountId, DTOACCOUNT_lat, DTOACCOUNT_lon, DTOACCOUNT_id, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status = 1 order by %@ desc",[allFields componentsJoinedByString:@"," ] , TABLENAME_DTOACCOUNT, DTOACCOUNT_updatedDate];
    
    
    if (start == 0) {
        NSString *countQuery = [NSString stringWithFormat:@"Select count(*) from %@ where status = 1 order by %@ desc", TABLENAME_DTOACCOUNT, DTOACCOUNT_updatedDate];
        
        *totalCount = [DataUtil getCountItemsselectQuery:countQuery valueParamemter:nil] ;
    }
    query = [query stringByAppendingString:[NSString stringWithFormat:@" limit %d offset %d", limit,start ]];
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
    
}


-(void) synchonizeDatabase: (id) listData withActionEvent : (ActionEvent*) actionEvent{
    
    
    sqlite3 *database ;// = [DataUtil openDatabase];
    @try {
        NSArray *arrayDataSync = [listData objectForKey:@"accountList"];
        
        if ([arrayDataSync isKindOfClass:[NSNull class]] || arrayDataSync == nil) {
            //khong co du lieu de dong bo
            return;
        }
        
        if(arrayDataSync.count == 0){
            //khong co du lieu de dong bo
            return;
        }
        
        SyncDataUtil *syncDataUtil = [SyncDataUtil new];
        [syncDataUtil synchonizeDatabase:arrayDataSync withActionEvent:actionEvent withTableName:TABLENAME_DTOACCOUNT withKeyColumn:DTOACCOUNT_accountId withArrayColumn:[self getAllFields]];
        
        return;
        
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
        
        NSArray *arrayColumnIrgnoUpdate  =[NSArray arrayWithObjects:DTOACCOUNT_id, nil];
        
        NSString *queryListColumns = @"(";
        NSInteger start = 0;
        NSInteger countFields = [self getAllFields].count - arrayColumnIrgnoUpdate.count;
        
        for (NSInteger i=0; i<countFields; i++) {
            start = i +1;
            
            NSString *fieldName = [[self getAllFields] objectAtIndex:i];
            
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
        NSString *query = [NSString stringWithFormat:@"insert  INTO %@%@ VALUES %@", TABLENAME_DTOACCOUNT, queryListColumns,queryListPara];
        
        
        //sinh ra cau update csdl
        
        
        
        NSString *queryUpdate = [NSString stringWithFormat:@"update %@ set ", TABLENAME_DTOACCOUNT];
        
        for (NSInteger i=0; i<countFields; i++) {
            NSString *fieldName = [[self getAllFields] objectAtIndex:i];
            if (i==0) {
                queryUpdate = [queryUpdate stringByAppendingFormat:@"%@=? ", fieldName];
            }else{
                queryUpdate = [queryUpdate stringByAppendingFormat:@", %@=? ", fieldName];
            }
        }
        
        queryUpdate = [queryUpdate stringByAppendingFormat:@" where %@=?", DTOACCOUNT_accountId];
        
        
        NSMutableArray *arrayUpdate = [NSMutableArray new];
        NSMutableArray *arrayInsert = [NSMutableArray new];
        
        for (int i=0; i<arrayDataSync.count; i++) {
            NSDictionary *entity = [arrayDataSync objectAtIndex:i];
            
            //kiem tra xem dtoaccountid  da ton tai trong csdl hay chua?
            NSDictionary *dicExistEntity = [self getDataWithKey:DTOACCOUNT_accountId withValue:[entity objectForKey:DTOACCOUNT_accountId]];
            
            if (dicExistEntity==nil || ([dicExistEntity isKindOfClass:[NSNull class]])) {
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
                        
                        NSString *keyField = [[self getAllFields] objectAtIndex:i];
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
                        
                        NSString *keyField = [[self getAllFields] objectAtIndex:i];
                        if ([[entity allKeys] containsObject:keyField]) {
                            
                            sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", [entity objectForKey:keyField]] UTF8String], -1, SQLITE_TRANSIENT);
                        }else{
                            sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", @""] UTF8String], -1, SQLITE_TRANSIENT);
                        }
                    }
                    
                    //
                    columnIndex++;
                    sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOACCOUNT_accountId]] UTF8String], -1, SQLITE_TRANSIENT);
                    
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
    
    
//    sqlite3 *database ;// = [DataUtil openDatabase];
//    @try {
//        NSArray *arrayDataSync = [listData objectForKey:@"accountList"];
//        char *sErrMsg = "";
//        clock_t  cStartClock = clock();
//        NSString *filePath = [DataUtil getPathFileSqlLite];
//        if (sqlite3_shutdown() == SQLITE_OK) {
//            if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
//                sqlite3_initialize();
//                if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
//                    
//                }
//            }
//        }
//        if (database==nil) {
//            NSLog(@"kpi data database nil");
//            return;
//        }
//        
//        NSArray *arrayColumnIrgnoUpdate  =[NSArray arrayWithObjects:DTOACCOUNT_id, nil];
//        
//        NSString *queryListColumns = @"(";
//        NSInteger start = 0;
//        NSInteger countFields = [self getAllFields].count - arrayColumnIrgnoUpdate.count;
//        
//        for (NSInteger i=0; i<countFields; i++) {
//            start = i +1;
//            
//            NSString *fieldName = [[self getAllFields] objectAtIndex:i];
//            
//            if (start != countFields) {
//                queryListColumns = [queryListColumns stringByAppendingString:[NSString stringWithFormat:@"%@,",fieldName]];
//            }else{
//                queryListColumns = [queryListColumns stringByAppendingString:[NSString stringWithFormat:@"%@)", fieldName]];
//            }
//            
//        }
//        
//        NSString *queryListPara = @"(";
//        for (NSInteger i=0; i<countFields; i++) {
//            if (i+1<countFields) {
//                queryListPara = [queryListPara stringByAppendingString:@"?,"];
//            }else{
//                queryListPara = [queryListPara stringByAppendingString:@"?)"];
//            }
//        }
//        NSString *query = [NSString stringWithFormat:@"insert  INTO %@%@ VALUES %@", TABLENAME_DTOACCOUNT, queryListColumns,queryListPara];
//        
//        
//        //sinh ra cau update csdl
//        
//        
//        
//        NSString *queryUpdate = [NSString stringWithFormat:@"update %@ set ", TABLENAME_DTOACCOUNT];
//        
//            for (NSInteger i=0; i<countFields; i++) {
//                NSString *fieldName = [[self getAllFields] objectAtIndex:i];
//                if (i==0) {
//                    queryUpdate = [queryUpdate stringByAppendingFormat:@"%@=? ", fieldName];
//                }else{
//                    queryUpdate = [queryUpdate stringByAppendingFormat:@", %@=? ", fieldName];
//                }
//            }
//        
//        queryUpdate = [queryUpdate stringByAppendingFormat:@" where %@=?", DTOACCOUNT_accountId];
//        
//        
//        NSMutableArray *arrayUpdate = [NSMutableArray new];
//        NSMutableArray *arrayInsert = [NSMutableArray new];
//        
//        for (int i=0; i<arrayDataSync.count; i++) {
//            NSDictionary *entity = [arrayDataSync objectAtIndex:i];
//            
//            //kiem tra xem dtoaccountid  da ton tai trong csdl hay chua?
//            NSDictionary *dicExistEntity = [self getDataWithKey:DTOACCOUNT_accountId withValue:[entity objectForKey:DTOACCOUNT_accountId]];
//            
//            if (dicExistEntity==nil || ([dicExistEntity isKindOfClass:[NSNull class]])) {
//                //truong hop them moi
//                [arrayInsert addObject:entity];
//            }else{
//                //truong hop sua
//                [arrayUpdate addObject:entity];
//            }
//        }
//        
//        
//        sqlite3_stmt *compiledStatement;
//        
//        
//        //insert vao csdl
//        if (arrayInsert.count>0) {
//            if(sqlite3_prepare_v2(database,[ query UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK )
//            {
//                sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, &sErrMsg);
//                
//                for (int i=0; i<arrayInsert.count; i++) {
//                    
//                    NSDictionary *entity = [arrayInsert objectAtIndex:i];
//                    
//                    int columnIndex = 0;
//                    
//                    for (NSInteger i=0; i<countFields; i++) {
//                        columnIndex ++;
//                        
//                        NSString *keyField = [[self getAllFields] objectAtIndex:i];
//                        if ([[entity allKeys] containsObject:keyField]) {
//                            
//                            sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", [entity objectForKey:keyField]] UTF8String], -1, SQLITE_TRANSIENT);
//                        }else{
//                            sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", @""] UTF8String], -1, SQLITE_TRANSIENT);
//                        }
//                    }
//                    
//                    
//                    
//                    sqlite3_step(compiledStatement) ;
//                    
//                    
//                    sqlite3_clear_bindings(compiledStatement);
//                    sqlite3_reset(compiledStatement);
//                }
//                
//                sqlite3_exec(database, "END TRANSACTION", NULL, NULL, &sErrMsg);
//                
//                NSLog(@"Imported %d records m_kpi in %4ld seconds\n", arrayDataSync.count , (clock() - cStartClock));
//            }  //end of if(sqlite3_prepare_v2
//        }
//        
//        //update vao csdl
//        if (arrayUpdate.count>0) {
//            
//            if(sqlite3_prepare_v2(database,[ queryUpdate UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK )
//            {
//                sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, &sErrMsg);
//                
//                for (int i=0; i<arrayUpdate.count; i++) {
//                    
//                    NSDictionary *entity = [arrayUpdate objectAtIndex:i];
//                    
//                    int columnIndex = 0;
//                    
//                    for (NSInteger i=0; i<countFields; i++) {
//                        columnIndex ++;
//                        
//                        NSString *keyField = [[self getAllFields] objectAtIndex:i];
//                        if ([[entity allKeys] containsObject:keyField]) {
//                            
//                            sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", [entity objectForKey:keyField]] UTF8String], -1, SQLITE_TRANSIENT);
//                        }else{
//                            sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", @""] UTF8String], -1, SQLITE_TRANSIENT);
//                        }
//                    }
//                    
//                    //
//                    columnIndex++;
//                    sqlite3_bind_text(compiledStatement, columnIndex, [[NSString stringWithFormat:@"%@", [entity objectForKey:DTOACCOUNT_accountId]] UTF8String], -1, SQLITE_TRANSIENT);
//                    
//                    sqlite3_step(compiledStatement) ;
//                    
//                    
//                    sqlite3_clear_bindings(compiledStatement);
//                    sqlite3_reset(compiledStatement);
//                }
//                
//                sqlite3_exec(database, "END TRANSACTION", NULL, NULL, &sErrMsg);
//                
//                NSLog(@"Imported %d records m_kpi in %4ld seconds\n", arrayDataSync.count , (clock() - cStartClock));
//            }  //end of if(sqlite3_prepare_v2
//            
//        }
//        
//        
//        
//        
//        
//    }
//    @catch (NSException *exception) {
//        NSLog(@"M_KPI DATA - Exception : %@", exception.description);
//    }
//    @finally {
//        sqlite3_close(database);
//    }
}




@end
