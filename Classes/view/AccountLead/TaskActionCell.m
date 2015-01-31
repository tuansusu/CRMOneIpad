//
//  TaskActionCell.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import "TaskActionCell.h"
#import "DTOTASKProcess.h"
#import "DateUtil.h"

@interface TaskActionCell ()

- (IBAction)actionChangeStatus:(id)sender;

@end

@implementation TaskActionCell
{
    __weak IBOutlet UILabel  *_nameLabel;
    __weak IBOutlet UILabel  *_endTimeLabel;
    __weak IBOutlet UIButton *_changeStatusBtn;
    
    NSMutableDictionary *_dicData;
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"TaskActionCell" bundle:nil];
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

- (void) loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect
{
    _dicData = [[NSMutableDictionary alloc]initWithDictionary:dicData];
    
    NSString *title      = @"";
    NSString *endDateStr = @"";
    NSDate   *endDate    = [NSDate date];
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_title]])
    {
        title = [dicData objectForKey:DTOTASK_title];
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_endDate]])
    {
        endDate    = [DateUtil getDateFromString:[dicData objectForKey:DTOTASK_endDate] :FORMAT_DATE_AND_TIME];
        endDateStr = [DateUtil formatDate:endDate :FORMAT_DATE];
    }
    
    if ([[dicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_COMPLETE)
    {
        [_changeStatusBtn setImage:[UIImage imageNamed:@"task_done.png"] forState:UIControlStateNormal];
        _nameLabel.attributedText    = [[NSAttributedString alloc] initWithString:title attributes:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:NSUnderlineStyleSingle] forKey:NSStrikethroughStyleAttributeName]];
        _endTimeLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Kết thúc %@",endDateStr] attributes:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:NSUnderlineStyleSingle] forKey:NSStrikethroughStyleAttributeName]];
    }
    else // if ([[dicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_NOT_COMPLETE)
    {
        [_changeStatusBtn setImage:[UIImage imageNamed:@"task_not_done.png"] forState:UIControlStateNormal];
        if (![StringUtil stringIsEmpty:endDateStr])
        {
            //kiểm tra xem trạng thái của công việc
            //check ngay ket thuc so voi ngay hien tai
            NSDate *endDate = [DateUtil getDateFromString:endDateStr :@"dd/MM/yyyy"];
            NSDate *nowDate = [NSDate date];
            if ([endDate compare:nowDate] == NSOrderedAscending)
            {
                // is overdue
                  _endTimeLabel.text      = [NSString stringWithFormat:@"Kết thúc %@",endDateStr];
             }
            else
            {
                 _endTimeLabel.text      = [NSString stringWithFormat:@"Kết thúc %@",endDateStr];
             }
        }
        else
        {
           _endTimeLabel.text      = @"";
        }
    }
    if (![StringUtil stringIsEmpty:endDateStr])
    {
        //kiểm tra xem trạng thái của công việc
        //check ngay ket thuc so voi ngay hien tai
        NSDate *endDate = [DateUtil getDateFromString:endDateStr :@"dd/MM/yyyy"];
        NSDate *nowDate = [NSDate date];
        if ([endDate compare:nowDate] == NSOrderedAscending)
        {
            // is overdue
            _nameLabel.text      = title;
            _nameLabel.textColor = TEXT_COLOR_RED;
            _endTimeLabel.textColor = TEXT_COLOR_RED;
        }
        else
        {
            _nameLabel.text      = title;
            _nameLabel.textColor = TEXT_COLOR_REPORT_TITLE_1;
           _endTimeLabel.textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }
    else
    {
        _nameLabel.text      = title;
        _nameLabel.textColor = TEXT_COLOR_REPORT_TITLE_1;
        _endTimeLabel.text      = @"";
        _endTimeLabel.textColor = TEXT_COLOR_REPORT_TITLE_1;
    }

//    switch (smgSelect) {
//        case 1:
//        {
//            for (UIView *viewTemp in self.contentView.subviews) {
//                if ([viewTemp isKindOfClass:[UILabel class]]) {
//                    ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
//                }
//            }
//            _nameLabel.textColor = TEXT_COLOR_HIGHLIGHT;
//        }
//            break;
//            
//        default:
//            break;
//    }
}

- (IBAction)actionChangeStatus:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(taskActionCell:changeStatusWithData:)])
    {
        [_delegate taskActionCell:self changeStatusWithData:_dicData];
    }
}

@end
