//
//  FFRedAndWhiteButton.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFRedAndWhiteButton.h"

#import "FFImportantFilesForCalendar.h"

@implementation FFRedAndWhiteButton

- (id)initWithFrame:(CGRect)frame
{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        // Initialization code
        
        [self setFrame:frame];
        
        [self setTitleColor:TEXT_COLOR_HEADER_APP forState:UIControlStateNormal];
        [self setTitleColor:HEADER_VIEW_COLOR1 forState:UIControlStateSelected];
        
        [self setBackgroundImage:[UIImage imageWithColor:HEADER_VIEW_COLOR1] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:TEXT_COLOR_HEADER_APP] forState:UIControlStateSelected];
        
        [self.layer setBorderColor:HEADER_VIEW_COLOR1.CGColor];
        [self.layer setBorderWidth:1.];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setSelected:(BOOL)_selected {

    self.selected = _selected;
    
    if(_selected) {
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
    } else {
        [self.layer setBorderColor:HEADER_VIEW_COLOR1.CGColor];
    }
}

@end
