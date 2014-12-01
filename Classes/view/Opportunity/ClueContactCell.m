//
//  ClueContactCell.m
//  OfficeOneStudy
//
//  Created by viettel on 11/11/14.
//
//

#import "ClueContactCell.h"

@implementation ClueContactCell

- (void)awakeFromNib
{
    // Initialization code
}


+(ClueContactCell *)getNewCell
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ClueContactCell" owner:nil options:nil];
    ClueContactCell *cell;
    for (id currentObject in topLevelObjects)
    {
        if ([currentObject isKindOfClass:[ClueContactCell class]])
        {
            cell= (ClueContactCell *)currentObject;
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
    
    
    self.lbName.text = [dicData objectForKey:DTOACCOUNT_name];
    self.lbEmail.text = [dicData objectForKey:DTOACCOUNT_email];
    self.lbMobile.text = [dicData objectForKey:DTOACCOUNT_mobile];
    self.lbPosition.text = @"Thong tin chuc vu";
    
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
