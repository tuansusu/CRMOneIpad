//
//  OpportunityCell.m
//  OfficeOneStudy
//
//  Created by ADMIN on 10/31/14.
//
//

#import "OpportunityCell.h"
#import "UILabel+extend.h"
#import "NZLabel.h"

@implementation OpportunityCell

- (void)awakeFromNib
{
    // Initialization code
}

+(OpportunityCell *)getNewCell
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OpportunityCell" owner:nil options:nil];
    OpportunityCell *cell;
    for (id currentObject in topLevelObjects)
    {
        if ([currentObject isKindOfClass:[OpportunityCell class]])
        {
            cell= (OpportunityCell *)currentObject;
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
    NSString *account = [dicData objectForKey:@"Account"];
    if([StringUtil stringIsEmpty:account])
    {
        self.lbName.text = [NSString stringWithFormat:@"%@  ", [dicData objectForKey:DTOOPPORTUNITY_name]];
    }
    else
    {
        self.lbName.text = [NSString stringWithFormat:@"%@   với %@", [dicData objectForKey:DTOOPPORTUNITY_name],[dicData objectForKey:@"Account"]];
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOOPPORTUNITY_name]]) {
        
        [self.lbName setFont:boldFont string:[NSString stringWithFormat:@"%@", [dicData objectForKey:DTOOPPORTUNITY_name]]];
        
        [self.lbName setFontColor:blackColor string:[NSString stringWithFormat:@"%@", [dicData objectForKey:DTOOPPORTUNITY_name]]];
    }
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCONTACT_fullName]]) {
        self.lbContact.text = @"Người liên hệ chưa nhập";
    }else{
        self.lbContact.text = [dicData objectForKey:DTOCONTACT_fullName];
    }
    
    
    
    self.lbPotential.text = [dicData objectForKey:DTOOPPORTUNITY_code]; //chua biet de cai gi de tam day!
    self.lbStatus.text = [dicData objectForKey:@"StatusName"];
    
    NSString *status = [dicData objectForKey:DTOOPPORTUNITY_status];
    
    if ([status isEqualToString:@"1"]) {
        self.viewStatus.backgroundColor = [UIColor grayColor];
    }else{
        self.viewStatus.backgroundColor = [UIColor greenColor];
    }
    CGSize textSize = [[self.lbStatus text] sizeWithFont:[self.lbStatus font]];
    float widthLabel = textSize.width;
    float xx = self.viewStatus.frame.origin.x + self.viewStatus.frame.size.width -widthLabel -20;
    
    self.viewStatus.frame = CGRectMake(xx, self.viewStatus.frame.origin.y, (widthLabel + 20), self.viewStatus.frame.size.height);

    self.lbStatus.frame = CGRectMake(5, self.lbStatus.frame.origin.y, (widthLabel + 10), self.lbStatus.frame.size.height);
    
    //self.lbDate.text = [dicData objectForKey:DTOOPPORTUNITY_startDate] ;
    //[dicData objectForKey:DTOOPPORTUNITY_endDate]
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOOPPORTUNITY_endDate]]) {
        self.lbDate.text = [NSString stringWithFormat:@"%@ ~ .......", [[dicData objectForKey:DTOOPPORTUNITY_startDate] substringToIndex:10] ];
    }else{
        self.lbDate.text = [NSString stringWithFormat:@"%@ ~ %@", [[dicData objectForKey:DTOOPPORTUNITY_startDate] substringToIndex:10] , [[dicData objectForKey:DTOOPPORTUNITY_endDate] substringToIndex:10]];
        
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
