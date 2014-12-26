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
    
//    _titleLabel.textColor = TEXT_COLOR_HIGHLIGHT;
    
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

//    
//    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCONTACT_fullName]]) {
//       // self.lbName.text = @"";
//        
//    }else{
//       // self.lbName.text = [dicData objectForKey:DTOCONTACT_fullName];
//    }
//    
//    
//    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCONTACT_mobile]]) {
//       // self.lbPhone.text = @"";
//        
//    }else{
//      //  self.lbPhone.text = [dicData objectForKey:DTOCONTACT_mobile];
//    }
//    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCONTACT_email]]) {
//       // self.lbEmail.text = @"";
//    }else{
//      //  self.lbEmail.text = [dicData objectForKey:DTOCONTACT_email];
//    }
//    
//    if// ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCONTACT_position]]) {
//        self.lbPosition.text = @"";
//    }else{
//      //  self.lbPosition.text = [dicData objectForKey:DTOCONTACT_position];
//    }
//    
//    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCONTACT_address]]) {
//      //  self.lbAddress.text = @"";
//    }else{
//       // self.lbAddress.text = [dicData objectForKey:DTOCONTACT_address];
//    }
//    
//    switch (smgSelect) {
//        case 1:
//        {
//            for (UIView *viewTemp in self.contentView.subviews) {
//                if ([viewTemp isKindOfClass:[UILabel class]]) {
//                    ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
//                }
//            }
//            self.lbName.textColor = TEXT_COLOR_HIGHLIGHT;
//        }
//            break;
//            
//        default:
//            break;
//    }
    

@end
