//
//  AlarmCalendarConfig.h
//  OfficeOneMB
//
//  Created by Duy Pham on 5/1/15.
//
//

#import <Foundation/Foundation.h>

@interface AlarmCalendarConfig : NSObject

@property (nonatomic, assign) BOOL isReminder;
@property (nonatomic, assign) BOOL reminderEmail;
@property (nonatomic, assign) BOOL reminderNofify;
@property (nonatomic, assign) BOOL reminderSMS;
@property (nonatomic, assign) NSUInteger reminderTime; // in minutes
//reminderUnit - minutes

- (NSString *)toReadableText;
- (NSDictionary *)toDictionary;
- (instancetype)initFromDictionary:(NSDictionary *)dictEntity;

@end
