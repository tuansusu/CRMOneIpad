//
//  TaskActionCell.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import "TaskActionCell.h"
#import "DTOTASKProcess.h"



@implementation TaskActionCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(TaskActionCell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TaskActionCell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[TaskActionCell class]])
        {
            return (TaskActionCell *) curentObject;
            
        }
    }
    
    return nil;
}


-(void) loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect{
    
    _dicData = [[NSMutableDictionary alloc]initWithDictionary:dicData];
    
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_title]]) {
        self.lbName.text = @"";
        
    }else{
        self.lbName.text = [dicData objectForKey:DTOTASK_title];
    }
    
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_endDate]]) {
        self.lbTime.text = @"";
    }else{
        NSLog(@"date = %@", [dicData objectForKey:DTOTASK_endDate]);
        self.lbTime.text = [NSString stringWithFormat:@"Kết thúc %@",[dicData objectForKey:DTOTASK_endDate] ] ;
    }
    
    
    //kiểm tra xem trạng thái của công việc
    //check ngay ket thuc so voi ngay hien tai
    //[DateUtil dateDiffrenceFromDate:@"" second:@""];
    
//    int diffDay = [DateUtil dateDiffrenceFromDate:endDate second:nowStr];
//    if (diffDay>0 && (iStatusField==DANG_THUC_HIEN || iStatusField==QUA_HAN)) {
//        lbQuaHan.hidden = NO;
//        lbQuaHan.text = [NSString stringWithFormat:@"Đã quá hạn %d ngày",diffDay];
//    }
//    else
//    {
//        lbQuaHan.hidden = YES;
//    }
    
    if ([[dicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_COMPLETE) {
        [self.btnChangeStatus setImage:[UIImage imageNamed:@"task_done.png"] forState:UIControlStateNormal];
        
    //chu gach ngang
        
    }else if ([[dicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_NOT_COMPLETE){
        //chua thuc hien
        [self.btnChangeStatus setImage:[UIImage imageNamed:@"task_not_done.png"] forState:UIControlStateNormal];
    }else{
        //qua han
        [self.btnChangeStatus setImage:[UIImage imageNamed:@"task_not_done.png"] forState:UIControlStateNormal];
        
        //chua mau do
        
    }
    
    switch (smgSelect) {
        case 1:
        {
            for (UIView *viewTemp in self.contentView.subviews) {
                if ([viewTemp isKindOfClass:[UILabel class]]) {
                    ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
                }
            }
            self.lbName.textColor = TEXT_COLOR_HIGHLIGHT;
        }
            break;
            
        default:
            break;
    }
    
}

-(void) actionChangeStatus:(id)sender{
     [_delegate AccountLeadCellDelegate_ActionChangeTaskStatusWithData:_dicData];
    //
    
    
    
}

@end
