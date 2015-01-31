//
//  RepeatCalendarViewController.h
//  OfficeOneMB
//
//  Created by Duy Pham on 4/1/15.
//
//

#import <UIKit/UIKit.h>
#import "RepeatCalendarConfig.h"

@protocol RepeatCalendarViewDelegate;

@interface RepeatCalendarViewController : UIViewController

@property (nonatomic, assign) id <RepeatCalendarViewDelegate> delegate;
@property (nonatomic, strong) RepeatCalendarConfig *config;
@end

@protocol RepeatCalendarViewDelegate <NSObject>
@required

- (void)repeatCalendarView:(RepeatCalendarViewController *)repeatCalendarView confirmConfig:(RepeatCalendarConfig *)alarmCOnfig;
- (void)dismissPopoverView;

@end
