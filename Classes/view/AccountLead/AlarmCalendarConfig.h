//
//  AlarmCalendarConfig.h
//  OfficeOneMB
//
//  Created by Duy Pham on 5/1/15.
//
//

#import <Foundation/Foundation.h>

@interface AlarmCalendarConfig : NSObject

@property (nonatomic, assign) NSTimeInterval alarmInterval;// always negative - alarm before event
@property (nonatomic, assign) BOOL emailAlarm;
@property (nonatomic, assign) BOOL smsAlarm;
@property (nonatomic, assign) BOOL notifAlarm;
@end
