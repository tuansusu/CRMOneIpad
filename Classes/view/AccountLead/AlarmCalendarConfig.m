//
//  AlarmCalendarConfig.m
//  OfficeOneMB
//
//  Created by Duy Pham on 5/1/15.
//
//

#import "AlarmCalendarConfig.h"

@implementation AlarmCalendarConfig

- (instancetype)init
{
    if (self = [super init])
    {
        _isReminder = FALSE;
        _reminderEmail = FALSE;
        _reminderSMS   = FALSE;
        _reminderNofify= TRUE;
        _reminderTime  = 15;
    }
    return self;
}

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

- (NSDictionary *)toDictionary
{
    NSMutableDictionary * dicEntity = [[NSMutableDictionary alloc] init];
    [dicEntity setObject:_isReminder?@"1":@"0"                            forKey:DTOTASK_isReminder];
    [dicEntity setObject:_reminderEmail?@"1":@"0"                         forKey:DTOTASK_reminderEmail];
    [dicEntity setObject:_reminderNofify?@"1":@"0"                        forKey:DTOTASK_reminderNofify];
    [dicEntity setObject:_reminderSMS?@"1":@"0"                           forKey:DTOTASK_reminderSMS];
    [dicEntity setObject:[NSString stringWithFormat:@"%d", _reminderTime] forKey:DTOTASK_reminderTime];
    //reminderUnit ??
    
    return dicEntity;
}

- (instancetype)initFromDictionary:(NSDictionary *)dictEntity
{
    if (self = [super init])
    {
        NSString * tempVar = [dictEntity objectForKey:DTOTASK_isReminder];
        if (tempVar != nil) {
            _isReminder = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_reminderEmail];
        if (tempVar != nil) {
            _reminderEmail = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_reminderNofify];
        if (tempVar != nil) {
            _reminderNofify = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_reminderSMS];
        if (tempVar != nil) {
            _reminderSMS = [tempVar boolValue];
        }
        else { return nil; }
        
        tempVar = [dictEntity objectForKey:DTOTASK_reminderTime];
        if (tempVar != nil) {
            _reminderTime = [tempVar intValue];
        }
        else { return nil; }
    }
    
    return self;
}
@end
