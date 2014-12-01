//
//  UIDevice+extend.h
//  Voffice2.1
//
//  Created by VTIT on 10/4/13.
//
//

#import <UIKit/UIKit.h>
#import <UIKit/UIViewController.h>

@interface UIDevice (extend)
+ (NSString* ) getModel;
+ (CGSize) getScreenSize;
+ (float) getCurrentSysVer;

+(void) updateLayoutInIOs7OrAfter : (UIViewController *)viewController;


+ (NSString *) macAddress:(NSString *)delimiter;
+ (NSString *)uniqueDeviceIdentifier;

@end
