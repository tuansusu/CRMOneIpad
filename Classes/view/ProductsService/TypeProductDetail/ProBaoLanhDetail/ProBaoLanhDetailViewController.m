//
//  ProBaoLanhDetailViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import "ProBaoLanhDetailViewController.h"

#import "DTOProBaoLanhDetailProcess.h"

#import "DTOACCOUNTProcess.h"
#import "DTOProductDetailObject.h"

@interface ProBaoLanhDetailViewController ()
{
    int smgSelect;
    IBOutlet UILabel *lblMaKH;
    IBOutlet UILabel *lblTenKH;
    IBOutlet UILabel *lblMaTK;

    IBOutlet UILabel *lblSoDuNguyenTe;
    IBOutlet UILabel *lblLoaiTien;
    IBOutlet UILabel *lblNgayMo;
    IBOutlet UILabel *lblNgayCoHieuLuc;
    IBOutlet UILabel *lblNgayDaoHan;
    IBOutlet UILabel *lblMaNguoiThuHuong;
    IBOutlet UILabel *lblTenNguoiThuHuong;
    IBOutlet UILabel *lblPhiBaoLanh;
    IBOutlet UILabel *lblCoKyQuy;
    IBOutlet UILabel *lblSoTienKyQuy;
    IBOutlet UILabel *lblTyLeKyQuy;
    IBOutlet UILabel *lblMaChiNhanh;
    IBOutlet UILabel *lblCheDoTatToan;
    IBOutlet UILabel *lblTuDongDaoHan;
    IBOutlet UILabel *lblDienGiai;
    IBOutlet UILabel *lblRM;
    IBOutlet UILabel *lblChiNhanhPhatHanh;

    DTOProBaoLanhDetailProcess *dtoProBaoLanhDetailProcess;
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

@implementation ProBaoLanhDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    smgSelect = [[[NSUserDefaults standardUserDefaults] objectForKey:INTERFACE_OPTION] intValue];

    _fullNameLB.text = TITLE_PRODUCT_DETAIL_BAO_LANH;
    [self updateInterFaceWithOption:smgSelect];
    dtoProBaoLanhDetailProcess = [DTOProBaoLanhDetailProcess new];

    if (_dtoProductDetailObject) {
        NSMutableArray *resultArr = [dtoProBaoLanhDetailProcess filterProductDetailWithClientId:_dtoProductDetailObject.clientId WithProductCode:_dtoProductDetailObject.productCode];
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
            [lblSoDuNguyenTe setText:[proDetailDic valueForKey:@"BALANCE"]];
            [lblLoaiTien setText:[proDetailDic valueForKey:@"CURRENCY"]];
            [lblNgayMo setText:[proDetailDic valueForKey:@"OPEN_DATE"]];
            [lblNgayCoHieuLuc setText:[proDetailDic valueForKey:@"VALUE_DATE"]];
            [lblNgayDaoHan setText:[proDetailDic valueForKey:@"EXPIRE_DATE"]];
            [lblMaNguoiThuHuong setText:[proDetailDic valueForKey:@"RECEIVER_CODE"]];
            [lblTenNguoiThuHuong setText:[proDetailDic valueForKey:@"RECEIVER_NAME"]];

            [lblPhiBaoLanh setText:[proDetailDic valueForKey:@"MD_FREE"]];
            [lblCoKyQuy setText:[proDetailDic valueForKey:@"MARGIN"]];
            [lblSoTienKyQuy setText:[proDetailDic valueForKey:@"MARGIN_AMOUNT"]];
            [lblTyLeKyQuy setText:[proDetailDic valueForKey:@""]];
            [lblMaChiNhanh setText:[proDetailDic valueForKey:@"BRANCH_CODE"]];
            [lblCheDoTatToan setText:[proDetailDic valueForKey:@"LIQUIDATION_MODE"]];
            [lblTuDongDaoHan setText:[proDetailDic valueForKey:@"AUTO_EXPIRE"]];
            [lblDienGiai setText:[proDetailDic valueForKey:@"DESCRIPTION"]];

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
                ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
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
