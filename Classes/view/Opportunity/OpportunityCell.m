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

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}
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
    
   
//    NSString *account = [dicData objectForKey:@"Account"];
//    if([StringUtil stringIsEmpty:account])
//    {
//        self.lbName.text = [NSString stringWithFormat:@"%@  ", [dicData objectForKey:DTOOPPORTUNITY_name]];
//    }
//    else
//    {
//        self.lbName.text = [NSString stringWithFormat:@"%@   với %@", [dicData objectForKey:DTOOPPORTUNITY_name],[dicData objectForKey:@"Account"]];
//    }
    
    self.lbName.text= [NSString stringWithFormat:@"%@ - %@",[dicData objectForKey:DTOOPPORTUNITY_id], [dicData objectForKey:DTOOPPORTUNITY_name]];
    
    
//    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOOPPORTUNITY_name]]) {
//        
//        [self.lbName setFont:boldFont string:[NSString stringWithFormat:@"%@", [dicData objectForKey:DTOOPPORTUNITY_name]]];
//        
//        [self.lbName setFontColor:blackColor string:[NSString stringWithFormat:@"%@", [dicData objectForKey:DTOOPPORTUNITY_name]]];
//    }
//    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:@"Contact"]]) {
        self.lbContact.text = @"Khách hàng chưa nhập";
    }else{
        self.lbContact.text= [NSString stringWithFormat:@"%@ - %@",[dicData objectForKey:@"Contact"], [dicData objectForKey:@"ContactCode"]];    }
    
    self.lbContact.textColor = TEXT_COLOR_CELL_BOLD;
    
    self.lbLevel.text = [dicData objectForKey:@"Level"];
    self.lbType.text = [dicData objectForKey:@"StatusName"];
    
    int value = [[dicData objectForKey:@"LevelValue"] intValue];
    self.progress.progress = (float)value / 100;
    
    self.lbType.text = [dicData objectForKey:@"Type"];
    
    self.lbStatus.text = [dicData objectForKey:@"StatusName"];
    
    NSString *status = [dicData objectForKey:DTOOPPORTUNITY_status];
    
    if ([status isEqualToString:@"1"]) { //DAng soan thao
        self.viewStatus.backgroundColor = [UIColor grayColor];
    }else if ([status isEqualToString:@"2"]){ //Cho phe duyet ke hoach
        self.viewStatus.backgroundColor = [UIColor yellowColor];
    }
    else if ([status isEqualToString:@"3"]){ //Phe duyet ke hoach
        self.viewStatus.backgroundColor = [UIColor greenColor];
    }
    else if ([status isEqualToString:@"4"]){ //Khong phe duyet ke hoach
        self.viewStatus.backgroundColor = [UIColor grayColor];
    }
    else if ([status isEqualToString:@"5"]){ //Cho phe duyet ket qua
        self.viewStatus.backgroundColor = [UIColor yellowColor];
    }
    else if ([status isEqualToString:@"6"]){ //PHe udyet ket qua
        self.viewStatus.backgroundColor = [UIColor greenColor];
    }
    else //Khong phe duyet ket qua
    {
        self.viewStatus.backgroundColor = [UIColor grayColor];
    }
    CGSize textSize = [[self.lbStatus text] sizeWithFont:[self.lbStatus font]];
    float widthLabel = textSize.width;
    float xx = self.viewStatus.frame.origin.x + self.viewStatus.frame.size.width -widthLabel -20;
    
    self.viewStatus.frame = CGRectMake(xx, self.viewStatus.frame.origin.y, (widthLabel + 20), self.viewStatus.frame.size.height);

    self.lbStatus.frame = CGRectMake(5, self.lbStatus.frame.origin.y, (widthLabel + 10), self.lbStatus.frame.size.height);
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOOPPORTUNITY_endDate]]) {
        self.lbDate.text = [[dicData objectForKey:DTOOPPORTUNITY_endDate] substringToIndex:10];
    }else{
        self.lbDate.text = @"";
    }
    
//    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOOPPORTUNITY_endDate]]) {
//        self.lbDate.text = [NSString stringWithFormat:@"%@ ~ .......", [[dicData objectForKey:DTOOPPORTUNITY_startDate] substringToIndex:10] ];
//    }else{
//        self.lbDate.text = [NSString stringWithFormat:@"%@ ~ %@", [[dicData objectForKey:DTOOPPORTUNITY_startDate] substringToIndex:10] , [[dicData objectForKey:DTOOPPORTUNITY_endDate] substringToIndex:10]];
//        
//    }
    
       
    if ([UIDevice getCurrentSysVer] >= 7.0) {
//        CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 5.0f);
//         self.progress.transform = transform;
//       
        
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
