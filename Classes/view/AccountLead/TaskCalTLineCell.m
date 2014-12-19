//
//  TaskCalTLineCell.m
//  OfficeOneMB
//
//  Created by Duy Pham on 12/13/14.
//
//

#import "TaskCalTLineCell.h"

@implementation TaskCalTLineCell
{
    __weak IBOutlet UILabel *_dateLabel;
    __weak IBOutlet UILabel *_timeLabel;
    __weak IBOutlet UILabel *_typeLabel;
    __weak IBOutlet UIImageView *_typeImage;
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_descLabel;
    __weak IBOutlet UILabel *_customerLabel;
}
+ (UINib *)nib
{
    return [UINib nibWithNibName:@"TaskCalTLineCell" bundle:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
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
    
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    _dateLabel.text = [DateFormatter stringFromDate:startDate];
    [DateFormatter setDateFormat:@"HH:mm"];
    _timeLabel.text  = [DateFormatter stringFromDate:startDate];
}

@end
