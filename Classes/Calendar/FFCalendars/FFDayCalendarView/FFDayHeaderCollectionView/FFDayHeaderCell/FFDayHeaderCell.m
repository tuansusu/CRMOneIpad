//
//  FFDayHeaderCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/26/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFDayHeaderCell.h"

#import "FFImportantFilesForCalendar.h"

@implementation FFDayHeaderCell

@synthesize button,button2;
@synthesize date;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSString *deviceName = [UIDevice currentDevice].model;
        if([deviceName isEqualToString:@"iPhone"] || [deviceName isEqualToString:@"iPhone Simulator"]){
            self.currentDeviceType = iPhone;
        }else{
            self.currentDeviceType = iPad;
        }
        
        
        
        if(self.currentDeviceType == iPad){
            button = [FFDayHeaderButton alloc];
            button.currentDeviceType = self.currentDeviceType;
            button.isSecondButton = NO;
            button = [button initWithFrame:CGRectMake(0., 0., self.frame.size.width, self.frame.size.height)];
            [self addSubview:button];
        }else{
            
            button = [FFDayHeaderButton alloc];
            button.currentDeviceType = self.currentDeviceType;
            button.isSecondButton = NO;
            button = [button initWithFrame:CGRectMake(0., 0., 20, 20)];
            [self addSubview:button];
            
            
            button2 = [FFDayHeaderButton alloc];
            button2.currentDeviceType = self.currentDeviceType;
            button2.isSecondButton = YES;
            button2 = [button2 initWithFrame:CGRectMake(0., 20.0, 20.0,20.0)];
            [self addSubview:button2];
            
        }
        [self setAutoresizingMask:AR_LEFT_RIGHT | UIViewAutoresizingFlexibleWidth];
    }
    return self;
}

- (void)setDate:(NSDate *)_date {
    
    date = _date;
    [button setDate:_date];
    [button2 setDate:_date];
}

@end
