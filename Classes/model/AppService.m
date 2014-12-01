//
//  AppService.m
//  IphoneFramework
//
//  Created by Tran Van Bang on 5/2/13.
//
//
//

#import "AppService.h"
#import "HTTPRequest.h"
#import "NetworkEngine.h"
#import "Constants.h"
#import "NetworkUtils.h"
#import "ModelEvent.h"
#import "JSON.h"
#import "AppController.h"
#import "SVProgressHUD.h"
#import "BaseViewController.h"
#import "FrameworkAppDelegate.h"
#import "RootViewController.h"

@implementation AppService
{
    int count;
}

@synthesize httpClient;
////tuannv///
@synthesize currentUserId;

static AppService* appService = nil;

+ (AppService*) getService {
    if (appService == nil) {
        appService = [[AppService alloc] init];
    }
    return appService;
}

#pragma mark Request


-(void) requestCommon : (ActionEvent*) actionEvent{
    NSDictionary* postData = (NSDictionary*) actionEvent.viewData;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    switch (actionEvent.action) {
        case login:{
            actionEvent.methodName = @"Login";
        }
            break;
            
            
        case processDocument:
        {
            actionEvent.methodName = @"TempprocessDocument";
        }
            break;
        case confirmDocument:{
            actionEvent.methodName = @"TempprocessDocument";
        }
            break;
            
            case getConfigByKey:
        {
            actionEvent.methodName = @"GetConfigByKey";
        }
            break;
            case updateStatusConfirm:
        {
            actionEvent.methodName = @"UpdateStatusConfirm";
        }
            break;
            
        case rejectSignDocumentAction:{
            actionEvent.methodName = @"RejectSignDocumentInfo";
        }
            break;
            case actionDigitalDocument:
        {
            actionEvent.methodName = @"SignDocumentInfo";
        }
            break;
        case getListTaskFromDoc:{
            actionEvent.methodName = @"GetListTaskByDocumentId";
        }
            break;
        case createUmTaskRequest:{
            actionEvent.methodName = @"UpdateTaskRequest";
        }
            break;
            case approveTask:
            case denyApproveTask:
        {
            actionEvent.methodName = @"ApprovedTask";
        }
            break;
        case getListNotice:
        {
            actionEvent.methodName = @"GetListNotice";
        }
            break;
            
        case getListDocument:{
            actionEvent.methodName = @"GetListDocumentInUser";
        }
            break;
        case getAllDocumentCount:
        {
            actionEvent.methodName = @"GetCountDocumentInfo";
        }
            break;
            
        case getListMyMeeting:
        {
            actionEvent.methodName = @"GetListCalendar";
        }
            break;
            
        case searchListStaff:{
            actionEvent.methodName = @"SearchListStaff";
        }
            break;
        case getRoleDocumentSend:{
            actionEvent.methodName = @"GetRoleDocumentSend";
        }
            break;
        case  getDocumentDetail:{
            actionEvent.methodName = @"GetDetailDocument";
            
        }
            break;
            
        case getTreeGroup:
        {
            actionEvent.methodName = @"GetTreeGroup";
        }
            break;
        case sendDocumentToGroup:
        {
            actionEvent.methodName = @"SendDocumentToGroup";
        }
            break;
            
        case getTasks:{
            actionEvent.methodName = @"GetTasks";
        }
            break;
        case sendDocumentToStaff:{
            actionEvent.methodName = @"SendDocumentToStaff";
        }
            break;
        case getDocumentSignByUser:
        {
            actionEvent.methodName = @"GetDocumentSignByUser";
        }
            break;
            case getCountDocumentSignInfo:
        {
            actionEvent.methodName = @"GetCountDocumentSignInfo";
        }
            break;
            
        case getDetailDocumentSignInfo:
        {
            actionEvent.methodName = @"GetDetailDocumentSignInfo";
        }
            break;
            
        case rejectSignDocumentInfo:
        {
            actionEvent.methodName = @"RejectSignDocumentInfo";
        }
            
            break;
            
        case getListMyTask:{
            actionEvent.methodName = @"GetListMyTask";
        }
            break;
            
        case searchTaskByICreate:
        {
            actionEvent.methodName = @"GetListTaskICreate";
        }
            break;
        case searchTaskByGroup:
        {
            actionEvent.methodName = @"GetListTaskAssignByGroup";
        }
            break;
            
        case searchTaskByLeader:
        {
            actionEvent.methodName = @"GetListTaskAssignByLeader";
        }
            break;
            
        case getTaskDetail:
        {
            actionEvent.methodName = @"GetTaskDetail";
        }
            break;
            
        case createOrEditTask:
            actionEvent.methodName = @"SendTaskToUserDepartment";
            break;
            
        case updateTaskProcess:{
            actionEvent.methodName = @"UpdateTaskProcess";
        }
            break;
        case countHomeData:
        {
            actionEvent.methodName = @"CountHomeData";
        }
            break;
            
        case getListDocumentInUserNoRead:
        {
           actionEvent.methodName = @"GetListDocumentInUserNoRead";
        }break;
        case staffSaveChangePassword:{
            actionEvent.methodName = @"ChangePassword";
        }
            break;
            
        case getPermission:{
            actionEvent.methodName = @"GetPermission";
        }
            break;
        case updateReadDocument:{
            actionEvent.methodName = @"UpdateReadDocument";
        }
            break;
        case deleteTask:{
            actionEvent.methodName = @"DeleteTask";
        }
            break;
        case normalDocumentSignInfo:{
            actionEvent.methodName = @"NormalDocumentSignInfo";
        }
            break;
        case getTaskHistory:{
            actionEvent.methodName = @"GetListTaskHistory";
        }
            break;
        case moveTask:{
            actionEvent.methodName = @"MoveTask";
        }
            break;
        case replyTask:{
            actionEvent.methodName = @"ReplyTask";
        }
            break;
        default:
            break;
    }
    [dic setObject:actionEvent.methodName forKey:@"method"];
	[dic setObject:postData forKey:@"dataPost"];
    
    NSLog(@"send request = %@", dic);
    [self sendRequetWithDictionary:dic andEvent:actionEvent];
    [dic release];
    
}
//Test
- (void) getJsonFromActionEvent: (ActionEvent*) actionEvent {
    HTTPResponse* response = [[HTTPResponse alloc] init];
    response.userData = actionEvent;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
	[dic setObject:@"200" forKey:@"errorCode"];
    [dic setObject:@"1" forKey:@"result"];
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	[params setObject:@"demo1" forKey:@"externalId"];
	[params setObject:@"demo2" forKey:@"type"];
	[dic setObject:params forKey:@"params"];
    [params release];
	NSMutableData *data = [NetworkUtils getJsonMutableDataWithObject:dic];
	[dic release];
    response.data = data;
    [self performSelector:@selector(onHttpReceivedData:) withObject:response afterDelay:2.0f];
    [response release];
}

