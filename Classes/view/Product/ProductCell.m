//
//  ProductCell.m
//  OfficeOneStudy
//
//  Created by viettel on 11/12/14.
//
//

#import "ProductCell.h"

@implementation ProductCell

- (void)awakeFromNib
{
    // Initialization code
}

+(ProductCell *)getNewCell
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:nil options:nil];
    ProductCell *cell;
    for (id currentObject in topLevelObjects)
    {
        if ([currentObject isKindOfClass:[ProductCell class]])
        {
            cell= (ProductCell *)currentObject;
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
    
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOPRODUCTMASTER_code]]) {
        self.lbCode.text = @"N/A";
    }else{
        self.lbCode.text = [dicData objectForKey:DTOPRODUCTMASTER_code];
    }
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOPRODUCTMASTER_name]]) {
        self.lbName.text = @"N/A";
    }else{
        self.lbName.text = [dicData objectForKey:DTOPRODUCTMASTER_name];
    }
    
    self.lbDateEffect.text = @"20/07/2014";//chua biet de cai gi de tam day!
    self.lbEndDateEffect.text = @"20/09/2014";//chua biet de cai gi de tam day!
//    self.lbStatus.text = [dicData objectForKey:DTOOPPORTUNITY_status];
//    
//    if ([self.lbStatus.text isEqualToString:@"1"]) {
//        self.lbStatus.text = @"Đang thực hiện";
//        self.viewStatus.backgroundColor = [UIColor grayColor];
//    }else{
//        self.lbStatus.text = @"Đã liên hệ với đối tác";
//        self.viewStatus.backgroundColor = [UIColor greenColor];
//    }
//    float widthLabel = [UILabel getWidthFitWithLabel:self.lbStatus];
//    NSLog(@"widthLabel = %f", widthLabel);
//    float xx = self.viewStatus.frame.origin.x + self.viewStatus.frame.size.width -widthLabel -20;
//    
//    self.viewStatus.frame = CGRectMake(xx, self.viewStatus.frame.origin.y, (widthLabel + 20), self.viewStatus.frame.size.height);
//    
//    NSLog(@"viewStatusWidth = %f", self.viewStatus.frame.size.width);
//    
//    self.lbStatus.frame = CGRectMake(5, self.lbStatus.frame.origin.y, (widthLabel + 10), self.lbStatus.frame.size.height);
   
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
