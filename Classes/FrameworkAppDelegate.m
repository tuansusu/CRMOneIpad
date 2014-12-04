//
//  IphoneFrameworkAppDelegate.m
//  IphoneFramework
//
//  Created by HieuNQ on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FrameworkAppDelegate.h"
#import "RootViewController.h"
#import "ReaderViewController.h"
#import "AppController.h"
#import "DataUtil.h"
#import "DTOEMPLOYEEACCOUNTProcess.h"
#import "DTOCONTACTProcess.h"
#import <GoogleMaps/GoogleMaps.h>
#import "SDKDemoAPIKey.h"


@implementation FrameworkAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize userToken;
@synthesize sessionId;
@synthesize callback;

#pragma mark -
#pragma mark Application lifecycle


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    callback(buttonIndex);
}

+ (void)showAlertView:(UIAlertView *)alertView
         withCallback:(AlertViewCompletionBlock)callback {
    __block FrameworkAppDelegate *delegate = [[FrameworkAppDelegate alloc] init];
    alertView.delegate = delegate;
    delegate.callback = ^(NSInteger buttonIndex) {
        callback(buttonIndex);
        alertView.delegate = nil;
        delegate = nil;
    };
  
    [alertView show];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    ////////////<<<<GOOGLE MAP>>>////////////////////
    
    if ([kAPIKey length] == 0) {
        // Blow up if APIKey has not yet been set.
        NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
        NSString *format = @"Configure APIKey inside SDKDemoAPIKey.h for your "
        @"bundle `%@`, see README.GoogleMapsSDKDemos for more information";
        @throw [NSException exceptionWithName:@"SDKDemoAppDelegate"
                                       reason:[NSString stringWithFormat:format, bundleId]
                                     userInfo:nil];
    }
    [GMSServices provideAPIKey:kAPIKey];
    services_ = [GMSServices sharedServices];
    
    // Log the required open source licenses!  Yes, just NSLog-ing them is not
    // enough but is good for a demo.
    NSLog(@"Open source licenses:\n%@", [GMSServices openSourceLicenseInfo]);
    ////////////<<<<GOOGLE MAP>>>////////////////////
    
    

    //SET COLOR IN STATUSBUAR
    self.window.backgroundColor = [UIColor whiteColor];
    [application setStatusBarStyle:UIBarStyleBlackTranslucent];
    
    //tuannv call copyDatabaseIfNeeded method
    [self copyDatabaseIfNeeded];
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    
    
    
    return YES;
}



- (void)setSample:(UIViewController *)sample {
    NSAssert([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad,
             @"Expected device to be iPad inside setSample:");
    
//    UINavigationController *nav =
//    [self.splitViewController.viewControllers objectAtIndex:1];
//    [nav setViewControllers:[NSArray arrayWithObject:sample] animated:NO];
}

- (UIViewController *)sample {
    NSAssert([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad,
             @"Expected device to be iPad inside sample");
    
//    UINavigationController *nav =
//    [self.splitViewController.viewControllers objectAtIndex:1];
//    return [[nav viewControllers] objectAtIndex:0];
    return nil;
}



-(void) showActivity{
    [SVProgressHUD show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */

    
    //logout when press Home button
   
//    NSUserDefaults *defaulst = [NSUserDefaults standardUserDefaults];
//    [defaulst setBool:NO forKey:@"initiated"];
//    [defaulst synchronize];
    
    //ReaderViewController *reader = [[ReaderViewController alloc] init];
    //[reader deleteFilesFromDocuments];
    //[self.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
    
    [SVProgressHUD dismiss];
    
   
}

+ (FrameworkAppDelegate *) getInstance {
	return (FrameworkAppDelegate *) [[UIApplication sharedApplication] delegate];
}

//NSOperationQueue *queue;
//NSTimer * timer;
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //xoa notification center
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
//    NSUserDefaults *defaulst = [NSUserDefaults standardUserDefaults];
//    [defaulst setBool:NO forKey:@"initiated"];
//    [defaulst synchronize];
    [SVProgressHUD dismiss];
    //NSLog(@"applicationDidBecomeActive");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
//    NSUserDefaults *defaulst = [NSUserDefaults standardUserDefaults];
//    [defaulst setBool:NO forKey:@"initiated"];
//    [defaulst synchronize];
   // NSLog(@"Voffice 2.0 - applicationWillTerminate");
    
    
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    // NSLog(@"Voffice 2.0 - applicationDidReceiveMemoryWarning");
    
    
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
    //xoa notification center
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//- (void)dealloc {
//	[navigationController release];
//	[window release];
//	[super dealloc];
//}
- (void) removeDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

//Ham dung de khoi tao 1 file database
- (void) copyDatabaseIfNeeded {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:Introduction_File_Pdf];
    
	//NSString *dbPath = [DataUtil getPathFileSqlLite];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Introduct_OfficeOne.pdf"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        
	}
    dbPath =  [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        
	}
    
    
    //Test data
    
    
    
//    DTOEMPLOYEEACCOUNTProcess *tableProcess = [[DTOEMPLOYEEACCOUNTProcess alloc]init];
//    NSMutableDictionary *dicEntity = [[NSMutableDictionary alloc]init];
//    //[dicEntity setValue:@"ID1" forKey:DTOEMPLOYEEACCOUNT_id];
//    [dicEntity setValue:@"9999" forKey:DTOEMPLOYEEACCOUNT_accountId];
//    BOOL insertOk =  [tableProcess insertToDBWithEntity:dicEntity];
//    NSLog(@"insert oko = %d", insertOk);
//    
//    //Lay du lieu
//    NSDictionary *dicGetEntity = [tableProcess getObjectWithDataID:@"10"];
//    NSLog(@"data dic = %@", dicGetEntity);
//    
//    NSLog(@"%@", [dicGetEntity objectForKey:DTOEMPLOYEEACCOUNT_id]);
    
//    DTOCONTACTProcess *contactProcess = [DTOCONTACTProcess new];
//    [contactProcess RenderDataField];
    
    
}




@end
