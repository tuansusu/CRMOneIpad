
#import <UIKit/UIKit.h>

@protocol FFCalendarViewControllerProtocol <NSObject>
@required
- (void)arrayUpdatedWithAllEvents:(NSMutableArray *)arrayUpdated;
@end

@interface FFCalendarViewController : UIViewController

@property (nonatomic, strong) id <FFCalendarViewControllerProtocol> protocol;
@property (nonatomic, strong) NSMutableArray *arrayWithEvents;

@property (nonatomic) enum DeviceType currentDeviceType;

@end
