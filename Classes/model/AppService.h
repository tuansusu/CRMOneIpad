//
//  AppService.h
//  IphoneFramework
//
//  Created by Tran Van Bang on 5/2/13.
//
//
//

#import <Foundation/Foundation.h>
#import "AbstractModelService.h"
#import "HTTPClient.h"

@interface AppService : AbstractModelService {
    
    HTTPClient *httpClient;

}
////tuannv them thuoc tinh////
@property(nonatomic) NSInteger currentUserId ;

@property(nonatomic, retain) HTTPClient *httpClient;
+ (AppService*) getService;

@end