- (void) sendRequetWithDictionary : (NSMutableDictionary *) dictionary andEvent : (ActionEvent*) actionEvent
{
#ifdef LOG_ERROR
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    actionEvent.json = [writer stringWithObject:dic];
    [writer release];
#endif
    
    NSMutableData *data = [NetworkUtils getJsonMutableDataWithObject:dictionary];
    HTTPRequest *req = [[HTTPRequest alloc] init] ;
    req.uri =[LogUtil getRequestPath];
    req.method = POST;
    
    //VOFFICE_REQUEST_PATH
    if(actionEvent.action == getConfigByKey){
        req.uri =[NSString stringWithFormat:@"%@%@", KEY_CONGIG_VOFFICE_PATH, actionEvent.methodName];
    }else{
        req.uri = [NSString stringWithFormat:@"%@%@", [LogUtil getRequestPath], actionEvent.methodName];
    }
    if ([req.uri containsString:@"(null)"]) {
        return;
    }
    NSLog(@"uri = %@", req.uri);
    
    if ([req.uri isEqualToString:[NSString stringWithFormat:@"%@%@", [LogUtil getRequestPath], @"(null)"]]) {
        [req release];
        return;
    }
    req.contentType = [NetworkUtils getJsonContentType];
    req.observer = self;
    req.data = data;
    req.userData = actionEvent;
    //[data release];
    //send network request (if has server)
    [[HTTPClient getHttpClient] request:req];
    //demo
    [req release];
}

#pragma mark send request



- (void) sentModelRequest:(ActionEvent *)actionEvent {
    
    NSMutableDictionary *dicViewData = (NSMutableDictionary*) actionEvent.viewData;
    if (actionEvent.action != login && actionEvent.action != none) {
        
//        if (![[dicViewData allKeys] containsObject:@"loginName"]) {
//            [dicViewData setObject:[LogUtil getUserName] forKey:@"loginName"];
//        }
        
        if ([[dicViewData allKeys] containsObject:USER_ID]) {
            [dicViewData removeObjectForKey:USER_ID];
        }
        
        if ([[dicViewData allKeys] containsObject:GROUP_ID]) {
            [dicViewData removeObjectForKey:GROUP_ID];
        }
        
        //[dicViewData setObject:[LogUtil getSessionId] forKey:SESSION_ID];
        
    }
    
    [self requestCommon:(ActionEvent*) actionEvent];
}


