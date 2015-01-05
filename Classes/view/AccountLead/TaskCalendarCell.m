//
//  TaskCalendarCell.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import "TaskCalendarCell.h"
#import "DateUtil.h"

@implementation TaskCalendarCell
{
    __weak IBOutlet UILabel     *_titleLabel;
    __weak IBOutlet UILabel     *_startMonthLabel;
    __weak IBOutlet UILabel     *_startDateLabel;
    __weak IBOutlet UILabel     *_startTimeLabel;
    
    NSDictionary *_dicData;
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"TaskCalendarCell" bundle:nil];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect
{
    _dicData = [dicData copy];
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_title]])
    {
        _titleLabel.text = @"";
    }
    else
    {
        _titleLabel.text = [dicData objectForKey:DTOTASK_title];
    }
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_startDate]])
    {
        NSString *startDateStr = [dicData objectForKey:DTOTASK_startDate];
        NSDate *startDate = [DateUtil getDateFromString:startDateStr :FORMAT_DATE_AND_TIME];
    
        _startMonthLabel.text = [DateUtil formatDate:startDate :@"MMM"];
        _startDateLabel.text  = [DateUtil formatDate:startDate :@"dd"];
        _startTimeLabel.text  = [DateUtil formatDate:startDate :@"HH:mm"];
    }
    else
    {
        _startMonthLabel.text = @"";
        _startDateLabel.text  = @"";
        _startTimeLabel.text  = @"";

    }
}

@end
