//
//  TaskCalendarCell.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import "TaskCalendarCell.h"

@implementation TaskCalendarCell
{
    __weak IBOutlet UILabel     *_titleLabel;
    __weak IBOutlet UILabel     *_startMonthLabel;
    __weak IBOutlet UILabel     *_startDateLabel;
    __weak IBOutlet UILabel     *_startTimeLabel;
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
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_title]])
    {
        _titleLabel.text = @"";
    }
    else
    {
        _titleLabel.text = [dicData objectForKey:DTOTASK_title];
    }
    
    NSString *strStartDate = [dicData objectForKey:DTOTASK_startDate];
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    
    NSDate *startDate = [DateFormatter dateFromString:strStartDate];
    
    [DateFormatter setDateFormat:@"MMM"];
    _startMonthLabel.text = [DateFormatter stringFromDate:startDate];
    [DateFormatter setDateFormat:@"dd"];
    _startDateLabel.text  = [DateFormatter stringFromDate:startDate];
    [DateFormatter setDateFormat:@"HH:mm"];
    _startTimeLabel.text  = [DateFormatter stringFromDate:startDate];
}
@end
