//
//  AlarmCalendarViewController.h
//  OfficeOneMB
//
//  Created by Duy Pham on 4/1/15.
//
//

#import <UIKit/UIKit.h>
#import "AlarmCalendarConfig.h"

@protocol AlarmCalendarViewDelegate;

@interface AlarmCalendarViewController : UIViewController

@property (nonatomic, assign) BOOL configEnable;
@property (nonatomic, strong) AlarmCalendarConfig *config;
@end

@protocol AlarmCalendarViewDelegate <NSObject>
@required

- (void)alarmCalendarView:(AlarmCalendarViewController *)alarmCalendarView confirmEnable:(BOOL)isEnable config:(AlarmCalendarConfig *)alarmCOnfig;
@end
