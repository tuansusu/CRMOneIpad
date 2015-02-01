//
//  AlarmCalendarConfig.m
//  OfficeOneMB
//
//  Created by Duy Pham on 5/1/15.
//
//

#import "AlarmCalendarConfig.h"

@implementation AlarmCalendarConfig

- (NSString *)toReadableText
{
    NSMutableArray * strComponents = [[NSMutableArray alloc] initWithCapacity:3];
    if (_reminderEmail)
    {
        [strComponents addObject:@"Email"];
    }
    else if (_reminderNofify)
    {
        [strComponents addObject:@"Hiển thị thông báo"];
    }
    else if (_reminderSMS)
    {
        [strComponents addObject:@"SMS"];
    }

    return [strComponents componentsJoinedByString:@","];
}
@end
