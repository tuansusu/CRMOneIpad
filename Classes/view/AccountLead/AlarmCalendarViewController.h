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

@property (nonatomic, assign) id <AlarmCalendarViewDelegate> delegate;
@property (nonatomic, strong) AlarmCalendarConfig *config;
@end

@protocol AlarmCalendarViewDelegate <NSObject>
@required

- (void)alarmCalendarView:(AlarmCalendarViewController *)alarmCalendarView confirmConfig:(AlarmCalendarConfig *)alarmCOnfig;
- (void) dismissPopoverView;

@end
