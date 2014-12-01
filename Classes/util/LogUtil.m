//
//  LogUtil.m
//  Voffice2.1
//
//  Created by VTIT on 9/10/13.
//
//

#import "LogUtil.h"
#import "DateUtil.h"

@implementation LogUtil

static NSString* sUserId;
static NSString* sUserName;
static  NSString* sRequestPath;

+(NSString*) createFileNameWithDate : (NSDate *) date{
    //Get the file path
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *textFileName = [NSString stringWithFormat:@"Log-%@.txt", [DateUtil formatDate:date :@"yyyy-MM-dd"]];
    
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:textFileName];
    //create file if it doesn't exist
    if(![[NSFileManager defaultManager] fileExistsAtPath:fileName])
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
    return fileName;
    
}
+(void) writeLogWithContent:(NSString *)content{
    
    NSString *fileName = [LogUtil createFileNameWithDate:[NSDate date]];
    //append text to file (you'll probably want to add a newline every write)
    NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:fileName];
    [file seekToEndOfFile];
    [file writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    [file closeFile];
}

+(void) writeLogWithException:(NSException *)ex{
    
    NSString *fileName = [LogUtil createFileNameWithDate:[NSDate date]];
    //append text to file (you'll probably want to add a newline every write)
    NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:fileName];
    [file seekToEndOfFile];
    [file writeData:[[ex description] dataUsingEncoding:NSUTF8StringEncoding]];
    [file closeFile];
}

+(NSString*) readLogWithDate:(NSDate *)date{
    return  @"";
}


+(NSString*) getUserName {
//    static dispatch_once_t onceToken = 0;
//    dispatch_once(&onceToken, ^{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults synchronize];
        id  userData = [defaults objectForKey:USER_LOGIN];
        if (userData) {
            sUserName = [userData objectForKey:FULL_LOGIN_NAME];
        }
        
    //});
    return sUserName;
}

+(NSString*) getUserId {
//    static dispatch_once_t onceToken = 0;
//    dispatch_once(&onceToken, ^{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults synchronize];
        id  userData = [defaults objectForKey:USER_LOGIN];
        if (userData) {
            sUserId = [userData objectForKey:USER_ID];
        }
    //});
    return sUserId;
}


//#define kRequestTokenURL        @"http://10.60.15.115:8009/Base.svc/oauth/request_token"
//#define kAuthorizeURL           @"http://10.60.15.115:8009/Base.svc/oauth/authorize"
//#define kAccessTokenURL         @"http://10.60.15.115:8009/Base.svc/oauth/access_token"
//
//#define ACTION_PATH             @"http://10.60.15.115:8009/Base.svc"
//#define VOFFICE_REQUEST_PATH    @"http://10.60.15.115:8009/Base.svc"

+(NSString*) getRequestPath {
    
    //return @"http://10.60.15.115:8009/Base.svc/";
    GlobalVars *globals = [GlobalVars sharedInstance];
  return   globals.serviceUrl;
    
//    
//    NSString* sRequestPathStr;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults synchronize];
//    id  userData = [defaults objectForKey:USER_CONFIG];
//    
//    if (userData) {
//        NSLog(@"getRequest path = %@", userData);
//        sRequestPathStr = [userData objectForKey:USER_CONFIG_SERVICES_URL];
//    }
//    return sRequestPathStr;
    
//        static dispatch_once_t onceToken = 0;
//        dispatch_once(&onceToken, ^{
//
//            });
    
    
//    ConfigProcess *configProcess = [[ConfigProcess alloc]init];
//    return [configProcess getConfigServicePath];
}

+(NSString*) getRequestSiteUrl {
    
    //return @"http://10.60.15.115:8009/Base.svc";
    
     NSString* sRequestPath;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults synchronize];
    id  userData = [defaults objectForKey:USER_CONFIG];
    if (userData) {
        sRequestPath = [userData objectForKey:USER_CONFIG_SITEURL];
    }
    return sRequestPath;
    
    
//    ConfigProcess *configProcess = [[ConfigProcess alloc]init];
//    return [configProcess getConfigSiteUrl];
}

+(NSString*) getActionPath {
    //return @"http://10.60.15.115:8009/Base.svc";
    
     NSString* sActionPath;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults synchronize];
    id  userData = [defaults objectForKey:USER_CONFIG];
    if (userData) {
        sActionPath = [userData objectForKey:USER_CONFIG_SERVICES_URL];
    }
    return  sActionPath;
    
//    ConfigProcess *configProcess = [[ConfigProcess alloc]init];
//    return [configProcess getConfigServicePath];
}

+(NSString*) getKAccessTokenURL {
    
    
     NSString* sKAccessTokenURL;
    
    //return @"http://10.60.15.115:8009/Base.svc/oauth/access_token";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   // [defaults synchronize];
    id  userData = [defaults objectForKey:USER_CONFIG];
    if (userData) {
        sKAccessTokenURL = [NSString stringWithFormat:@"%@/oauth/access_token",[userData objectForKey:USER_CONFIG_SERVICES_URL]] ;
    }
    
    return sKAccessTokenURL;
    
//    ConfigProcess *configProcess = [[ConfigProcess alloc]init];
//    return [NSString stringWithFormat:@"%@/oauth/access_token",[configProcess getConfigServicePath]] ;
}

+(NSString*) getKAuthorizeURL {
    
     NSString* sKAuthorizeURL;
    //return @"http://10.60.15.115:8009/Base.svc/oauth/authorize";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults synchronize];
    id  userData = [defaults objectForKey:USER_CONFIG];
    if (userData) {
        sKAuthorizeURL = [NSString stringWithFormat:@"%@/oauth/authorize",[userData objectForKey:USER_CONFIG_SERVICES_URL]] ;
    }
    return sKAuthorizeURL;
    
//    ConfigProcess *configProcess = [[ConfigProcess alloc]init];
//    return [NSString stringWithFormat:@"%@/oauth/authorize",[configProcess getConfigServicePath]] ;
    
}

+(NSString*) getKRequestTokenURL{
     NSString* sRequestTokenURL;
    //return @"http://10.60.15.115:8009/Base.svc/oauth/request_token";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults synchronize];
    id  userData = [defaults objectForKey:USER_CONFIG];
    if (userData) {
        sRequestTokenURL = [NSString stringWithFormat:@"%@/oauth/request_token",[userData objectForKey:USER_CONFIG_SERVICES_URL]] ;
    }
    return sRequestTokenURL;
    
//    ConfigProcess *configProcess = [[ConfigProcess alloc]init];
//    return [NSString stringWithFormat:@"%@/oauth/request_token",[configProcess getConfigServicePath]] ;
    
}

@end
