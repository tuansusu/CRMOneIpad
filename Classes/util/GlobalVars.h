//
//  GlobalVars.h
//  OfficeOneIpad
//
//  Created by viettel on 6/3/14.
//
//

#import <Foundation/Foundation.h>

@interface GlobalVars : NSObject{
    NSString *_siteUrl;
    NSString *_serviceUrl;
}
+ (GlobalVars *)sharedInstance;
@property(strong, nonatomic, readwrite) NSString *siteUrl;
@property(strong, nonatomic, readwrite) NSString *serviceUrl;

@end
