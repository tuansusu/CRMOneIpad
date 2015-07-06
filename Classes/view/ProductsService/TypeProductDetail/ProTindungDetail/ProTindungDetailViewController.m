//
//  ProTindungDetailViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import "ProTindungDetailViewController.h"

#import "DTOProTindungDetailObject.h"
#import "DTOProTindungDetailProcess.h"
#import "DTOProductDetailObject.h"
#import "DataField.h"
#import "EnumClass.h"

#import "DTOACCOUNTProcess.h"

@interface ProTindungDetailViewController ()
{
    IBOutlet UIView *mainView;
    IBOutlet UILabel *lblMaKH;
    IBOutlet UILabel *lblTenKH;
    IBOutlet UILabel *lblMaTK;
    IBOutlet UILabel *lblTrangThai;
    IBOutlet UILabel *lblSoHopDong;
    IBOutlet UILabel *lblMaSanPham;
    IBOutlet UILabel *lblSoDu;
    IBOutlet UILabel *lblTienTe;
    IBOutlet UILabel *lblKyHan;
    IBOutlet UILabel *lblLaiSuatChoVay;
    IBOutlet UILabel *lblNgayVay;
    IBOutlet UILabel *lblNgayDaoHan;
    IBOutlet UILabel *lblNgayGiaHan;
    IBOutlet UILabel *lblSoDuGoc;
    IBOutlet UILabel *lblSoDuDauNgay;
    IBOutlet UILabel *lblLaiDuThu;
    IBOutlet UILabel *lblHanVay;
    IBOutlet UILabel *lblCoTaiSanDamBao;
    IBOutlet UILabel *lblNhomNo;
    IBOutlet UILabel *lblNguonVay;
    IBOutlet UILabel *lblMucDichVay;
    IBOutlet UILabel *lblRM;
    IBOutlet UILabel *lblChiNhanhPhatHanh;
    IBOutlet UIScrollView *scrollView;

    int smgSelect;

    DTOProTindungDetailProcess *dtoProTinDungDetailProcess;
    DTOProTindungDetailObject *productTinDungDetailOB;

    NSDictionary *proTindungDetailDic;
}

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;


@property (weak, nonatomic) IBOutlet UIButton *btnHome;

@property (weak, nonatomic) IBOutlet UIView *mainView;


@property (weak, nonatomic) IBOutlet UIView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewMainBodyInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;


//footer
@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@end

@implementation ProTindungDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults ;
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    smgSelect = [[[NSUserDefaults standardUserDefaults] objectForKey:INTERFACE_OPTION] intValue];

    _fullNameLB.text = TITLE_PRODUCT_DETAIL_TIN_DUNG;
    [self updateInterFaceWithOption:smgSelect];
    dtoProTinDungDetailProcess = [DTOProTindungDetailProcess new];

    if (_dtoProductDetailObject) {
        NSMutableArray *resultArr = [dtoProTinDungDetailProcess filterProductDetailWithClientId:_dtoProductDetailObject.clientId WithProductCode:_dtoProductDetailObject.productCode];
        if (resultArr.count>0) {
            proTindungDetailDic = [resultArr objectAtIndex:0];

            [lblMaKH setText:[proTindungDetailDic valueForKey:@"CLIENT_ID"]];
            NSString *tenKH ;
            DTOACCOUNTProcess *accountProcess = [DTOACCOUNTProcess new];
                NSMutableArray *acountResult =[accountProcess filterWithKey:DTOACCOUNT_clientAccountId withValue:[proTindungDetailDic valueForKey:@"CLIENT_ID"]];
                if (acountResult.count>0) {
                    NSDictionary *accountOB = [acountResult objectAtIndex:0];
                    tenKH = [accountOB valueForKey:DTOACCOUNT_name];
                }

            [lblTenKH setText:tenKH];
            [lblMaTK setText:[proTindungDetailDic valueForKey:@"CONTRACT_NUMBER"]];
            [lblTrangThai setText:[proTindungDetailDic valueForKey:@"STATUS"]];
            [lblSoHopDong setText:[proTindungDetailDic valueForKey:@"CONTRACT_NUMBER"]];
            [lblMaSanPham setText:[proTindungDetailDic valueForKey:@"PRODUCT_CODE"]];
            [lblSoDu setText:[proTindungDetailDic valueForKey:@"BALANCE"]];
            [lblTienTe setText:[proTindungDetailDic valueForKey:@"CURRENCY"]];
            [lblKyHan setText:[proTindungDetailDic valueForKey:@"TERM"]];
            [lblLaiSuatChoVay setText:[proTindungDetailDic valueForKey:@"INTEREST"]];
            [lblNgayVay setText:[proTindungDetailDic valueForKey:@"OPEN_DATE"]];
            [lblNgayDaoHan setText:[proTindungDetailDic valueForKey:@"EXPIRE_DATE"]];
            [lblNgayGiaHan setText:[proTindungDetailDic valueForKey:@"EXTENSION_DATE"]];
            [lblSoDuGoc setText:[proTindungDetailDic valueForKey:@"INITIAL_BALANCE"]];
            [lblSoDuDauNgay setText:[proTindungDetailDic valueForKey:@"SOD_BALANCE"]];
            [lblLaiDuThu setText:[proTindungDetailDic valueForKey:@"RECEIVEABLE_AMOUNT"]];
            [lblHanVay setText:[proTindungDetailDic valueForKey:@"TERM_TYPE"]];
            [lblCoTaiSanDamBao setText:[proTindungDetailDic valueForKey:@"SECURE"]];
            [lblNhomNo setText:[proTindungDetailDic valueForKey:@"DEPT_GROUP2"]];
            [lblNguonVay setText:[proTindungDetailDic valueForKey:@"SOURCE_OF_FUND"]];
            [lblMucDichVay setText:[proTindungDetailDic valueForKey:@"PURPOSE"]];
            [lblRM setText:[proTindungDetailDic valueForKey:@"RM_CODE"]];
            [lblChiNhanhPhatHanh setText:[proTindungDetailDic valueForKey:@"BRANCH_CODE"]];
        }

    }
    if ([self currentDeviceType]==iPhone) {
        [scrollView setContentSize:CGSizeMake(320, scrollView.frame.size.height + 400)];
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
