//
//  RepeatCalendarConfig.m
//  OfficeOneMB
//
//  Created by Duy Pham on 24/1/15.
//
//

#import "RepeatCalendarConfig.h"

@implementation RepeatCalendarConfig

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
@end
