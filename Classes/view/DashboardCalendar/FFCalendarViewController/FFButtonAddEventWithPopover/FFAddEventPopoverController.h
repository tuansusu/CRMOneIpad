

#import <UIKit/UIKit.h>

#import "FFEvent.h"

@protocol FFAddEventPopoverControllerProtocol <NSObject>
@required
- (void)addNewEvent:(FFEvent *)eventNew;
@end


@interface FFAddEventPopoverController : UIPopoverController

@property (nonatomic, strong) id<FFAddEventPopoverControllerProtocol> protocol;

- (id)initPopover;

@end
