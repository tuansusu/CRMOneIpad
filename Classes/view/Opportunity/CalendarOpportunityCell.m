//
//  Calendar360Cell.m
//  OfficeOneMB
//
//
//
//

#import "CalendarOpportunityCell.h"

@implementation CalendarOpportunityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CalendarOpportunityCell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CalendarOpportunityCell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[CalendarOpportunityCell class]])
        {
            return (CalendarOpportunityCell *) curentObject;
            
        }
    }
    
    return nil;
}


-(void) loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect{
    
    _dicData = dicData;
    _lbTitle.text=[dicData objectForKey:DTOTASK_title];
    _lbTime.text=[dicData objectForKey:DTOTASK_startDate];
    
    switch (smgSelect) {
        case 1:
        {
            for (UIView *viewTemp in self.contentView.subviews) {
                if ([viewTemp isKindOfClass:[UILabel class]]) {
                    ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
                }
                
                
                if ([viewTemp isKindOfClass:[UIImageView class]]) {
                    [((UIImageView*) viewTemp) setAlpha:1.0f];
                }
            }
            
        }
            break;
            
        default:
            break;
    }
    
    _lbTitle.textColor = TEXT_COLOR_HIGHLIGHT;
}

@end
