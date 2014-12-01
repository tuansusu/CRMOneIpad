    //
//  main.m
//  IphoneFramework
//
//  Created by HieuNQ on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

//#import <UIKit/UIKit.h>
//
//int main(int argc, char *argv[]) {
//    
//    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
//    int retVal = UIApplicationMain(argc, argv, nil, nil);
//    [pool release];
//    return retVal;
//}
#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    @try {
        @autoreleasepool {
            int retVal = UIApplicationMain(argc, argv, nil, nil);
            return retVal;
        }
    }
    @catch (NSException *exception) {
        [LogUtil writeLogWithContent:@"main"];
        [LogUtil writeLogWithException:exception];
    }
}