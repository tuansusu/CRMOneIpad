//
//  RepeatCalendarConfig.h
//  OfficeOneMB
//
//  Created by Duy Pham on 24/1/15.
//
//

#import <Foundation/Foundation.h>
typedef enum
{
    OO_RepeatMode_Day,
    OO_RepeatMode_Week,
    OO_RepeatMode_Month,
    OO_RepeatMode_Year
}OO_RepeatMode;

@interface RepeatCalendarConfig : NSObject

@property (nonatomic, assign) BOOL isRepeat;
@property (nonatomic, assign) NSUInteger repeatDuration;
@property (nonatomic, assign) OO_RepeatMode /*NSUInteger*/ repeatMode;
@property (nonatomic, strong) NSDate * repeatUntil;
@property (nonatomic, assign) BOOL repeatWeekMon;
@property (nonatomic, assign) BOOL repeatWeekTue;
@property (nonatomic, assign) BOOL repeatWeekWed;
@property (nonatomic, assign) BOOL repeatWeekThu;
@property (nonatomic, assign) BOOL repeatWeekFri;
@property (nonatomic, assign) BOOL repeatWeekSat;
@property (nonatomic, assign) BOOL repeatWeekSun;
@property (nonatomic, assign) NSUInteger rpMonthDayOfWeek;
@property (nonatomic, assign) NSUInteger rpMonthFirstDay;
@property (nonatomic, assign) NSUInteger rpMonthIndexDay;
@property (nonatomic, assign) BOOL rpMonthRdFirstDay;
@property (nonatomic, assign) BOOL rpMonthRdIndexDay;

@end
