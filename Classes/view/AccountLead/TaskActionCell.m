//
//  TaskActionCell.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import "TaskActionCell.h"

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
    
    _dicData = dicData;
    
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_title]]) {
        self.lbName.text = @"";
        
    }else{
        self.lbName.text = [dicData objectForKey:DTOTASK_title];
    }
    
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_endDate]]) {
        self.lbTime.text = @"";
        
    }else{
        self.lbTime.text = [dicData objectForKey:DTOTASK_endDate];
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
}

@end
