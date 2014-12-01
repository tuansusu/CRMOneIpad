//
//  AppController.h
//  IphoneFramework
//
//  Created by Tran Van Bang on 5/2/13.
//
//
//

#import <Foundation/Foundation.h>
#import "ActionEvent.h"
#import "ModelEvent.h"

@interface AppController : NSObject {

}

+ (AppController*) getController;
- (void) handleModelEvent:(ModelEvent*) modelEvent;
- (void) handleViewEvent:(ActionEvent *)action;
- (void) handleErrorEvent:(ModelEvent*) modelEvent;
- (void) handleInternetErrorEvent:(ModelEvent*) modelEvent;
@end
