//
//  FFHeaderMonthForYearCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/13/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFHeaderMonthForYearCell.h"

#import "FFImportantFilesForCalendar.h"

@interface FFHeaderMonthForYearCell ()
@property (nonatomic, strong) UILabel *labelTitle;
@end

@implementation FFHeaderMonthForYearCell
{
    NSArray *arrayMonthTitle;
    NSArray *arrayWeekTitleCompact;
}

#pragma mark - Synthesize

@synthesize date;
@synthesize labelTitle;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    
    arrayMonthTitle =  @[LocalizedString(@"KEY_CALENDAR_JANUARY")
                             ,LocalizedString(@"KEY_CALENDAR_FEBRUARY")
                             ,LocalizedString(@"KEY_CALENDAR_MARCH")
                             ,LocalizedString(@"KEY_CALENDAR_APRIL")
                             ,LocalizedString(@"KEY_CALENDAR_MAY")
                             ,LocalizedString(@"KEY_CALENDAR_JUNE")
                             ,LocalizedString(@"KEY_CALENDAR_JULY")
                             ,LocalizedString(@"KEY_CALENDAR_AUGUST")
                             ,LocalizedString(@"KEY_CALENDAR_SEPTEMBER")
                             ,LocalizedString(@"KEY_CALENDAR_OCTOBER")
                             ,LocalizedString(@"KEY_CALENDAR_NOVEMBER")
                             ,LocalizedString(@"KEY_CALENDAR_DECEMBER")
                             ];
    
    arrayWeekTitleCompact = @[LocalizedString(@"KEY_CALENDAR_SUN")
                              ,LocalizedString(@"KEY_CALENDAR_MON")
                              ,LocalizedString(@"KEY_CALENDAR_TUE")
                              ,LocalizedString(@"KEY_CALENDAR_WED")
                              ,LocalizedString(@"KEY_CALENDAR_THU")
                              ,LocalizedString(@"KEY_CALENDAR_FRI")
                              ,LocalizedString(@"KEY_CALENDAR_SAT")
                              ];
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

#pragma mark - Custom Methods

- (void)addWeekLabelsWithSizeOfCells:(CGSize)sizeOfCells {
    
    if (!labelTitle) {
        
        CGFloat height = self.frame.size.height/4.;
        
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10., 0., self.frame.size.width, 3*height)];
        [labelTitle setTextColor:[UIColor redColor]];
        if(self.currentDeviceType == iPhone){
            [labelTitle setFont:[UIFont systemFontOfSize:12]];
        }
        [self addSubview:labelTitle];
        
    
        
        if(self.currentDeviceType == iPad){
            for (int i = 0; i < [arrayWeekTitleCompact count]; i++) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*sizeOfCells.width, labelTitle.frame.size.height, sizeOfCells.width, height)];
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setText:[arrayWeekTitleCompact objectAtIndex:i]];
                [label setTextColor:[UIColor blackColor]];
                if(_currentDeviceType == iPad){
                    [label setFont:[UIFont systemFontOfSize:14]];
                }else{
                    [label setFont:[UIFont systemFontOfSize:6]];
                }
                [self addSubview:label];
            }
        }
    }
    
    [labelTitle setText:[[arrayMonthTitle objectAtIndex:(date.componentsOfDate.month-1)] uppercaseString]];
    NSLog(labelTitle.text);
}


@end
