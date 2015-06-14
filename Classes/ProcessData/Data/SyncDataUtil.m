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



#define KEY_objectCode @"objectCode"
#define KEY_includeActive @"includeActive"
#define KEY_maxTimeStamp @"maxTimeStamp"

#define PAGESIZE_LIMIT 200

@interface SyncDataUtil ()
{
    BaseViewController *senderViewController;
    NSUserDefaults *defaults;
    NSMutableDictionary *dicDataCode_Sync;
    NSMutableDictionary *dicTableKeyColumn;
}
@end

@implementation SyncDataUtil



-(id) initWithViewController:(BaseViewController *)viewController{
    
    if (self = [super init]) {
        defaults= [NSUserDefaults standardUserDefaults];
        senderViewController = viewController;
        
        [self GetDicData];
        
    }
    return self;
}


-(void) synchonizeDatabase: (NSArray*) arrayDataSync withModelEvent : (ModelEvent*) modelEvent withTableName : strTableName{
    
    NSArray *arrayColumn = [DataUtil GetAllColumnWithTable:strTableName];
    
    [self synchonizeDatabase:arrayDataSync withActionEvent:modelEvent.actionEvent withTableName:strTableName withKeyColumn:DTOSYSORGANIZATION_sysOrganizationId withArrayColumn:arrayColumn];
    
    
    int start = [[modelEvent.actionEvent.viewData objectForKey:@"firstResult"] intValue];
    start = PAGESIZE + start;
    
    int totalRecord = [[modelEvent.modelData objectForKey:@"totalRecord"] intValue];
    
    //
    if (totalRecord> PAGESIZE && arrayDataSync.count == PAGESIZE) {
        //tiep tuc dong bo voi start moi
        
//        NSDictionary *dic = @{@"minTimeStamp": strMinTime, @"maxTimeStamp": strMaxTime, @"firstResult":iFirstResult, @"pageSize": @"200", @"includeCount":@"true",@"includeActive":@"true"};
        
        [self synchonizeDBWithSync:modelEvent.actionEvent.action withMinTime:[modelEvent.actionEvent.viewData objectForKey:@"minTimeStamp"] withMaxTime:[modelEvent.actionEvent.viewData objectForKey:@"maxTimeStamp"] withFirstResult:[NSString stringWithFormat:@"%d", start]];
        
        
    }else{
        NSArray *arraySync = [self getArrayTableToSync];
        
        NSNumber *tmpAkdfjdkf =@(modelEvent.actionEvent.action);
        NSLog(@"tmpAkdfjdkf  ===   %@", tmpAkdfjdkf);
        
       int indexOfObject =  [arraySync indexOfObject:@(modelEvent.actionEvent.action)];
        indexOfObject = indexOfObject +1;
        if (indexOfObject<arraySync.count) {
            
            
            NSNumber *tmpSync = [arraySync objectAtIndex:indexOfObject];
            enum ActionEventEnum actionSync = [tmpSync intValue];
            
            NSString *strObjectCode = [self getObjectCode:actionSync];
            //Lấy MaxTime của objectCode sau đó thực hiện đồng bộ ObjectCode đó
            NSLog(@"object code = %@", strObjectCode);
            [self getMaxTimeWithObjectCode:strObjectCode  withActionEventEnum:actionSync];
        }else{
            NSLog(@"dong bo xong");
        }
        
        
        
    }
    
    
}


/*
 *arrayDataSync: Danh sach gia tri
 *actionEvent: Lay thong tin day
 *tableName: Ten bang
 *keyColumn: Ten cot khoa chinh
 *arrayAllColumn: Danh sach ten cot
 */
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

