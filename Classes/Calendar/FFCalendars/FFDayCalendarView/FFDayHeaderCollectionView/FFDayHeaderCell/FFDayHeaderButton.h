//
//  FFDayHeaderButton.h
//  FFCalendar
//
//  Created by Felipe Rocha on 19/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>
#import "EnumClass.h"

@interface FFDayHeaderButton : UIButton

@property (nonatomic, strong) NSDate *date;
@property (nonatomic) enum DeviceType currentDeviceType;
@property (nonatomic) BOOL isSecondButton; //For iPhone only

@end
