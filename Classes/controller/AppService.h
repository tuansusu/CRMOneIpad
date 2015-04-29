//
//  AppService.h
//  OfficeOneMB
//
//  Created by admin on 4/28/15.
//
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "ModelEvent.h"


@interface AppService : NSObject

+ (AppService*) getService;

- (void) sentModelRequest:(ActionEvent *)actionEvent;

@end