//Lay tat ca cac thang can dong bo
-(NSArray*) getArrayTableToSync {
    
   
   return  @[@(sync_get_sysorganization),
             @(sync_get_account),
             @(sync_get_group),
             @(sync_get_industry),
             @(sync_get_employee),
             @(sync_get_lead),
             @(sync_get_accountCrosssell),
             @(sync_get_leadCrosssell),
             @(sync_get_contact),
             @(sync_get_oppContact),
             @(sync_get_accContact),
             @(sync_get_leadContact),
             @(sync_get_oppCompetitor),
             @(sync_get_competitor),
             @(sync_get_industryAccount),
             @(sync_get_industryLead),
             @(sync_get_employeeAccount),
             @(sync_get_relationship),
             @(sync_get_accRelationship),
             @(sync_get_leadRelationship),
             @(sync_get_relationshipType),
             @(sync_get_rmDailyKh),
             @(sync_get_orgType),
             @(sync_get_rmDailyCard),
             @(sync_get_rmDailyThanhtoan),
             @(sync_get_rmDailyTietkiem),
             @(sync_get_rmDailyTindung),
             @(sync_get_rmMonthlyHdv),
             @(sync_get_rmMonthlyTindung)];
    
}

/*
 * Lấy mã code tương ứng với ActionEvent
 */
-(NSString*) getObjectCode: ( enum ActionEventEnum) actionEventEnum{
    
    NSString *strResult = @"";
    
    switch (actionEventEnum) {
        case sync_get_sysorganization:{
            strResult = @"sysorganization";
        }
            break;
        case sync_get_account:{
            strResult = @"account";
        }
            break;
        case sync_get_group:{
            strResult = @"group";
        }break;
        case sync_get_industry:{
            strResult = @"industry";
        }break;
        case sync_get_employee:{
            strResult = @"employee";
        }break;
        case sync_get_lead:{
            strResult = @"lead";
        }break;
        case sync_get_accountCrosssell:{
            strResult = @"accountCrosssell";
        }break;
        case sync_get_leadCrosssell:{
            strResult = @"leadCrosssell";
        }break;
        case sync_get_contact:{
            strResult = @"contact";
        }break;
        case  sync_get_oppContact:{
            strResult = @"oppContact";
        }break;
        case  sync_get_accContact:{
            strResult = @"accContact";
        }break;
        case  sync_get_leadContact:{
            strResult = @"leadContact";
        }break;
        case  sync_get_oppCompetitor:{
            strResult = @"oppCompetitor";
        }break;
        case  sync_get_competitor:{
            strResult= @"competitor";
        }break;
        case  sync_get_industryAccount:{
            strResult = @"industryAccount";
        }break;
        case  sync_get_industryLead:{
            strResult = @"industryLead";
        }break;
        case sync_get_employeeAccount:{
            strResult = @"employeeAccount";
        }break;
        case sync_get_relationship:{
            strResult= @"relationship";
        }break;
        case  sync_get_accRelationship:{
            strResult = @"accRelationship";
        }break;
        case  sync_get_leadRelationship:{
            strResult = @"leadRelationship";
        }break;
        case   sync_get_relationshipType:{
            strResult = @"relationshipType";
        }break;
        case   sync_get_rmDailyKh:{
            strResult = @"rmDailyKh";
        }break;
        case   sync_get_orgType:{
            strResult = @"orgType";
        }break;
        case  sync_get_rmDailyCard:{
            strResult = @"rmDailyCard";
        }break;
        case  sync_get_rmDailyThanhtoan:{
            strResult = @"rmDailyThanhtoan";
        }break;
        case sync_get_rmDailyTietkiem:{
            strResult = @"rmDailyTietkiem";
        }break;
        case sync_get_rmDailyTindung:{
            strResult = @"rmDailyTindung";
        }break;
        case  sync_get_rmMonthlyHdv:{
            strResult = @"rmMonthlyHdv";
        }break;
        case  sync_get_rmMonthlyTindung:{
            strResult = @"rmMonthlyTindung";
        }break;
        default:
            break;
    }
    
    return [strResult uppercaseString];
}



/*
 * Lấy cột khoá tương ứng với bảng trong csdl
 */
