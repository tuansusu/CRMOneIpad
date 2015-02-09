//
//  CustomerViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/17/14.
//
//

#import "CustomerViewCell.h"
#import "DTOAcountLeadProcessObject.h"
#import "DTOAccountProcessObject.h"
#import <CoreLocation/CoreLocation.h>

@implementation CustomerViewCell

+(CustomerViewCell*) initNibCell{

    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomerViewCell" owner:nil options:nil];

    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[CustomerViewCell class]])
        {
            return (CustomerViewCell *) curentObject;

        }
    }

    return nil;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) loadDataToCellWithKH360OB:(DTOAccountProcessObject *)kh360OB withStatus:(NSString *)status{
    [iconDirection setAlpha:1];

    if (kh360OB.lat && kh360OB.lon) {
        [iconDirection setAlpha:1];
        if ([status isEqual:@"YES"]) {
            [iconDirection setImage:[UIImage imageNamed:@"iconDirectionSelected"]];
            _isCellSelected = YES;
        }else{
            [iconDirection setImage:[UIImage imageNamed:@"iconDirection"]];
            _isCellSelected = NO;
        }
    }else{
        [btnDirection setEnabled:NO];
        [iconDirection setAlpha:0.5];
        [iconDirection setImage:[UIImage imageNamed:@"iconDirection"]];
    }

    if (kh360OB.name) {
        if (kh360OB.clientAccountId && kh360OB.name) {
            lblName.text = [NSString stringWithFormat:@"%@-%@",kh360OB.clientAccountId,kh360OB.name];
        }else{
            lblName.text = [NSString stringWithFormat:@"%@",kh360OB.name];
        }
    }
}

-(void) loadDataToCellWithKHDMOB:(DTOAcountLeadProcessObject *)khdmOB withStatus:(NSString *)status{
    [iconDirection setAlpha:1];
    if (khdmOB.lat && khdmOB.lon) {
        [iconDirection setAlpha:1];
        if ([status isEqual:@"YES"]) {
            [iconDirection setImage:[UIImage imageNamed:@"iconDirectionSelected"]];
            _isCellSelected = YES;
        }else{
            [iconDirection setImage:[UIImage imageNamed:@"iconDirection"]];
            _isCellSelected = NO;
        }
    }else{
        [btnDirection setEnabled:NO];
        [iconDirection setAlpha:0.5];
        [iconDirection setImage:[UIImage imageNamed:@"iconDirection"]];
    }

    if (khdmOB.name) {
        if(khdmOB.clientLeadId && khdmOB.name)
        {
            lblName.text = [NSString stringWithFormat:@"%@-%@",khdmOB.clientLeadId,khdmOB.name];
        }else{
            lblName.text = [NSString stringWithFormat:@"%@",khdmOB.name];
        }
    }
}

-(IBAction)cellSelectedAtIndex:(id)sender{
    Reachability *reachbility = [Reachability reachabilityForInternetConnection];
    if ([reachbility currentReachabilityStatus]!=NotReachable) {

        NSString *statusSelect;
        if([CLLocationManager locationServicesEnabled] &&
           [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
        {
            if (_isCellSelected) {
                [iconDirection setImage:[UIImage imageNamed:@"iconDirection"]];
                _isCellSelected= NO;
                statusSelect = @"NO";
            }else{
                [iconDirection setImage:[UIImage imageNamed:@"iconDirectionSelected"] ];
                _isCellSelected = YES;
                statusSelect = @"YES";
            }
            if (_delegate && [_delegate respondsToSelector:@selector(didSelectedAtCell: withStatus:)]) {
                [_delegate didSelectedAtCell:self withStatus:statusSelect];
            }
        }else {
            [[[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_EnableLocation delegate:nil cancelButtonTitle:SYS_Notification_CancelTitle otherButtonTitles: nil] show];
        }
    }else{
        [[[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_NotConnection delegate:nil cancelButtonTitle:SYS_Notification_CancelTitle otherButtonTitles: nil] show];
    }
}

@end
