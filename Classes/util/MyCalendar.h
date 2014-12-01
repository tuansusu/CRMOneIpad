//
//  MyCalendar.h
//  VofficeIpad2.0
//
//  Created by tuannv on 7/18/13.
//
//

#import <Foundation/Foundation.h>
#import "UIDevice+extend.h"

@interface MyCalendar : NSObject
+ (void)requestAccess:(void (^)(BOOL granted, NSError *error))success;
//+ (BOOL)addEventAt:(NSDate*)eventDate withTitle:(NSString*)title inLocation:(NSString*)location;
+ (BOOL)addEventAt:(NSDate*)eventDate withEndEvent: (NSDate*) endEventDate withTitle:(NSString*)title inLocation:(NSString*)location withNotes: (NSString*) notes beforeAlarmMinute: (NSInteger)minute;


+ (BOOL)addEventAt:(NSDate*)eventDate withTitle:(NSString*)title inLocation:(NSString*)location;


@end
