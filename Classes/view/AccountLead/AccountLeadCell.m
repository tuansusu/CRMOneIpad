//
//  AccountLeadCell.m
//  OfficeOneStudy
//
//  Created by ADMIN on 11/13/14.
//
//

#import "AccountLeadCell.h"
#import "DTOFLLOWUPProcess.h"

@implementation AccountLeadCell

- (void)awakeFromNib
{
    // Initialization code
}

+(AccountLeadCell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AccountLeadCell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[AccountLeadCell class]])
        {
            return (AccountLeadCell *) curentObject;
            
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
    NSString *leadId=[dicData objectForKey:DTOLEAD_leadId];
    if(leadId.length>0){
        leadId=leadId;
    }
    else{
        leadId=[dicData objectForKey:DTOLEAD_clientLeadId];
    }
    checkFollow=[_DTOFLLOWUPProcess checkFollowUp:leadId objectType:@"LEAD"];
    _dicData = dicData;
    
    NSString *code = @"";
    NSString *name = @"";
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_code]]) {
        code = [dicData objectForKey:DTOLEAD_code];
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_name]]) {
        name = [dicData objectForKey:DTOLEAD_name];
    }
    if(![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_clientLeadId]]){
        
        code=[dicData objectForKey:DTOLEAD_clientLeadId];
    }
    
    self.lbName.text = [NSString stringWithFormat:@"%@ - %@",code, name];
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_mobile]]) {
        self.lbPhone.text = @"N/a";
        
    }else{
        self.lbPhone.text = [dicData objectForKey:DTOLEAD_mobile];
    }
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_email]]) {
        self.lbEmail.text = @"N/a";
    }else{
        self.lbEmail.text = [dicData objectForKey:DTOLEAD_email];
    }
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_name]]) {
        self.lbRightName.text = @"N/a";
    }else{
        self.lbRightName.text = [dicData objectForKey:DTOLEAD_name];
    }
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_address]]) {
        self.lbAddress.text = @"N/a";
    }else{
        self.lbAddress.text = [dicData objectForKey:DTOLEAD_address];
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
    
    [_delegate AccountLeadCellDelegate_ActionViewMapWithData:_dicData];
    
}

- (IBAction)actionSendMail:(id)sender {
    [_delegate AccountLeadCellDelegate_ActionSendMailWithData:_dicData];
}

- (IBAction)actionChangeFlow:(id)sender {
    [_delegate AccountLeadCellDelegate_ActionChangeFlowWithData:_dicData];
}

- (IBAction)actionCall:(id)sender {
    //if(!])
   [[UIApplication sharedApplication]openURL:[NSURL URLWithString:_lbPhone.text]];
}

-(BOOL) canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(view:)||action == @selector(edit:)||action == @selector(del:)||action == @selector(call:)||action == @selector(sms:)||action == @selector(email:)||action == @selector(follow:)||action == @selector(map:));
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (void) view : (id) sender{
    [_delegate delegate_view:_dicData];
}
-(void) edit:(id) sender{
    [_delegate delegate_edit:_dicData];
}
-(void) del:(id) sender{
    [_delegate delegate_del:_dicData];
}
-(void) call:(id) sender{
    [_delegate delegate_call:_dicData];
}
-(void) sms:(id) sender{
    [_delegate delegate_sms:_dicData];
}
-(void) email:(id) sender{
    [_delegate delegate_email:_dicData];
}
-(void) follow:(id) sender{
    [_delegate delegate_follow:_dicData];
}
-(void) map:(NSDictionary *)dicData{
    [_delegate delegate_maps:_dicData];
}


@end
