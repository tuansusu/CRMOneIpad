//
//  TaskCalendarCell.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import "TaskCalendarCell.h"

@implementation TaskCalendarCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(TaskCalendarCell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TaskCalendarCell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[TaskCalendarCell class]])
        {
            return (TaskCalendarCell *) curentObject;
            
        }
    }
    
    return nil;
}


-(void) loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect{
    
    _dicData = dicData;
    _lbTitle.text=[dicData objectForKey:DTOTASK_title];
    _lbTime.text=[dicData objectForKey:DTOTASK_startDate];
    _lbTitle.textColor = TEXT_COLOR_HIGHLIGHT;
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
