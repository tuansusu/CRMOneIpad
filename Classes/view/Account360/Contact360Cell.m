//
//  Contact360Cell.m
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/22/14.
//
//

#import "Contact360Cell.h"

//remove
#import "StringUtil.h"
#import "GraphicName.h"
#import "Constant.h"
#import "DataField.h"
#import "MJDetailViewController.h"

@implementation Contact360Cell


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(Contact360Cell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Contact360Cell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[Contact360Cell class]])
        {
            return (Contact360Cell *) curentObject;
            
        }
    }
    
    return nil;
}


-(void) loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect{
    
    _dicData = dicData;
    
    
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
    NSString *avartar = [dicData objectForKey:DTOCONTACT_avartar];
    if (![StringUtil stringIsEmpty:avartar]) {
        _avartar.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:avartar]];
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
    
    switch (smgSelect) {
        case 1:
        {
            for (UIView *viewTemp in self.contentView.subviews) {
                
                if ([viewTemp isKindOfClass:[UIImageView class]]) {
                    [((UIImageView*) viewTemp) setAlpha:1.0f];
                    continue;
                }
                
                
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
    
   // [_delegate AccountLeadCellDelegate_ActionViewMapWithData:_dicData];
    
}

- (IBAction)actionSendMail:(id)sender {
    if(![StringUtil stringIsEmpty:[_dicData objectForKey:DTOCONTACT_email]]){
        [_delegate delegateSendEmail:[_dicData objectForKey:DTOCONTACT_email]];
    }
}

- (IBAction)actionSMS:(id)sender {
    if(![StringUtil stringIsEmpty:[_dicData objectForKey:DTOCONTACT_mobile]]){
        [_delegate delegateSMS:[_dicData objectForKey:DTOCONTACT_mobile] ];
    }
}

- (IBAction)actionCall:(id)sender {
    if(![StringUtil stringIsEmpty:[_dicData objectForKey:DTOCONTACT_mobile]]){
        [_delegate delegateCall:[_dicData objectForKey:DTOCONTACT_mobile]];
    }
}
@end
