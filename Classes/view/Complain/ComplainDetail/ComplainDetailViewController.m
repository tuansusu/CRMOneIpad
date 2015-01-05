//
//  ComplainDetailViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import "ComplainDetailViewController.h"
#import "Globals.h"
#import "DTOComplainObject.h"


@interface ComplainDetailViewController ()
{
    IBOutlet UIView *mainView;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnCancel;
    DTOComplainObject *_complainOB;

    IBOutlet UITextField *txtMaKhieuNai;
    IBOutlet UITextField *txtNoiDungKhieuNai;
    IBOutlet UITextField *txtLiDo;
    IBOutlet UITextField *txtNoiDungXuLy;
    IBOutlet UITextField *txtNguoiNhan;
    IBOutlet UITextField *txtNgayNhan;
    IBOutlet UITextField *txtNguoiXuLy;
    IBOutlet UITextField *txtNgayXuLy;

}
@end

@implementation ComplainDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mainView.layer.cornerRadius = CORNER_RADIUS_VIEW;
    mainView.layer.masksToBounds = YES;
    btnSave.layer.cornerRadius = CORNER_RADIUS_BUTTON;
    btnSave.layer.masksToBounds = YES;
    btnCancel.layer.cornerRadius = CORNER_RADIUS_BUTTON;
    btnCancel.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataWithComplainOB:(DTOComplainObject*)complainOB{
    _complainOB = complainOB;
    if (_complainOB) {
        [txtNoiDungKhieuNai setText:_complainOB.content];
        [txtLiDo setText:_complainOB.reason];
        [txtNoiDungXuLy setText:_complainOB.result];
        [txtNguoiNhan setText:_complainOB.accountId];
        [txtNgayNhan setText:_complainOB.receivedDate];
        [txtNguoiXuLy setText:_complainOB.processerId];
        [txtNgayXuLy setText:_complainOB.processedDate];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)btnCancelTapped:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(closeComplainDetailView:)]) {
        [_delegate closeComplainDetailView:self];
    }
}

-(IBAction)btnSaveTapped:(id)sender{
    DTOComplainObject *complainOB = [[DTOComplainObject alloc] init];
    if (_complainOB) {
        _complainOB.content = txtNoiDungKhieuNai.text;
        _complainOB.reason = txtLiDo.text;
        _complainOB.result = txtNoiDungXuLy.text;
        _complainOB.receiverId = txtNguoiNhan.text;
        _complainOB.receivedDate = txtNgayNhan.text;
        _complainOB.processerId = txtNguoiXuLy.text;
        _complainOB.processedDate = txtNgayXuLy.text;
        complainOB = _complainOB;
    }else{
        complainOB.content = txtNoiDungKhieuNai.text;
        complainOB.reason = txtLiDo.text;
        complainOB.result = txtNoiDungXuLy.text;
        complainOB.receiverId = txtNguoiNhan.text;
        complainOB.receivedDate = txtNgayNhan.text;
        complainOB.processerId = txtNguoiXuLy.text;
        complainOB.processedDate = txtNgayXuLy.text;
    }
    if (_leadId) {
        complainOB.accountId = _leadId;
    }
    complainOB.status = @"1";
   
    if ([self checkValid]) {
        if (_delegate && [_delegate respondsToSelector:@selector(updateComplainDetailViewWithComplainOB:)]) {
            [_delegate updateComplainDetailViewWithComplainOB:complainOB];
        }
    }

}

-(BOOL)checkValid{
    if ([txtNoiDungKhieuNai.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_CheckValid_NoiDungKhieuNai delegate:nil cancelButtonTitle:SYS_Notification_CancelButton otherButtonTitles: nil] show];
        return NO;
    }
    if ([txtLiDo.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_CheckValid_LiDo delegate:nil cancelButtonTitle:SYS_Notification_CancelButton otherButtonTitles: nil] show];
        return NO;
    }
    if ([txtNoiDungXuLy.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_CheckValid_NoiDungXuLy delegate:nil cancelButtonTitle:SYS_Notification_CancelButton otherButtonTitles: nil] show];
        return NO;
    }
    return YES;
}

@end
