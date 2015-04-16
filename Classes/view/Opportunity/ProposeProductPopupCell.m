//
//  ProposeProductPopupCell.m
//  OfficeOneMB
//
//  Created by viettel on 4/16/15.
//
//

#import "ProposeProductPopupCell.h"

@implementation ProposeProductPopupCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(ProposeProductPopupCell *)getNewCell
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ProposeProductPopupCell" owner:nil options:nil];
    ProposeProductPopupCell *cell;
    for (id currentObject in topLevelObjects)
    {
        if ([currentObject isKindOfClass:[ProposeProductPopupCell class]])
        {
            cell= (ProposeProductPopupCell *)currentObject;
            return cell;
        }
    }
    return nil;
}



-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect {
    
    
    self.lbName.text = [NSString stringWithFormat:@"%@ - %@", [dicData objectForKey:DTOOPPORTUNITYPRODUCT_clientOpportunityProductId], [dicData objectForKey:DTOPRODUCTMASTER_name]] ;
    
    self.lbMoney2.text = [NSString stringWithFormat:@"%@ %@",[dicData objectForKey:DTOOPPORTUNITYPRODUCT_revenue],[dicData objectForKey:DTOSYSCAT_code]]; //@"500 000 000 đ";
    
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
}


@end
