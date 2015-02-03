//
//  AccountLeadCell.m
//  OfficeOneStudy
//
//  Created by ADMIN on 11/13/14.
//
//

#import "AccountLeadCell.h"
#import "DTOFLLOWUPProcess.h"
#import "Util.h"

@implementation AccountLeadCell
//kiem tra trang thai khahc hang co dang duọc theo doi hay khong, neu la 1 thi chua theo doi, la 2 thi dang theo doi, la 3 thi xong thoi doi
int checkFollow =0;
NSDictionary *arrayData;
//thong tin chon NGAY - THANG
int SELECTED_DATE_TAG ;
NSDate *dateFrom, *dateTo;
NSDate *timeFrom, *timeTo;
NSDateFormatter *df,*dfTime;
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
    
    
    NSString *leadId=[dicData objectForKey:DTOLEAD_leadId];
    if(leadId.length>0){
        leadId=leadId;
    }
    else{
        leadId=[dicData objectForKey:DTOLEAD_clientLeadId];
    }
    //[self checkDateFollow:leadId];
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
    if ([self checkFollowLead:leadId]==1) {
        //dang theo doi
        [_btnFollow setImage:[UIImage imageNamed:@"task_done.png"] forState:UIControlStateNormal];
    }
    else if([self checkFollowLead:leadId]==2){
        //qua han
        [_btnFollow setImage:[UIImage imageNamed:@"task_not_done.png"] forState:UIControlStateNormal];
        
    }
    else if([self checkFollowLead:leadId]==3){
        //hoan thanh
        [_btnFollow setImage:[UIImage imageNamed:@"flag_disable.png"] forState:UIControlStateNormal];
        
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
//hàm kiểm trang thái theo doi khách hàng
-(int) checkFollowLead:(NSString *)leadId{
    checkFollow=0;
    if([self checkLeadDateFollow:leadId]){
        checkFollow=2;
    }
    else{
        DTOFLLOWUPProcess *_DTOFLLOWUPProcess=[DTOFLLOWUPProcess new];
        arrayData= [_DTOFLLOWUPProcess getDataWithKey:DTOFOLLOWUP_objectId withValue:leadId];
        NSLog(@"cc:%@",[arrayData objectForKey:DTOFOLLOWUP_followUpState] );
        if(arrayData.count >0){
            NSString *item;
            item= [arrayData objectForKey:DTOFOLLOWUP_followUpState];
            if(item.length>0){
                checkFollow = [[arrayData objectForKey:DTOFOLLOWUP_followUpState] intValue];
            }
        }
    }
    return checkFollow;
}
- (IBAction)actionAddress:(id)sender {
    
    [_delegate AccountLeadCellDelegate_ActionViewMapWithData:_dicData];
    
}

- (IBAction)actionSendMail:(id)sender {
    [_delegate AccountLeadCellDelegate_ActionSendMailWithData:_dicData];
}

- (IBAction)actionChangeFlow:(id)sender {
    NSString *leadId=[_dicData objectForKey:DTOLEAD_leadId];
    if(leadId.length>0){
        leadId=leadId;
    }
    else{
        leadId=[_dicData objectForKey:DTOLEAD_clientLeadId];
    }
    if([self checkFollowLead:leadId]==0){
        [_delegate AccountLeadCellDelegate_ActionChangeFlowWithData:_dicData];
    }
    else if ([self checkFollowLead:leadId]==1){
        //xu ly trang thai thanh da hoan thanh
        NSLog(@"chua xu ly");
          NSDictionary *data;
        DTOFLLOWUPProcess *followProcess=[DTOFLLOWUPProcess new];
        data= [followProcess getDataWithKey:DTOFOLLOWUP_objectId withValue:leadId];
        NSString *followid;
        if(data.count>0){
            followid = [data objectForKey:DTOFOLLOWUP_id];
        [_delegate delegate_changeStatusFollow:followid];
        }
    }
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
-(BOOL) checkLeadDateFollow:(NSString *)leadId{
    BOOL res=NO;
    NSDictionary *data;
    DTOFLLOWUPProcess *followProcess=[DTOFLLOWUPProcess new];
    data= [followProcess getDataWithKey:DTOFOLLOWUP_objectId withValue:leadId];
    
    NSDate *today=[[NSDate alloc] init];
    
    NSString *strDateEnd=[data objectForKey:DTOFOLLOWUP_endDate];
    if (![StringUtil stringIsEmpty:strDateEnd]) {

        
        //ngay ket thuc theo doi
        NSDateFormatter *dateFromStringFormat=[[NSDateFormatter alloc]init];
        [dateFromStringFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
        NSDateFormatter *dateEndFormat=[[NSDateFormatter alloc]init];
        [dateEndFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
        NSDate *end=[dateFromStringFormat dateFromString:strDateEnd];
        
        NSString *stt =[arrayData objectForKey:DTOFOLLOWUP_followUpState] ;
        NSComparisonResult result;
        result =[today compare:end];
        
        if (result == NSOrderedDescending && ![stt isEqualToString:@"2"]) {
            NSLog(@"Qua han");
            NSString *itemid;
            itemid=[arrayData objectForKey:DTOFOLLOWUP_id];
            NSLog(@"item:%@",itemid);
            if([StringUtil stringIsEmpty:itemid]){
                return NO;
            }
            NSMutableDictionary *dicEntity=[NSMutableDictionary new];
            [dicEntity setObject:itemid forKey:DTOFOLLOWUP_id];
            [dicEntity setObject:@"2" forKey:DTOFOLLOWUP_followUpState];
            BOOL success=[followProcess insertToDBWithEntity:dicEntity];
            if(success){
                res=YES;
                  NSLog(@"update %@ stt = 2",leadId);
            }
            else{
                res=NO;
                NSLog(@"Error");
            }
            
        }
    }
    return res;
}

@end
