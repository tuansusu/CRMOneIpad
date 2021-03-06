//
//  ProTaiKhoanThanhToanDetailViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import "ProTaiKhoanThanhToanDetailViewController.h"

#import "DTOProThanhToanDetailProcess.h"

#import "DTOACCOUNTProcess.h"
#import "DTOProductDetailObject.h"

@interface ProTaiKhoanThanhToanDetailViewController ()
{
    int smgSelect;
    IBOutlet UILabel *lblMaKH;
    IBOutlet UILabel *lblTenKH;
    IBOutlet UILabel *lblMaTK;
    IBOutlet UILabel *lblTrangThai;
    IBOutlet UILabel *lblSoDu;
    IBOutlet UILabel *lblTienTe;
    IBOutlet UILabel *lblSoDuDauNgay;
    IBOutlet UILabel *lblLaiSuat;
    IBOutlet UILabel *lblNgayMo;
    IBOutlet UILabel *lblNgayDaoHan;
    IBOutlet UILabel *lblRM;
    IBOutlet UILabel *lblChiNhanhPhatHanh;
    DTOProThanhToanDetailProcess *dtoProThanhToanDetailProcess;
}

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;


@property (weak, nonatomic) IBOutlet UIButton *btnHome;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *headerMainView;


@property (weak, nonatomic) IBOutlet UIView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewMainBodyInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;


//footer
@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@end

@implementation ProTaiKhoanThanhToanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults ;
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    smgSelect = [[[NSUserDefaults standardUserDefaults] objectForKey:INTERFACE_OPTION] intValue];

    _fullNameLB.text = TITLE_PRODUCT_DETAIL_THANH_TOAN;
    [self updateInterFaceWithOption:smgSelect];

    dtoProThanhToanDetailProcess = [DTOProThanhToanDetailProcess new];

    if (_dtoProductDetailObject) {
        NSMutableArray *resultArr = [dtoProThanhToanDetailProcess filterProductDetailWithClientId:_dtoProductDetailObject.clientId WithProductCode:_dtoProductDetailObject.productCode];
        if (resultArr.count>0) {
            NSDictionary *proDetailDic = [resultArr objectAtIndex:0];

            [lblMaKH setText:[proDetailDic valueForKey:@"CLIENT_ID"]];
            NSString *tenKH ;
            DTOACCOUNTProcess *accountProcess = [DTOACCOUNTProcess new];
            NSMutableArray *acountResult =[accountProcess filterWithKey:DTOACCOUNT_clientAccountId withValue:[proDetailDic valueForKey:@"CLIENT_ID"]];
            if (acountResult.count>0) {
                NSDictionary *accountOB = [acountResult objectAtIndex:0];
                tenKH = [accountOB valueForKey:DTOACCOUNT_name];
            }

            [lblTenKH setText:tenKH];
            [lblMaTK setText:[proDetailDic valueForKey:@"CONTRACT_NUMBER"]];
            [lblTrangThai setText:[proDetailDic valueForKey:@"ACC_STATUS"]];
            [lblSoDu setText:[proDetailDic valueForKey:@"BALANCE"]];
            [lblTienTe setText:[proDetailDic valueForKey:@"CURRENCY"]];
            [lblSoDuDauNgay setText:[proDetailDic valueForKey:@"SOD_BALANCE"]];
            [lblLaiSuat setText:[proDetailDic valueForKey:@"INTEREST"]];
            [lblNgayMo setText:[proDetailDic valueForKey:@"OPEN_DATE"]];
            [lblNgayDaoHan setText:[proDetailDic valueForKey:@"EXPIRED_DATE"]];
            [lblRM setText:[proDetailDic valueForKey:@"RM_CODE"]];
            [lblChiNhanhPhatHanh setText:[proDetailDic valueForKey:@"BRANCH_CODE"]];
        }

    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)btnCloseViewTapped:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) updateInterFaceWithOption : (int) option
{

    _headerViewBar.backgroundColor  = HEADER_VIEW_COLOR1;
    _fullNameLB.textColor           = TEXT_COLOR_HEADER_APP;

    _footerView.backgroundColor     = TOOLBAR_VIEW_COLOR;
    _barLabel.textColor             = TEXT_TOOLBAR_COLOR1;

    _headerMainView.backgroundColor = HEADER_SUB_VIEW_COLOR1;
    [_headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    for (UIView *viewSubTemp in _headerMainView.subviews)
    {
        if ([viewSubTemp isKindOfClass:[UILabel class]])
        {
            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }

    _mainView.backgroundColor       = HEADER_SUB_VIEW_COLOR1;

    _bodyMainView.backgroundColor   = BACKGROUND_NORMAL_COLOR1;
    _bodyMainView.layer.borderWidth = BORDER_WITH;
    _bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];

    for (UIView *viewTemp in _viewMainBodyInfo.subviews)
    {
        for (UIView *viewSubTemp in viewTemp.subviews)
        {
            if ([viewSubTemp isKindOfClass:[UILabel class]])
            {
                //((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
            }
            else if ([viewSubTemp isKindOfClass:[UITextView class]])
            {
                ((UITextView*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextView*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextView*) viewSubTemp).layer.borderWidth = BORDER_WITH;
            }
            else if ([viewSubTemp isKindOfClass:[UITextField class]])
            {
                ((UITextField*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextField*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
            }
        }

        if ([viewTemp isKindOfClass:[UIButton class]])
        {
            [((UIButton*) viewTemp) setStyleNormalWithOption:smgSelect];
        }
    }
}

@end