-(NSString*) getKeyColumnWithTableName: (NSString*) strTableName{
    
    NSString *strResult = @"";
    
   // NSMutableDictionary *dic
    
    
//    switch (strTableName) {
//        case sync_get_sysorganization:{
//            strResult = @"sysorganization";
//        }
//            break;
//        case sync_get_account:{
//            strResult = @"account";
//        }
//            break;
//        case sync_get_group:{
//            strResult = @"group";
//        }break;
//        case sync_get_industry:{
//            strResult = @"industry";
//        }break;
//        case sync_get_employee:{
//            strResult = @"employee";
//        }break;
//        case sync_get_lead:{
//            strResult = @"lead";
//        }break;
//        case sync_get_accountCrosssell:{
//            strResult = @"accountCrosssell";
//        }break;
//        case sync_get_leadCrosssell:{
//            strResult = @"leadCrosssell";
//        }break;
//        case sync_get_contact:{
//            strResult = @"contact";
//        }break;
//        case  sync_get_oppContact:{
//            strResult = @"oppContact";
//        }break;
//        case  sync_get_accContact:{
//            strResult = @"accContact";
//        }break;
//        case  sync_get_leadContact:{
//            strResult = @"leadContact";
//        }break;
//        case  sync_get_oppCompetitor:{
//            strResult = @"oppCompetitor";
//        }break;
//        case  sync_get_competitor:{
//            strResult= @"competitor";
//        }break;
//        case  sync_get_industryAccount:{
//            strResult = @"industryAccount";
//        }break;
//        case  sync_get_industryLead:{
//            strResult = @"industryLead";
//        }break;
//        case sync_get_employeeAccount:{
//            strResult = @"employeeAccount";
//        }break;
//        case sync_get_relationship:{
//            strResult= @"relationship";
//        }break;
//        case  sync_get_accRelationship:{
//            strResult = @"accRelationship";
//        }break;
//        case  sync_get_leadRelationship:{
//            strResult = @"leadRelationship";
//        }break;
//        case   sync_get_relationshipType:{
//            strResult = @"relationshipType";
//        }break;
//        case   sync_get_rmDailyKh:{
//            strResult = @"rmDailyKh";
//        }break;
//        case   sync_get_orgType:{
//            strResult = @"orgType";
//        }break;
//        case  sync_get_rmDailyCard:{
//            strResult = @"rmDailyCard";
//        }break;
//        case  sync_get_rmDailyThanhtoan:{
//            strResult = @"rmDailyThanhtoan";
//        }break;
//        case sync_get_rmDailyTietkiem:{
//            strResult = @"rmDailyTietkiem";
//        }break;
//        case sync_get_rmDailyTindung:{
//            strResult = @"rmDailyTindung";
//        }break;
//        case  sync_get_rmMonthlyHdv:{
//            strResult = @"rmMonthlyHdv";
//        }break;
//        case  sync_get_rmMonthlyTindung:{
//            strResult = @"rmMonthlyTindung";
//        }break;
//        default:
//            break;
//    }
    
    return [strResult uppercaseString];
}




