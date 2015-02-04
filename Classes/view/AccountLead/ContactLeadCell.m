//
//  ContactLeadCell.m
//  OfficeOneMB
//
//  Created by viettel on 12/2/14.
//
//

#import "ContactLeadCell.h"
//remove
#import "StringUtil.h"
#import "GraphicName.h"
#import "Constant.h"
#import "DataField.h"


@implementation ContactLeadCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(ContactLeadCell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ContactLeadCell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[ContactLeadCell class]])
        {
            return (ContactLeadCell *) curentObject;
            
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
        NSString *name=[dicData objectForKey:DTOCONTACT_fullName];
        NSString *position=[dicData objectForKey:DTOCONTACT_position];
        NSString *display;
        if([StringUtil stringIsEmpty:position]){
            display=name;
        }
        else{
            display =[NSString stringWithFormat:@"%@ - %@",name,position];
        }
        self.lbName.text = display;
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
                
                if ([viewTemp isKindOfClass:[UIImageView class]]) {
                    
                    [((UIImageView*) viewTemp) setAlpha:1.0f];
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
    if(![StringUtil stringIsEmpty:self.lbEmail.text]){
        [_delegate delegate_sendMailContact:self.lbEmail.text];
    }
}

- (IBAction)actionSendSMS:(id)sender {
    if(![StringUtil stringIsEmpty:self.lbPhone.text]){
        [_delegate delegate_sendSMSContact:self.lbPhone.text];

    }
}

- (IBAction)actionCall:(id)sender {
    if(![StringUtil stringIsEmpty:self.lbPhone.text]){
        [_delegate delegate_callContact:self.lbPhone.text];
        
    }
}


@end
