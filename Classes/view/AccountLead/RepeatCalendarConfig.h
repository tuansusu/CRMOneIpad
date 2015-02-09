//
//  RepeatCalendarConfig.h
//  OfficeOneMB
//
//  Created by Duy Pham on 24/1/15.
//
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
typedef enum
{
    OO_RepeatMode_Day = 0,
    OO_RepeatMode_Week = 1,
    OO_RepeatMode_Month = 2,
    OO_RepeatMode_Year = 3
}OO_RepeatMode;

@interface RepeatCalendarConfig : NSObject

@property (nonatomic, assign) BOOL isRepeat; /* enabled/disabled */
//@property (nonatomic, assign) BOOL isRecurrence; //??
@property (nonatomic, assign) NSUInteger repeatDuration; /* Interval */
@property (nonatomic, assign) OO_RepeatMode /* NSUInteger */ repeatMode;
@property (nonatomic, strong) NSDate * repeatUntil; /* end Date */

/* mode week */
@property (nonatomic, assign) BOOL repeatWeekMon;
@property (nonatomic, assign) BOOL repeatWeekTue;
@property (nonatomic, assign) BOOL repeatWeekWed;
@property (nonatomic, assign) BOOL repeatWeekThu;
@property (nonatomic, assign) BOOL repeatWeekFri;
@property (nonatomic, assign) BOOL repeatWeekSat;
@property (nonatomic, assign) BOOL repeatWeekSun;
/* mode month */
@property (nonatomic, assign) NSUInteger rpMonthDayOfWeek; /* 1 for sunday, 2-7 for weekday */
@property (nonatomic, assign) BOOL rpMonthFirstDay; /* first or last day */
@property (nonatomic, assign) NSUInteger rpMonthIndexDay; //?? SMALLINT
@property (nonatomic, assign) BOOL rpMonthRdIndexDay; //?? INTEGER // currently true - repeatMonthDate, false - repeat month weekday

//@property (nonatomic, assign) BOOL rpMonthRdFirstDay; //?? INTEGER


- (NSString *)toReadableText;
- (NSDictionary *)toDictionary;
- (instancetype)initFromDictionary:(NSDictionary *)dictEntity;

- (EKRecurrenceRule *)toEKRecurrenceRule;

@end
