//
//  FFMonthHeaderView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/18/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFMonthHeaderView.h"

#import "FFImportantFilesForCalendar.h"

@implementation FFMonthHeaderView
{
    NSArray *arrayWeekAbrev;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        arrayWeekAbrev =  @[LocalizedString(@"KEY_CALENDAR_SUN")
                            ,LocalizedString(@"KEY_CALENDAR_MON")
                            ,LocalizedString(@"KEY_CALENDAR_TUE")
                            ,LocalizedString(@"KEY_CALENDAR_WED")
                            ,LocalizedString(@"KEY_CALENDAR_THU")
                            ,LocalizedString(@"KEY_CALENDAR_FRI")
                            ,LocalizedString(@"KEY_CALENDAR_SAT")
                            ];
        
        NSArray *arrayColor = @[[UIColor grayColor], [UIColor blackColor], [UIColor blackColor], [UIColor blackColor], [UIColor blackColor], [UIColor blackColor], [UIColor grayColor]];
        CGFloat width = (self.frame.size.width-6*SPACE_COLLECTIONVIEW_CELL)/7.;
        
        for (int i = 0; i < [arrayWeekAbrev count]; i++) {

            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*(width+SPACE_COLLECTIONVIEW_CELL), 0., width-5., self.frame.size.height)];
            [label setTextAlignment:NSTextAlignmentRight];
            [label setText:[arrayWeekAbrev objectAtIndex:i]];
            [label setTextColor:[arrayColor objectAtIndex:i]];
            if(self.currentDeviceType == iPad){
                [label setFont:[UIFont systemFontOfSize:label.font.pointSize]];
            }else{
                [label setFont:[UIFont systemFontOfSize:12]];
            }
            [label setAutoresizingMask:AR_LEFT_RIGHT | UIViewAutoresizingFlexibleWidth];
            [self addSubview:label];
        }

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

@end
