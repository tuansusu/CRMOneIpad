//
//  Clock.h
//  StopWatch
//
//  Created by Tran Van Bang on 11/21/13.
//  Copyright (c) 2013 Tran Van Bang. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString *const TimeUpdatedNotification = @"timeUpdated";

@interface Clock : NSObject

- (void) stop;
- (void) start;
- (void) reset;
- (NSString *) timeString;

@property (assign, nonatomic) BOOL clockRunning;
@end
