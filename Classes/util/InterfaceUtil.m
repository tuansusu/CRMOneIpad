//
//  InterfaceUtil.m
//  Voffice2.1
//
//  Created by Tran Van Bang on 8/19/13.
//
//

#import "InterfaceUtil.h"
#import <QuartzCore/QuartzCore.h>



@implementation InterfaceUtil

+(void) setBorderWithCornerAndBorder : (UIView *) view : (float) corner : (float) border : (UIColor *) color
{
    view.layer.cornerRadius = corner;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = border;
}

@end
