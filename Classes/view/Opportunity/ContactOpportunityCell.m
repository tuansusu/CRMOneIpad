//
//  ContactLeadCell.m
//  OfficeOneMB
//
//  Created by viettel on 12/2/14.
//
//

#import "ContactOpportunityCell.h"
//remove
#import "StringUtil.h"
#import "GraphicName.h"
#import "Constant.h"
#import "DataField.h"


@implementation ContactOpportunityCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(ContactOpportunityCell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ContactOpportunityCell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[ContactOpportunityCell class]])
        {
            return (ContactOpportunityCell *) curentObject;
            
        }
    }
    
    return nil;
}


-(void) loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect{
    
    _dicData = dicData;
    
    NSLog(@"Avartar:%@",[dicData objectForKey:DTOCONTACT_avartar]);
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCONTACT_fullName]]) {
        self.lbName.text = @"";
        
    }else{
        self.lbName.text = [dicData objectForKey:DTOCONTACT_fullName];
    }
    
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCONTACT_mobile]]) {
        self.lbPhone.text = @"";
        
    }else{
        self.lbPhone.text = [dicData objectForKey:DTOCONTACT_mobile];
    }
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCONTACT_email]]) {
        self.lbEmail.text = @"";
    }else{
        self.lbEmail.text = [dicData objectForKey:DTOCONTACT_email];
    }
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCONTACT_position]]) {
        self.lbPosition.text = @"";
    }else{
        self.lbPosition.text = [dicData objectForKey:DTOCONTACT_position];
    }
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCONTACT_address]]) {
        self.lbAddress.text = @"";
    }else{
        self.lbAddress.text = [dicData objectForKey:DTOCONTACT_address];
    }
    NSString *avartar = [dicData objectForKey:DTOCONTACT_avartar];
    if (![StringUtil stringIsEmpty:avartar]) {
        _avartar.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:avartar]];
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

- (IBAction)actionAddress:(id)sender {
    
    //    [_delegate AccountLeadCellDelegate_ActionViewMapWithData:_dicData];
    
}

- (IBAction)actionSendMail:(id)sender {
}


@end