-(void) GetDicData {
    dicDataCode_Sync = [[NSMutableDictionary alloc]init];
    
    
    [dicDataCode_Sync setValue:@(sync_get_sysorganization) forKey:@"sysorganization"];
    [dicDataCode_Sync setValue:@(sync_get_account) forKey:@"account"];
    [dicDataCode_Sync setValue:@(sync_get_group) forKey:@"group"];
    [dicDataCode_Sync setValue:@(sync_get_industry) forKey:@"industry"];
    [dicDataCode_Sync setValue:@(sync_get_employee) forKey:@"employee"];
    [dicDataCode_Sync setValue:@(sync_get_lead) forKey:@"lead"];
    [dicDataCode_Sync setValue:@(sync_get_accountCrosssell) forKey:@"accountcrosssell"];
    [dicDataCode_Sync setValue:@(sync_get_leadCrosssell) forKey:@"leadcrosssell"];
    [dicDataCode_Sync setValue:@(sync_get_contact) forKey:@"contact"];
    [dicDataCode_Sync setValue:@(sync_get_oppContact) forKey:@"oppcontact"];
    [dicDataCode_Sync setValue:@(sync_get_accContact) forKey:@"acccontact"];
    [dicDataCode_Sync setValue:@(sync_get_leadContact) forKey:@"leadcontact"];
    [dicDataCode_Sync setValue:@(sync_get_oppCompetitor) forKey:@"oppcompetitor"];
    [dicDataCode_Sync setValue:@(sync_get_competitor) forKey:@"competitor"];
    [dicDataCode_Sync setValue:@(sync_get_industryAccount) forKey:@"industryaccount"];
    [dicDataCode_Sync setValue:@(sync_get_industryLead) forKey:@"industrylead"];
    [dicDataCode_Sync setValue:@(sync_get_employeeAccount) forKey:@"employeeaccount"];
    [dicDataCode_Sync setValue:@(sync_get_relationship) forKey:@"relationship"];
    [dicDataCode_Sync setValue:@(sync_get_accRelationship) forKey:@"accRelationship"];
    [dicDataCode_Sync setValue:@(sync_get_leadRelationship) forKey:@"leadRelationship"];
    [dicDataCode_Sync setValue:@(sync_get_relationshipType) forKey:@"relationshiptype"];//die o day
    [dicDataCode_Sync setValue:@(sync_get_rmDailyKh) forKey:@"rmdailykh"];
    [dicDataCode_Sync setValue:@(sync_get_orgType) forKey:@"orgtype"];
    [dicDataCode_Sync setValue:@(sync_get_rmDailyCard) forKey:@"rmdailycard"];
    [dicDataCode_Sync setValue:@(sync_get_rmDailyThanhtoan) forKey:@"rmdailythanhtoan"];
    [dicDataCode_Sync setValue:@(sync_get_rmDailyTietkiem) forKey:@"rmdailytietkiem"];
    [dicDataCode_Sync setValue:@(sync_get_rmDailyTindung) forKey:@"rmdailytindung"];
    [dicDataCode_Sync setValue:@(sync_get_rmMonthlyHdv) forKey:@"rmmonthlyhdv"];
    [dicDataCode_Sync setValue:@(sync_get_rmMonthlyTindung) forKey:@"rmmonthlytindung"];
}


