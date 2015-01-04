//
//  TaskOpportunityCell.m
//  OfficeOneMB
//
//  Created by viettel on 12/26/14.
//
//

#import "TaskOpportunityCell.h"
#import "DTOTASKProcess.h"

@implementation TaskOpportunityCell

- (void)awakeFromNib {
    // Initialization code
}




+(TaskOpportunityCell *)getNewCell
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TaskOpportunityCell" owner:nil options:nil];
    TaskOpportunityCell *cell;
    for (id currentObject in topLevelObjects)
    {
        if ([currentObject isKindOfClass:[TaskOpportunityCell class]])
        {
            cell= (TaskOpportunityCell *)currentObject;
            return cell;
        }
    }
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect {
    
    
    
    NSString *strEndDate = [dicData objectForKey:DTOTASK_endDate];
    if([[strEndDate substringFromIndex:11] isEqualToString:@"00:00:00.0"]){
        strEndDate =[strEndDate substringFromIndex:12];
    }else{
        strEndDate = [NSString stringWithFormat:@"%@ %@",[strEndDate substringToIndex:11],[[strEndDate substringFromIndex:11] substringToIndex:5]];
    }
    self.lblEndDate.text = strEndDate;
    
    switch (smgSelect) {
        case 1:
        {
            for (UIView *viewTemp in self.contentView.subviews) {
                if ([viewTemp isKindOfClass:[UILabel class]]) {
                    ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
                }
            }
            
            self.lbName.textColor = TEXT_COLOR_CELL_BOLD;
            
        }
            break;
            
        default:
            break;
    }
    

    if ([[dicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_COMPLETE) {
        //Complete
        [self.btnChangeStatus setImage:[UIImage imageNamed:@"task_done.png"] forState:UIControlStateNormal];
        NSDictionary* attributes = @{
                                     NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]
                                     };
        
        NSAttributedString* attrName = [[NSAttributedString alloc] initWithString:[dicData objectForKey:DTOTASK_title]  attributes:attributes];
        self.lbName.attributedText = attrName;
        
        NSAttributedString* attrEndDate = [[NSAttributedString alloc] initWithString:strEndDate  attributes:attributes];
        self.lblEndDate.attributedText = attrEndDate;
    }else if ([[dicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_NOT_COMPLETE){
        //InProgess
        [self.btnChangeStatus setImage:[UIImage imageNamed:@"task_not_done.png"] forState:UIControlStateNormal];
        self.lbName.text =  [dicData objectForKey:DTOTASK_title] ;
        self.lbName.textColor = TEXT_COLOR_HIGHLIGHT;
    }else{
        //Default is InProgess
        [self.btnChangeStatus setImage:[UIImage imageNamed:@"task_not_done.png"] forState:UIControlStateNormal];
        self.lbName.text =  [dicData objectForKey:DTOTASK_title] ;
        self.lbName.textColor = TEXT_COLOR_HIGHLIGHT;
    }
}

@end
