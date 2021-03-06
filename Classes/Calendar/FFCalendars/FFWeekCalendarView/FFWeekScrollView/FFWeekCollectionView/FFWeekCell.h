//
//  FFWeekCell.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/22/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>
#import "FFEvent.h"
#import "EnumClass.h"

@protocol FFWeekCellProtocol <NSObject>
@required
-(void)showEditEventCalendarWithEvent:(FFEvent *)_event;

- (void)saveEditedEvent:(FFEvent *)eventNew ofCell:(UICollectionViewCell *)cell atIndex:(NSInteger)intIndex;
- (void)deleteEventOfCell:(UICollectionViewCell *)cell atIndex:(NSInteger)intIndex;
@end

@interface FFWeekCell : UICollectionViewCell

@property (nonatomic, strong) id<FFWeekCellProtocol>protocol;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) enum DeviceType currentDeviceType;

- (void)clean;

- (void)showEvents:(NSArray *)array;

@end
