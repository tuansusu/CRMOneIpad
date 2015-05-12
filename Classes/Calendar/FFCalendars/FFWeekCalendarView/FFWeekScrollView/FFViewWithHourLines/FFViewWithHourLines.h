//
//  FFViewWithHourLines.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/21/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>
#import "EnumClass.h"

@interface FFViewWithHourLines : UIView

@property (nonatomic, strong) UILabel *labelWithSameYOfCurrentHour;
@property (nonatomic) CGFloat totalHeight;
@property (nonatomic) enum DeviceType currentDeviceType;

- (UILabel *)labelWithCurrentHourWithWidth:(CGFloat)_width;
- (void)reloadLabelRedAndShow:(BOOL)show;

@end
