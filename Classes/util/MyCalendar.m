//
//  MyCalendar.m
//  VofficeIpad2.0
//
//  Created by VTIT on 7/18/13.
//
//

#import "MyCalendar.h"
#import <EventKit/EventKit.h>

static EKEventStore *eventStore = nil;

@implementation MyCalendar

+(void) requestAccess:(void (^)(BOOL, NSError *))success{
    
    Boolean checkVersion = NO;
    //UIDevice *device = [[UIDevice alloc]init];
    float currSysVerInt = [UIDevice getCurrentSysVer];
    if (currSysVerInt>=6.0) {
        checkVersion = YES;
    }
    
    eventStore = [[EKEventStore alloc] init];
    NSUserDefaults *defaulst = [NSUserDefaults standardUserDefaults];
    BOOL initiated = [[defaulst objectForKey:@"initiated"] boolValue];
    if (!initiated) {
        if (checkVersion) {
            [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:success];
        }
        
        
        [defaulst setBool:YES forKey:@"initiated"];
        [defaulst synchronize];
    }
    
}

+(BOOL) addEventAt:(NSDate *)eventDate withEndEvent:(NSDate *)endEventDate withTitle:(NSString *)title inLocation:(NSString *)location withNotes:(NSString *)notes beforeAlarmMinute:(NSInteger)minute{
    
    Boolean checkVersion = NO;
    //UIDevice *device = [[UIDevice alloc]init];
    float currSysVerInt = [UIDevice getCurrentSysVer];
    if (currSysVerInt>=6.0) {
        checkVersion = YES;
    }
    
    
    if (checkVersion) {
        EKEvent *event = [EKEvent eventWithEventStore:eventStore];
        EKCalendar *calendar = nil;
        NSString *calendarIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:@"my_calendar_identifier"];
        
        // when identifier exists, my calendar probably already exists
        // note that user can delete my calendar. In that case I have to create it again.
        if (calendarIdentifier) {
            calendar = [eventStore calendarWithIdentifier:calendarIdentifier];
        }
        
        // calendar doesn't exist, create it and save it's identifier
        if (!calendar) {
            // http://stackoverflow.com/questions/7945537/add-a-new-calendar-to-an-ekeventstore-with-eventkit
            calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:eventStore];
            
            // set calendar name. This is what users will see in their Calendar app
            //[calendar setTitle:[KKCalendar calendarName]];
            [calendar setTitle:@"New Calendar"];
            
            
            // find appropriate source type. I'm interested only in local calendars but
            // there are also calendars in iCloud, MS Exchange, ...
            // look for EKSourceType in manual for more options
            for (EKSource *s in eventStore.sources) {
                if (s.sourceType == EKSourceTypeLocal) {
                    calendar.source = s;
                    break;
                }
            }
            
            // save this in NSUserDefaults data for retrieval later
            NSString *calendarIdentifier = [calendar calendarIdentifier];
            
            NSError *error = nil;
            BOOL saved = [eventStore saveCalendar:calendar commit:YES error:&error];
            if (saved) {
                // http://stackoverflow.com/questions/1731530/whats-the-easiest-way-to-persist-data-in-an-iphone-app
                // saved successfuly, store it's identifier in NSUserDefaults
                [[NSUserDefaults standardUserDefaults] setObject:calendarIdentifier forKey:@"my_calendar_identifier"];
            } else {
                // unable to save calendar
                return NO;
            }
        }
        
        // this shouldn't happen
        if (!calendar) {
            return NO;
        }
        
        // assign basic information to the event; location is optional
        event.calendar = calendar;
        event.location = location;
        event.title = title;
        event.notes = notes;
        
        
        // set the start date to the current date/time and the event duration to two hours
        NSDate *startDate = eventDate;
        event.startDate = startDate;
        event.endDate = endEventDate;
        //set alarm
        NSTimeInterval interval = -1*minute * 60;
        EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:interval];
        
        [event addAlarm:alarm];
        
        NSError *error = nil;
        // save event to the callendar
        BOOL result = [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&error];
        if (result) {
            return YES;
            
        } else {
            // unable to save event to the calendar
            return NO;
        }
    }else{
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEvent *event = [EKEvent eventWithEventStore:eventStore];
        
        event.location = location;
        event.title = title;
        event.notes = notes;
        
        
        // set the start date to the current date/time and the event duration to two hours
        NSDate *startDate = eventDate;
        event.startDate = startDate;
        event.endDate = endEventDate;
        //set alarm
        NSTimeInterval interval = -1*minute * 60;
        EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:interval];
        
        [event addAlarm:alarm];
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        
        if(err){
           // NSLog(@"unable to save event to the calendar!: Error= %@", err);
            return NO;
        }
        
        return YES;
        
    }
    
    
    
}




+ (BOOL)addEventAt:(NSDate*)eventDate withTitle:(NSString*)title inLocation:(NSString*)location
{
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    EKCalendar *calendar = nil;
    NSString *calendarIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:@"my_calendar_identifier"];
    
    // when identifier exists, my calendar probably already exists
    // note that user can delete my calendar. In that case I have to create it again.
    if (calendarIdentifier) {
        calendar = [eventStore calendarWithIdentifier:calendarIdentifier];
    }
    
    // calendar doesn't exist, create it and save it's identifier
    if (!calendar) {
        // http://stackoverflow.com/questions/7945537/add-a-new-calendar-to-an-ekeventstore-with-eventkit
        calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:eventStore];
        
        // set calendar name. This is what users will see in their Calendar app
        //        [calendar setTitle:[KKCalendar calendarName]];
        [calendar setTitle:@"New Calendar"];
        
        // find appropriate source type. I'm interested only in local calendars but
        // there are also calendars in iCloud, MS Exchange, ...
        // look for EKSourceType in manual for more options
        for (EKSource *s in eventStore.sources) {
            if (s.sourceType == EKSourceTypeLocal) {
                calendar.source = s;
                break;
            }
        }
        
        // save this in NSUserDefaults data for retrieval later
        NSString *calendarIdentifier = [calendar calendarIdentifier];
        
        NSError *error = nil;
        BOOL saved = [eventStore saveCalendar:calendar commit:YES error:&error];
        if (saved) {
            // http://stackoverflow.com/questions/1731530/whats-the-easiest-way-to-persist-data-in-an-iphone-app
            // saved successfuly, store it's identifier in NSUserDefaults
            [[NSUserDefaults standardUserDefaults] setObject:calendarIdentifier forKey:@"my_calendar_identifier"];
        } else {
            // unable to save calendar
            return NO;
        }
    }
    
    // this shouldn't happen
    if (!calendar) {
        return NO;
    }
    
    // assign basic information to the event; location is optional
    event.calendar = calendar;
    event.location = location;
    event.title = title;
    event.notes = location;
    
    
    // set the start date to the current date/time and the event duration to two hours
    NSDate *startDate = eventDate;
    event.startDate = startDate;
    event.endDate = [startDate dateByAddingTimeInterval:3600 * 2];
    //set alarm
    NSTimeInterval interval = -1*10 * 60;
    EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:interval];
    
    [event addAlarm:alarm];
    
    NSError *error = nil;
    // save event to the callendar
    BOOL result = [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&error];
    if (result) {
        return YES;
    } else {
        //NSLog(@"Error saving event: %@", error);
        // unable to save event to the calendar
        return NO;
    }
}


@end
