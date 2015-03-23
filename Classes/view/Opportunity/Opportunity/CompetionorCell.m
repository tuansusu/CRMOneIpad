//
//  CompetionorCell.m
//  OfficeOneStudy
//
//  Created by viettel on 11/10/14.
//
//

#import "CompetionorCell.h"

@implementation CompetionorCell

- (void)awakeFromNib
{
    
}

+(CompetionorCell *)getNewCell
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CompetionorCell" owner:nil options:nil];
    CompetionorCell *cell;
    for (id currentObject in topLevelObjects)
    {
        if ([currentObject isKindOfClass:[CompetionorCell class]])
        {
            cell= (CompetionorCell *)currentObject;
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
    
    
    self.lbName.text = [NSString stringWithFormat:@"%@ - %@", [dicData objectForKey:DTOCOMPETITOR_code], [dicData objectForKey:DTOCOMPETITOR_fullName]] ;
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCOMPETITOR_address]]) {
        self.lbDescription.text = @"Chưa nhập thông tin mô tả";
    }else{
        self.lbDescription.text = [dicData objectForKey:DTOCOMPETITOR_address];
    }
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCOMPETITOR_birthday]]) {
        self.lbTime.text = @"";
    }else{
        self.lbTime.text = [dicData objectForKey:DTOCOMPETITOR_birthday];
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


@end
