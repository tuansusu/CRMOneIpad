//
//  AppService.m
//  OfficeOneMB
//
//  Created by admin on 4/28/15.
//
//

#import "AppService.h"
#import "CRMAFHTTPRequestSerializer.h"


@implementation AppService
{
    int count;
}

static AppService* appService = nil;

+ (AppService*) getService {
    if (appService == nil) {
        appService = [[AppService alloc] init];
    }
    return appService;
}

- (void) sentModelRequest:(ActionEvent *)actionEvent {
    [self requestCommon:(ActionEvent*) actionEvent];
}

-(void) requestCommon : (ActionEvent*) actionEvent{
    NSDictionary* postData = (NSDictionary*) actionEvent.viewData;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    switch (actionEvent.action) {
        case login:
        {
            actionEvent.methodName = @"users/login";
        }
            break;
            
        case sync_get_timestamp:{
            actionEvent.methodName = @"sync/get-timestamp";
        }
            break;
        case sync_get_sysorganization:{
            actionEvent.methodName = @"sync/get-sysorganization";
        }
            break;
        case sync_get_account:{
            actionEvent.methodName = @"sync/get-account";
        }
            break;
        case sync_get_group:{
            actionEvent.methodName = @"sync/get-group";
        }break;
        case sync_get_industry:{
            actionEvent.methodName = @"sync/get-industry";
        }break;
        case sync_get_employee:{
            actionEvent.methodName = @"sync/get-employee";
        }break;
        case sync_get_lead:{
            actionEvent.methodName = @"sync/get-lead";
        }break;
        case sync_get_accountCrosssell:{
            actionEvent.methodName = @"sync/get-accountCrosssell";
        }break;
        case sync_get_leadCrosssell:{
            actionEvent.methodName = @"sync/get-leadCrosssell";
        }break;
        case sync_get_contact:{
            actionEvent.methodName = @"sync/get-contact";
        }break;
        case  sync_get_oppContact:{
            actionEvent.methodName = @"sync/get-oppContact";
        }break;
        case  sync_get_accContact:{
            actionEvent.methodName = @"sync/get-accContact";
        }break;
        case  sync_get_leadContact:{
            actionEvent.methodName = @"sync/get-leadContact";
        }break;
        case  sync_get_oppCompetitor:{
            actionEvent.methodName = @"sync/get-oppCompetitor";
        }break;
        case  sync_get_competitor:{
            actionEvent.methodName = @"sync/get-competitor";
        }break;
        case  sync_get_industryAccount:{
            actionEvent.methodName = @"sync/get-industryAccount";
        }break;
        case  sync_get_industryLead:{
            actionEvent.methodName = @"sync/get-industryLead";
        }break;
        case sync_get_employeeAccount:{
            actionEvent.methodName = @"sync/get-employeeAccount";
        }break;
        case sync_get_relationship:{
            actionEvent.methodName = @"sync/get-relationship";
        }break;
        case  sync_get_accRelationship:{
            actionEvent.methodName = @"sync/get-accRelationship";
        }break;
        case  sync_get_leadRelationship:{
            actionEvent.methodName = @"sync/get-leadRelationship";
        }break;
        case   sync_get_relationshipType:{
            actionEvent.methodName = @"sync/get-relationshipType";
        }break;
        case   sync_get_rmDailyKh:{
            actionEvent.methodName = @"sync/get-rmDailyKh";
        }break;
        case   sync_get_orgType:{
            actionEvent.methodName = @"sync/get-orgType";
        }break;
        case  sync_get_rmDailyCard:{
            actionEvent.methodName = @"sync/get-rmDailyCard";
        }break;
        case  sync_get_rmDailyThanhtoan:{
            actionEvent.methodName = @"sync/get-rmDailyThanhtoan";
        }break;
        case sync_get_rmDailyTietkiem:{
            actionEvent.methodName = @"sync/get-rmDailyTietkiem";
        }break;
        case sync_get_rmDailyTindung:{
            actionEvent.methodName = @"sync/get-rmDailyTindung";
        }break;
        case  sync_get_rmMonthlyHdv:{
            actionEvent.methodName = @"sync/get-rmMonthlyHdv";
        }break;
        case  sync_get_rmMonthlyTindung:{
            actionEvent.methodName = @"sync/get-rmMonthlyTindung";
        }break;
        default:
            break;
    }
    [dic setObject:actionEvent.methodName forKey:@"method"];
    [dic setObject:postData forKey:@"dataPost"];
    
    [self sendRequetWithDictionary:dic andEvent:actionEvent];
}


- (void) sendRequetWithDictionary : (NSMutableDictionary *) dictionary andEvent : (ActionEvent*) actionEvent
{
#ifdef LOG_ERROR
    NSLog(@"Sending request\n%@",dictionary);
#endif
    
    //VOFFICE_REQUEST_PATH
    NSString * uri =[NSString stringWithFormat:@"%@%@", KEY_CONGIG_VOFFICE_PATH, actionEvent.methodName];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];

    
    
    
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:uri parameters:[dictionary objectForKey:@"dataPost"]];
    [request setTimeoutInterval:CONFIG_REQUEST_TIMEOUT];
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self onHttpReceivedData:responseObject andModelEvent:actionEvent];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error  ---- TUANKK: %@", operation.responseString);
        [SVProgressHUD dismiss];
//        [self performSelectorOnMainThread:@selector(failedWithContactsDownload) withObject:nil waitUntilDone:YES];
    }];
    [manager.operationQueue addOperation:operation];
    
    
    
    
    
    //TUANNV TAM COMMENT TO TEST
    
//    [manager POST:uri parameters:[dictionary objectForKey:@"dataPost"]
//          success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         //login thanh cong roi. thi tiep tuc lay du lieu
//         [self onHttpReceivedData:responseObject andModelEvent:actionEvent];
//         
//     }
//          failure:
//     ^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"Error: %@", error);
//     }];
    
#ifdef LOG_ERROR
    NSLog(@"uri = %@", uri);
#endif
    
    
}

#pragma mark received data

- (void) onHttpReceivedData:(id)jsonValue andModelEvent:(ActionEvent*)actionEvent {
    ModelEvent *modelEvent = [[ModelEvent alloc] init];
    modelEvent.actionEvent = actionEvent;
    //NSString *json = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:jsonValue options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
#ifdef LOG_ERROR
    //NSLog(@"Result JSON:\n%@", json);
#endif
    
    NSDictionary *result = jsonValue;// [jsonValue objectForKey:@"sysUser"];
    
    @try {
        if ([result isKindOfClass:[NSNull class]]) {
            [[AppController getController] handleErrorEvent:modelEvent];
        }else{
            NSNumber *code = [result objectForKey:@"responseCode"];
            modelEvent.modelCode = [code intValue];
            
            switch (modelEvent.actionEvent.action) {
                case login:
                {
                    modelEvent.modelData = result;
                    
                    if (modelEvent.modelCode == 200) {
                        [[AppController getController] handleModelEvent:modelEvent];
                    }
                    else
                    {
                        [[AppController getController] handleErrorEvent:modelEvent];
                    }
                }
                    break;
                default:
                {
                    modelEvent.modelData = result;
                    if (modelEvent.modelCode == 200) {
                        
                        [[AppController getController] handleModelEvent:modelEvent];
                        
                    }
                    else
                    {
                        [[AppController getController] handleErrorEvent:modelEvent];
                    }
                }
                    break;
            }
        }
        
        //[modelEvent release];
    }
    @catch (NSException *exception) {
        [[AppController getController] handleErrorEvent:modelEvent];
    }
    @finally {
        //[json release];
        //[modelEvent release];
    }
}


@end
