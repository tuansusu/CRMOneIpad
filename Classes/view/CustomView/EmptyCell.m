//
//  EmptyCell.m
//  OfficeOneMB
//
//  Created by viettel on 1/25/15.
//
//

#import "EmptyCell.h"

@implementation EmptyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(EmptyCell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EmptyCell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[EmptyCell class]])
        {
            return (EmptyCell *) curentObject;
            
        }
    }
    
    return nil;
}

-(void) loadDataToCellWithData : (NSString*) textToDisplay withOption : (int) smgSelect {
    switch (smgSelect) {
        case 1:
        {
            for (UIView *viewTemp in self.contentView.subviews) {
                if ([viewTemp isKindOfClass:[UILabel class]]) {
                    ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

@end