-(void) GetDicTableKeyColumn {
    dicTableKeyColumn = [[NSMutableDictionary alloc]init];
    
    
    [dicTableKeyColumn setValue:DTOSYSORGANIZATION_sysOrganizationId forKey:@"sysorganization"];
    [dicTableKeyColumn setValue:DTOACCOUNT_accountId forKey:@"account"];
    [dicTableKeyColumn setValue:DTOGROUP_groupId forKey:@"group"];
    [dicTableKeyColumn setValue:DTOINDUSTRY_industryId forKey:@"industry"];
    [dicTableKeyColumn setValue:DTOEMPLOYEE_employeeId forKey:@"employee"];
    [dicTableKeyColumn setValue:DTOLEAD_leadId forKey:@"lead"];
    [dicTableKeyColumn setValue:DTOACCOUNTCROSSSELL_accountCrossSellingId forKey:@"accountcrosssell"];
    [dicTableKeyColumn setValue:DTOLEADCROSSSELL_leadCrossSellingId forKey:@"leadcrosssell"];
    [dicTableKeyColumn setValue:DTOCONTACT_contactId forKey:@"contact"];
    [dicTableKeyColumn setValue:DTOOPPORTUNITYCONTACT_opportunityContactId forKey:@"oppcontact"]; //opportunityContact
    [dicTableKeyColumn setValue:DTOACCOUNTCONTACT_accountContactId forKey:@"acccontact"];  //accountContact
    //[dicTableKeyColumn setValue:@(sync_get_leadContact) forKey:@"leadcontact"];
    [dicTableKeyColumn setValue:DTOOPPORTUNITYCOMPETITOR_clientOpportunityCompetitorId forKey:@"opportunityCompetitor"];//oppcompetitor
    [dicTableKeyColumn setValue:DTOCOMPETITOR_competitorId forKey:@"competitor"];
    [dicTableKeyColumn setValue:DTOINDUSTRYACCOUNT_industryAccountId forKey:@"industryaccount"];
    [dicTableKeyColumn setValue:@(sync_get_industryLead) forKey:@"industrylead"];
    [dicTableKeyColumn setValue:@(sync_get_employeeAccount) forKey:@"employeeaccount"];
    [dicTableKeyColumn setValue:@(sync_get_relationship) forKey:@"relationship"];
    [dicTableKeyColumn setValue:@(sync_get_accRelationship) forKey:@"accRelationship"];
    [dicTableKeyColumn setValue:@(sync_get_leadRelationship) forKey:@"leadRelationship"];
    [dicTableKeyColumn setValue:@(sync_get_relationshipType) forKey:@"relationshiptype"];//die o day
    [dicTableKeyColumn setValue:@(sync_get_rmDailyKh) forKey:@"rmdailykh"];
    [dicTableKeyColumn setValue:@(sync_get_orgType) forKey:@"orgtype"];
    [dicTableKeyColumn setValue:@(sync_get_rmDailyCard) forKey:@"rmdailycard"];
    [dicTableKeyColumn setValue:@(sync_get_rmDailyThanhtoan) forKey:@"rmdailythanhtoan"];
    [dicTableKeyColumn setValue:@(sync_get_rmDailyTietkiem) forKey:@"rmdailytietkiem"];
    [dicTableKeyColumn setValue:@(sync_get_rmDailyTindung) forKey:@"rmdailytindung"];
    [dicTableKeyColumn setValue:@(sync_get_rmMonthlyHdv) forKey:@"rmmonthlyhdv"];
    //[dicTableKeyColumn setValue:dtorm forKey:@"rmmonthlytindung"];
}



/*
 * Thực hiện việc đồng bộ tất cả các bảng - tu server ve client
 */

-(void) getDBFromServerToClien:(BaseViewController *)viewController{
    
    
//    NSArray *arraySync = [self getArrayTableToSync];
//    
//    
//    NSNumber *tmpSync = [arraySync objectAtIndex:0];
//    enum ActionEventEnum actionSync = [tmpSync intValue];
//    
//    NSString *strObjectCode = [self getObjectCode:actionSync];
    
    enum ActionEventEnum actionSync = sync_get_rmMonthlyTindung;
    NSString *strObjectCode = @"rmMonthlyTindung";
    strObjectCode = [strObjectCode uppercaseString];
    
    //Lấy MaxTime của objectCode sau đó thực hiện đồng bộ ObjectCode đó
    NSLog(@"object code = %@", strObjectCode);
    [self getMaxTimeWithObjectCode:strObjectCode  withActionEventEnum:actionSync];

    
    
}


