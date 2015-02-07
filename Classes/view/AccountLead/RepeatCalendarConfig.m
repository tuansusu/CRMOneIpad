//
//  RepeatCalendarConfig.m
//  OfficeOneMB
//
//  Created by Duy Pham on 24/1/15.
//
//

#import "RepeatCalendarConfig.h"

@implementation RepeatCalendarConfig

- (instancetype)init
{
    if (self = [super init])
    {
        _isRepeat = false;
        _repeatDuration = 1;
        _repeatMode = OO_RepeatMode_Day;
        _repeatUntil = [NSDate date];
        
        _repeatWeekMon = false;
        _repeatWeekTue = false;
        _repeatWeekWed = false;
        _repeatWeekThu = false;
        _repeatWeekFri = false;
        _repeatWeekSat = false;
        _repeatWeekSun = false;
        
        _rpMonthRdIndexDay = true;
        _rpMonthDayOfWeek = 2;
        _rpMonthFirstDay = true;
        _rpMonthIndexDay = 1;
    }
    return self;
}

- (NSString *)toReadableText
{
    NSString * mode = @"";
    if (_repeatMode == OO_RepeatMode_Day)
    {
        mode = @"Ngày";
    }
    else if (_repeatMode == OO_RepeatMode_Week)
    {
        mode = @"Tuần";
    }
    else if (_repeatMode == OO_RepeatMode_Month)
    {
        mode = @"Tháng";
    }
    else if (_repeatMode == OO_RepeatMode_Year)
    {
        mode = @"Năm";
    }
    
    return [NSString stringWithFormat:@"%d %@", _repeatDuration, mode];
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary * dicEntity = [[NSMutableDictionary alloc] init];
    [dicEntity setObject:_isRepeat?@"1":@"0"                                      forKey:DTOTASK_isRepeat];
    [dicEntity setObject:[NSString stringWithFormat:@"%d", _repeatDuration]       forKey:DTOTASK_repeatDuration];
    [dicEntity setObject:[NSString stringWithFormat:@"%d", _repeatMode]           forKey:DTOTASK_repeatMode];
    [dicEntity setObject:[DateUtil formatDate:_repeatUntil :FORMAT_DATE_AND_TIME] forKey:DTOTASK_repeatUntil];
    [dicEntity setObject:_repeatWeekFri?@"1":@"0"                                 forKey:DTOTASK_repeatWeekFri];
    [dicEntity setObject:_repeatWeekMon?@"1":@"0"                                 forKey:DTOTASK_repeatWeekMon];
    [dicEntity setObject:_repeatWeekSat?@"1":@"0"                                 forKey:DTOTASK_repeatWeekSat];
    [dicEntity setObject:_repeatWeekSun?@"1":@"0"                                 forKey:DTOTASK_repeatWeekSun];
    [dicEntity setObject:_repeatWeekThu?@"1":@"0"                                 forKey:DTOTASK_repeatWeekThu];
    [dicEntity setObject:_repeatWeekTue?@"1":@"0"                                 forKey:DTOTASK_repeatWeekTue];
    [dicEntity setObject:_repeatWeekWed?@"1":@"0"                                 forKey:DTOTASK_repeatWeekWed];
    [dicEntity setObject:[NSString stringWithFormat:@"%d", _rpMonthDayOfWeek]     forKey:DTOTASK_rpMonthDayOfWeek];
    [dicEntity setObject:_rpMonthFirstDay?@"1":@"0"                               forKey:DTOTASK_rpMonthFirstDay];
    [dicEntity setObject:[NSString stringWithFormat:@"%d", _rpMonthIndexDay]      forKey:DTOTASK_rpMonthIndexDay];
    [dicEntity setObject:_rpMonthRdIndexDay?@"1":@"0"                             forKey:DTOTASK_rpMonthRdIndexDay];
    
    return dicEntity;
}

- (instancetype)initFromDictionary:(NSDictionary *)dictEntity
{
    if (self = [super init])
    {
        NSString * tempVar = [dictEntity objectForKey:DTOTASK_isRepeat];
        if (tempVar != nil) {
            _isRepeat = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_repeatDuration];
        if (tempVar != nil) {
            _repeatDuration = [tempVar intValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_repeatMode];
        if (tempVar != nil) {
            _repeatMode = [tempVar intValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_repeatUntil];
        if (tempVar != nil) {
            _repeatUntil = [DateUtil getDateFromString:tempVar :FORMAT_DATE_AND_TIME];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_repeatWeekFri];
        if (tempVar != nil) {
            _repeatWeekFri = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_repeatWeekMon];
        if (tempVar != nil) {
            _repeatWeekMon = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_repeatWeekSat];
        if (tempVar != nil) {
            _repeatWeekSat = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_repeatWeekSun];
        if (tempVar != nil) {
            _repeatWeekSun = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_repeatWeekThu];
        if (tempVar != nil) {
            _repeatWeekThu = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_repeatWeekTue];
        if (tempVar != nil) {
            _repeatWeekTue = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_repeatWeekWed];
        if (tempVar != nil) {
            _repeatWeekWed = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_rpMonthDayOfWeek];
        if (tempVar != nil) {
            _rpMonthDayOfWeek = [tempVar intValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_rpMonthFirstDay];
        if (tempVar != nil) {
            _rpMonthFirstDay = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_rpMonthIndexDay];
        if (tempVar != nil) {
            _rpMonthIndexDay = [tempVar intValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_rpMonthRdIndexDay];
        if (tempVar != nil) {
            _rpMonthRdIndexDay = [tempVar boolValue];
        }
        else { return nil; }
    }
    
    return self;
}

@end