#pragma mark received data
- (void) onHttpReceivedData:(HTTPResponse *)httpResponse {
    ModelEvent *modelEvent = [[ModelEvent alloc] init];
    modelEvent.actionEvent = (ActionEvent*) httpResponse.userData;
    count = 0;
    NSString *json = [[NSString alloc] initWithData:httpResponse.data encoding:NSUTF8StringEncoding];
    NSDictionary *jsonValue = [json JSONValue];
    
    NSLog(@"result json = %@", json);
    
    NSDictionary *result = [jsonValue objectForKey:[NSString stringWithFormat:@"%@Result", modelEvent.actionEvent.methodName]];
    
    @try {
        
        if (modelEvent.actionEvent.action != login) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults synchronize];
            id  userData = [defaults objectForKey:USER_LOGIN];
            if (userData) {
                NSString  *userName = [userData objectForKey:FULL_LOGIN_NAME];
                NSString  *userId = ObjectToStr([userData objectForKey:USER_ID]) ;
//                NSString *deviceModel =[UIDevice getModel];
//                NSString *deviceSystemVersion =[[UIDevice currentDevice] systemVersion];
//                NSString *strTimeSend =[DateUtil formatDate:modelEvent.actionEvent.timeSend :@"dd/MM/yyyy HH:mm:ss.SSS"];
//                NSString *strTimeReceive =[DateUtil formatDate:[NSDate date] :@"dd/MM/yyyy HH:mm:ss.SSS"];
//                int lengOfFile =[json lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
                
                NSString *strNewLog = [NSString stringWithFormat:@"%@#%@#%@#%@#%@#%@#%@#%d \n",[UIDevice getModel],[[UIDevice currentDevice] systemVersion], userId,userName, modelEvent.actionEvent.methodName, [DateUtil formatDate:modelEvent.actionEvent.timeSend :@"dd/MM/yyyy HH:mm:ss.SSS"], [DateUtil formatDate:[NSDate date] :@"dd/MM/yyyy HH:mm:ss.SSS"], [json lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
                
                [LogUtil writeLogWithContent:strNewLog];
                
            }
        }
        
        
        if ([result isKindOfClass:[NSNull class]]) {
            [[AppController getController] handleErrorEvent:modelEvent];
        }else{
            NSNumber *code = [result objectForKey:@"errorCode"];
            modelEvent.modelCode = [code intValue];
            
            switch (modelEvent.actionEvent.action) {
                case login:
                {
                    modelEvent.modelData = result;
                    NSDictionary *response = [modelEvent.modelData objectForKey:@"response"];
                    NSString *fullName = [response objectForKey:@"fullName"];
                    
                    if ((modelEvent.modelCode == 200) && fullName!= nil) {
                        
                        
                        [[AppController getController] handleModelEvent:modelEvent];
                        
                    }
                    else
                    {
                        [[AppController getController] handleErrorEvent:modelEvent];
                    }
                    
                }
                    break;
                    case updateReadDocument:
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
        [json release];
         [modelEvent release];
    }
}

- (void) onHttpReceivedError:(HTTPResponse *)httpResponse :(NSString *)error {

    
    
    if (![error isKindOfClass:[NSNull class]] && error!=nil && [error isEqualToString:SYS_TimeOut]) {
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //thong bao het session va chay luon den form dang nhap
        FrameworkAppDelegate *appDel = (FrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
        RootViewController *rootView = [[RootViewController alloc] init];
        [appDel.window setRootViewController:rootView];
        [rootView release];
    }
    
    ModelEvent *modelEvent = [[ModelEvent alloc] init];
    modelEvent.actionEvent = (ActionEvent*) httpResponse.userData;
    
    switch (modelEvent.actionEvent.action) {
        case none:
            
        {
            
        }
            break;
            case updateReadDocument:
            break;
            
        default:
        {
            //tinh timesend
            //neu timesend = 30 chinh la cai gia tri connection timeout thi se thong bao luon la mat mang
            int numberSeconds = [[NSDate date] timeIntervalSinceDate:modelEvent.actionEvent.timeSend];
            
            
            if (count<=2 && numberSeconds<30) {
                count = count+1;
                [self performSelector:@selector(sentModelRequest:) withObject:modelEvent.actionEvent afterDelay:2.0];
            }
            else
            {
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                if ([[httpResponse.userData sender] isKindOfClass:[BaseViewController class]]) {
                    BaseViewController *baseView = (BaseViewController*) [httpResponse.userData sender];
                    [baseView displayNotConnectInternet];
                    count = 0;
                }
                else{
                    [LogUtil writeLogWithContent:[NSString stringWithFormat:@"Xảy ra lỗi : không ép được kiểu class = %@", [httpResponse.userData sender]]];
                }
                
            }

        }
            break;
    }
    
    [modelEvent release];
}


@end
