//
//  Calendar360Cell.m
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/22/14.
//
//

#import "Calendar360Cell.h"

@implementation Calendar360Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(Calendar360Cell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Calendar360Cell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[Calendar360Cell class]])
        {
            return (Calendar360Cell *) curentObject;
            
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
                
                if ([viewTemp isKindOfClass:[UIImageView class]]) {
                    [((UIImageView*) viewTemp) setAlpha:1.0f];
                    continue;
                }
                
                if ([viewTemp isKindOfClass:[UILabel class]]) {
                    ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
                }
            }
            _lbTitle.textColor = TEXT_COLOR_HIGHLIGHT;
        }
            break;
            
        default:
            break;
    }
    
    
}

@end