- (void) receiveDataFromModel: (ModelEvent*) modelEvent {
    
    NSString *  strTableName = @"";
    NSString * strKeyListArray = @"";
    switch (modelEvent.actionEvent.action) {
            
        case sync_post_object:{
            //neu la post thi ?
        }
            break;
            
        case sync_get_timestamp:
        {
            //Lay thong tin MaxTime ve se thuc hien dong bo du lieu cua ObjectCode
            //modelEvent.modelData -  du lieu truyen ve
            NSString *objectCodeSync = [modelEvent.actionEvent.viewData objectForKey:KEY_objectCode];
            objectCodeSync  = [objectCodeSync lowercaseString];
            NSNumber *tmpSync =[dicDataCode_Sync objectForKey:objectCodeSync];
            enum ActionEventEnum actionSync = [tmpSync intValue];
            
            id minTime =  [defaults objectForKey:[NSString stringWithFormat:@"minTime_%@", objectCodeSync]];
            if(!minTime){
                minTime = @"0";
            }
            [self synchonizeDBWithSync:actionSync withMinTime:minTime withMaxTime:[modelEvent.modelData objectForKey:KEY_maxTimeStamp] withFirstResult:@"0"];
            
            return;
            
        }
            break;
            
            case sync_get_sysorganization:
        {
            strTableName = @"dtosysorganization";
            strKeyListArray = @"sysOrganizationList";
        }
            break;
        case sync_get_account:{
            strTableName = @"dtoaccount";
            strKeyListArray = @"accountList";
        }
            break;
        case sync_get_group:{
            strTableName = @"dtogroup";
            strKeyListArray = @"groupList";
        }break;
        case sync_get_industry:{
            strTableName = @"dtoindustry";
            strKeyListArray = @"industryList";
        }break;
        case sync_get_employee:{
            strTableName = @"dtoemployee";
            strKeyListArray = @"employeeList";
        }break;
        case sync_get_lead:{
            strTableName = @"dtolead";
            strKeyListArray = @"leadList";
        }break;
        case sync_get_accountCrosssell:{
            strTableName = @"dtoaccountCrosssell";
            strKeyListArray = @"accountCrosssellList";
        }break;
        case sync_get_leadCrosssell:{
            strTableName = @"dtoleadCrosssell";
            strKeyListArray = @"leadCrosssellList";
        }break;
        case sync_get_contact:{
            strTableName = @"dtocontact";
            strKeyListArray = @"contactList";
        }break;
        case  sync_get_oppContact:{
            strTableName = @"dtooppContact";
            strKeyListArray = @"oppContactList";
        }break;
        case  sync_get_accContact:{
            strTableName = @"dtoaccContact";
            strKeyListArray = @"accContactList";
            
        }break;
        case  sync_get_leadContact:{
            strTableName = @"dtoleadContact";
            strKeyListArray = @"leadContactList";
        }break;
        case  sync_get_oppCompetitor:{
            strTableName = @"dtooppCompetitor";
            strKeyListArray = @"oppCompetitorList";
        }break;
        case  sync_get_competitor:{
            strTableName = @"dtocompetitor";
            strKeyListArray = @"competitorList";
        }break;
        case  sync_get_industryAccount:{
            strTableName = @"dtoindustryAccount";
            strKeyListArray = @"industryAccountList";
        }break;
        case  sync_get_industryLead:{
            strTableName = @"dtoindustryLead";
            strKeyListArray = @"industryLeadList";
        }break;
        case sync_get_employeeAccount:{
            strTableName = @"dtoemployeeAccount";
            strKeyListArray = @"employeeAccountList";
        }break;
        case sync_get_relationship:{
            strTableName = @"dtorelationship";
            strKeyListArray = @"relationshipList";
        }break;
        case  sync_get_accRelationship:{
            strTableName = @"dtoaccRelationship";
            strKeyListArray = @"accRelationshipList";
        }break;
        case  sync_get_leadRelationship:{
            strTableName = @"dtoleadRelationship";
            strKeyListArray = @"leadRelationshipList";
        }break;
        case   sync_get_relationshipType:{
            strTableName = @"dtorelationshipType";
            strKeyListArray = @"relationshipTypeList"; //relationshipTypeList
        }break;
        case   sync_get_rmDailyKh:{
            strTableName = @"dtormDailyKh";
            strKeyListArray = @"rmDailyKhList"; //rmDailyKhList
        }break;
        case   sync_get_orgType:{
            strTableName = @"dtoorgType";
            strKeyListArray = @"orgTypeList";//orgTypeList
        }break;
        case  sync_get_rmDailyCard:{
            strTableName = @"dtormDailyCard";
            strKeyListArray = @"rmDailyCards";//rmDailyCards
        }break;
        case  sync_get_rmDailyThanhtoan:{
            strTableName = @"dtormDailyThanhtoan";
            strKeyListArray = @"rmDailyThanhtoans";//rmDailyThanhtoans
        }break;
        case sync_get_rmDailyTietkiem:{
            strTableName = @"dtormDailyTietkiem";
            strKeyListArray = @"rmDailyTietkiemList";//rmDailyTietkiems
        }break;
        case sync_get_rmDailyTindung:{
            
            strTableName = @"dtormDailyTindung";
            strKeyListArray = @"rmDailyTindungs";//rmDailyTindungs
        }break;
        case  sync_get_rmMonthlyHdv:{
            
            strTableName = @"dtormMonthlyHdv";
            strKeyListArray = @"rmMonthlyHdvs"; //rmMonthlyHdvs
        }break;
        case  sync_get_rmMonthlyTindung:{
            
            strTableName = @"dtormMonthlyTindung";
            strKeyListArray = @"rmMonthlyTindungs"; //rmMonthlyTindungs
        }break;
            
            
        default:
            break;
    }
    [self synchonizeDatabase:[modelEvent.modelData objectForKey:strKeyListArray]  withModelEvent:modelEvent withTableName:strTableName];
    
}

