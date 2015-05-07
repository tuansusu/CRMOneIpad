//
//  FFHeaderMonthForYearCell.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/13/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>
#import "EnumClass.h"

@interface FFHeaderMonthForYearCell : UICollectionReusableView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic) enum DeviceType currentDeviceType;

- (void)addWeekLabelsWithSizeOfCells:(CGSize)sizeOfCells;

@end
