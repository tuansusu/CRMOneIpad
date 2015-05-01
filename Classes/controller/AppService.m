//
//  AppService.m
//  OfficeOneMB
//
//  Created by admin on 4/28/15.
//
//

#import "AppService.h"


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
        case sync_get_sysorganization:{
            actionEvent.methodName = @"sync/get-sysorganization";
        }
            break;
        case sync_get_account:{
            actionEvent.methodName = @"sync/get-account";
        }
            break;
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
    
    
    [manager POST:uri parameters:[dictionary objectForKey:@"dataPost"]
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //login thanh cong roi. thi tiep tuc lay du lieu
         [self onHttpReceivedData:responseObject andModelEvent:actionEvent];
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         
         
     }];
    
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