- (void) receiveErrorFromModel: (ModelEvent*) modelEvent {
    
}
/*
 * Lay thong tin maxtime tu objectCode
 */

-(void) getMaxTimeWithObjectCode: (NSString *) strObjectCode  withActionEventEnum : (enum ActionEventEnum) actionEventEnum {
    NSDictionary *dic = @{@"objectCode": strObjectCode, @"includeActive":@"true"};
    
    ActionEvent* actionEvent = [[ActionEvent alloc] init];
    actionEvent.action = sync_get_timestamp;
    actionEvent.viewData = dic;
    actionEvent.sender = self;
    NSLog(@"Sync Get Time = %@", dic);
    [[AppController getController] handleViewEvent:actionEvent];
}


-(void) synchonizeDBWithSync : (enum ActionEventEnum) syncObject withMinTime : (NSString*) strMinTime withMaxTime : (NSString*) strMaxTime withFirstResult : (NSString*) iFirstResult{
    
    [SVProgressHUD showWithStatus:@"sync ..."];
    
    NSDictionary *dic = @{@"minTimeStamp": strMinTime, @"maxTimeStamp": strMaxTime, @"firstResult":iFirstResult, @"pageSize": @"200", @"includeCount":@"true",@"includeActive":@"true"};
    ActionEvent* actionEvent = [[ActionEvent alloc] init];
    actionEvent.action = syncObject;
    actionEvent.viewData = dic;
    actionEvent.sender = self;
    
    NSLog(@"Sync DB = %@", dic);
    
    [[AppController getController] handleViewEvent:actionEvent];
    
}



#pragma mark baseview controller

-(void) timeOutAction{
    
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:Title_TimeOut_Exception delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
//    
//    FrameworkAppDelegate *appDel = (FrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
//    
//    RootViewController *rootView = [[RootViewController alloc] init];
//    
//    [appDel.window setRootViewController:rootView];
    
    
}


- (void) receiveErrorInternetFromModel: (ModelEvent*) modelEvent
{
    
}


//waiting network
- (void) presentSmallWaiting {
    //numOfSmallWaiting ++;
    [SVProgressHUD show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void) dismissSmallWaiting {
    
    [SVProgressHUD dismiss];
    
//    numOfSmallWaiting --;
//    if (numOfSmallWaiting < 0) {
//        numOfSmallWaiting = 0;
//    }
//    if (numOfSmallWaiting > 0) {
//        [SVProgressHUD show];
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    } else {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        [SVProgressHUD dismiss];
//    }
}

-(void) displayErrorData{
    
    // Make toast with a title
    [senderViewController.view makeToast:@"Có lỗi dữ liệu trả về từ máy chủ"
                duration:3.0
                position:@"bottom"
                   title:@"Cảnh báo !"];
    
}


@end
