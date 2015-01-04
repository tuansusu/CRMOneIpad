//
//  AccountLeadCell.m
//  OfficeOneStudy
//
//  Created by ADMIN on 11/13/14.
//
//

#import "Account360Cell.h"
#import "DTOFLLOWUPProcess.h"

@implementation Account360Cell

- (void)awakeFromNib
{
    // Initialization code
}

+(Account360Cell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Account360Cell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[Account360Cell class]])
        {
            return (Account360Cell *) curentObject;
            
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
    
    DTOFLLOWUPProcess *_DTOFLLOWUPProcess=[DTOFLLOWUPProcess new];
    BOOL checkFollow;
    NSString *leadId=[dicData objectForKey:DTOACCOUNT_accountId];
    if(leadId.length>0){
        leadId=leadId;
    }
    else{
        leadId=[dicData objectForKey:DTOACCOUNT_clientAccountId];
    }
    checkFollow=[_DTOFLLOWUPProcess checkFollowUp:leadId objectType:@"ACCOUNT"];
    _dicData = dicData;
    NSLog(@"datarott:%@",dicData);
    NSString *code = @"";
    NSString *name = @"";
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_code]]) {
        code = [dicData objectForKey:DTOACCOUNT_code];
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_name]]) {
        name = [dicData objectForKey:DTOACCOUNT_name];
    }
    if(![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_clientAccountId]]){
        
        code=[dicData objectForKey:DTOACCOUNT_clientAccountId];
    }
    
    self.lbName.text = [NSString stringWithFormat:@"%@ - %@",code, name];
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_mobile]]) {
        self.lbPhone.text = @"N/a";
        
    }else{
        self.lbPhone.text = [dicData objectForKey:DTOACCOUNT_mobile];
    }
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_email]]) {
        self.lbEmail.text = @"N/a";
    }else{
        self.lbEmail.text = [dicData objectForKey:DTOLEAD_email];
    }
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_name]]) {
        self.lbRightName.text = @"N/a";
    }else{
        self.lbRightName.text = [dicData objectForKey:DTOACCOUNT_name];
    }
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_address]]) {
        self.lbAddress.text = @"N/a";
    }else{
        self.lbAddress.text = [dicData objectForKey:DTOACCOUNT_address];
    }
    if (checkFollow) {
        [_btnFollow setImage:[UIImage imageNamed:@"task_done.png"] forState:UIControlStateNormal];
    }
    else{
        [_btnFollow setImage:[UIImage imageNamed:@"flag_enable.png"] forState:UIControlStateNormal];
        
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
    
    [_delegate Account360CellDelegate_ActionViewMapWithData:_dicData];
    
}

- (IBAction)actionSendMail:(id)sender {
    [_delegate Account360CellDelegate_ActionSendMailWithData:_dicData];
}

- (IBAction)actionChangeFlow:(id)sender {
    [_delegate Account360CellDelegate_ActionChangeFlowWithData:_dicData];
}

- (IBAction)actionCall:(id)sender {
    //if(!])
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:_lbPhone.text]];
}



@end
