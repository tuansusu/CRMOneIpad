//
//  VTLabel.m
//  OfficeOneBIDV
//
//  Created by viettel on 1/19/15.
//
//

#import "VTLabel.h"

@implementation VTLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 5, 0, 5};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}


@end
