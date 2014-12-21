//
//  TaskCalTLineCell.m
//  OfficeOneMB
//
//  Created by Duy Pham on 12/13/14.
//
//

#import "TaskCalTLineCell.h"

#define CALENDAR_T_HENGAP       1
#define CALENDAR_T_GOIDIEN      2
#define CALENDAR_T_EMAIL        4
#define CALENDAR_T_NGOAIBANHANG 6
#define CALENDAR_T_NGHIPHEP     7
#define CALENDAR_T_KHAC         5


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
    // title
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_title]])
    {
        _titleLabel.text = @"";
    }
    else
    {
        _titleLabel.text = [dicData objectForKey:DTOTASK_title];
    }
    // date+time
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_startDate]])
    {
        _dateLabel.text = @"";
        _timeLabel.text = @"";
    }
    else
    {
        NSString *strStartDate = [dicData objectForKey:DTOTASK_startDate];
        
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
        
        NSDate *startDate = [DateFormatter dateFromString:strStartDate];
        
        [DateFormatter setDateFormat:@"yyyy-MM-dd"];
        _dateLabel.text = [DateFormatter stringFromDate:startDate];
        [DateFormatter setDateFormat:@"HH:mm"];
        _timeLabel.text = [DateFormatter stringFromDate:startDate];
    }
    // type
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_formal]])
    {
        _typeLabel.text = @"";
        _typeImage.hidden = YES;
    }
    else
    {
        int type = [[dicData objectForKey:DTOTASK_formal] intValue];
        //TODO: set type image
        if (type == CALENDAR_T_HENGAP)
        {
            _typeLabel.text = @"Hẹn gặp";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        else if (type == CALENDAR_T_GOIDIEN)
        {
            _typeLabel.text = @"Gọi điện";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        else if (type == CALENDAR_T_EMAIL)
        {
            _typeLabel.text = @"Email";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        else if (type == CALENDAR_T_NGOAIBANHANG)
        {
            _typeLabel.text = @"Ngoài bán hàng";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        else if (type == CALENDAR_T_NGHIPHEP)
        {
            _typeLabel.text = @"Nghỉ phép";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        else
        {
            _typeLabel.text = @"Khác";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        
        _typeImage.hidden = NO;
    }
    // description
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_content]])
    {
        _descLabel.text = @"";
    }
    else
    {
        _descLabel.text = [dicData objectForKey:DTOTASK_content];
    }
    
    //TODO: customer name label?
    _customerLabel.text = @"";
}

@end
