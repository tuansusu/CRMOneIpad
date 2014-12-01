//
//  Clock.m
//  StopWatch
//
//  Created by Tran Van Bang on 11/21/13.
//  Copyright (c) 2013 Tran Van Bang. All rights reserved.
//

#import "Clock.h"


static double const ClockTimeIncrement = 0.01;

@interface Clock ()

@property (retain, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSTimeInterval elapsedTime;
@property (retain, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation Clock

- (id) init {
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"HH:mm:ss.SS";
        _dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        _clockRunning = NO;
    }
    return self;
}

- (void) start {
    //NSLog(@"Alloc Timer");
    self.timer = [NSTimer scheduledTimerWithTimeInterval:ClockTimeIncrement
                                                  target:self
                                                selector:@selector(updateElapsedTime)
                                                userInfo:nil repeats:YES];
    self.clockRunning = YES;
    [self timeUpdated];
}

- (void) stop {
    //NSLog(@"Invaldate Timer");
    [self.timer invalidate];
    self.timer = nil;
    self.clockRunning = NO;
    [self timeUpdated];
}

- (void) reset {
    //NSLog(@"Reset Timer");
    self.elapsedTime = 0.0;
    [self timeUpdated];
}

- (NSString *) timeString {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.elapsedTime];
    return [self.dateFormatter stringFromDate:date];
}

- (void) updateElapsedTime {
    
    self.elapsedTime = self.elapsedTime + ClockTimeIncrement;
    
    //NSLog(@"timer - %f", self.elapsedTime);
    [self timeUpdated];
}

- (void) timeUpdated {
    [[NSNotificationCenter defaultCenter] postNotificationName:TimeUpdatedNotification object:nil];
}



@end
