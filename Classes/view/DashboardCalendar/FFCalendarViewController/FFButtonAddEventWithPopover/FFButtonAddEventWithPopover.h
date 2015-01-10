

#import <UIKit/UIKit.h>

#import "FFEvent.h"

@protocol FFButtonAddEventWithPopoverProtocol <NSObject>
@required
- (void)addNewEvent:(FFEvent *)eventNew;
@end

@interface FFButtonAddEventWithPopover : UIButton

@property (nonatomic, strong) id<FFButtonAddEventWithPopoverProtocol> protocol;

@end
