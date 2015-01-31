//
//  OpportunityCell.m
//  OfficeOneStudy
//
//  Created by ADMIN on 10/31/14.
//
//

#import "OpportunityLeadCell.h"
#import "UILabel+extend.h"
#import "NZLabel.h"

@implementation OpportunityLeadCell

- (void)awakeFromNib
{
    // Initialization code
}

+(OpportunityLeadCell *)getNewCell
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OpportunityLeadCell" owner:nil options:nil];
    OpportunityLeadCell *cell;
    for (id currentObject in topLevelObjects)
    {
        if ([currentObject isKindOfClass:[OpportunityLeadCell class]])
        {
            cell= (OpportunityLeadCell *)currentObject;
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

-(void) loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect{
    
    UIFont *boldFont = [UIFont fontWithName:SYSFONT_BOLD size:SYSFONT_SIZE_BIG];
    UIColor *blackColor = FONT_TEXT_HIGHLIGNT;

    self.lbName.text= [NSString stringWithFormat:@"%@ - %@",[dicData objectForKey:DTOOPPORTUNITY_id], [dicData objectForKey:DTOOPPORTUNITY_name]];
    self.lbName.textColor = TEXT_COLOR_HIGHLIGHT;
    
 
    if ([StringUtil stringIsEmpty:[dicData objectForKey:@"Contact"]]) {
        self.lbContact.text = @"Khách hàng chưa nhập";
    }else{
        self.lbContact.text= [NSString stringWithFormat:@"%@ - %@",[dicData objectForKey:@"Contact"], [dicData objectForKey:@"ContactCode"]];    }
    
    self.lbContact.textColor = TEXT_COLOR_CELL_BOLD;
    
    self.lbLevel.text = [dicData objectForKey:@"Level"];
    self.lbType.text = [dicData objectForKey:@"StatusName"];
 
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOOPPORTUNITY_endDate]]) {
        self.lbDate.text = [[dicData objectForKey:DTOOPPORTUNITY_endDate] substringToIndex:10];
    }else{
        self.lbDate.text = @"";
    }
    

    
    switch (smgSelect) {
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}


@end
