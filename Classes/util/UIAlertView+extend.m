//
//  UIAlertView+extend.m
//  Voffice2.1
//
//  Created by VTIT on 10/9/13.
//
//

#import "UIAlertView+extend.h"

@implementation UIAlertView (extend)

-(void) initWithMessage:(NSString *)strMessage{
  //  self = [super init];
}

-(void) notificationWithMessage:(NSString *)strMessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_Invalid_InputData delegate:self cancelButtonTitle:SYS_Notification_ReInput otherButtonTitles: nil];
    [alert show];
}

@end
