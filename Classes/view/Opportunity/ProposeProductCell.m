//
//  ProposeProductCell.m
//  OfficeOneStudy
//
//  Created by viettel on 11/10/14.
//
//

#import "ProposeProductCell.h"

@implementation ProposeProductCell

- (void)awakeFromNib
{
    // Initialization code
}

+(ProposeProductCell *)getNewCell
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ProposeProductCell" owner:nil options:nil];
    ProposeProductCell *cell;
    for (id currentObject in topLevelObjects)
    {
        if ([currentObject isKindOfClass:[ProposeProductCell class]])
        {
            cell= (ProposeProductCell *)currentObject;
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
    
    
    self.lbName.text = [NSString stringWithFormat:@"%@ - %@", [dicData objectForKey:DTOOPPORTUNITYPRODUCT_clientOpportunityProductId], [dicData objectForKey:DTOPRODUCTMASTER_name]] ;
    
    self.lbMoney2.text = [dicData objectForKey:DTOOPPORTUNITYPRODUCT_revenue]; //@"500 000 000 đ";
    
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
