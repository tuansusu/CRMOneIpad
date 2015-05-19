//
//  FFDayHeaderCell.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/26/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>
#import "FFDayHeaderButton.h"
#import "EnumClass.h"

@interface FFDayHeaderCell : UICollectionViewCell

@property (nonatomic, strong) FFDayHeaderButton *button;
@property (nonatomic,strong) FFDayHeaderButton *button2;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) enum DeviceType currentDeviceType;

@end
