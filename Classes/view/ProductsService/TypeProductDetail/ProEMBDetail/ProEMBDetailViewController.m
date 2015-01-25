//
//  ProEMBDetailViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import "ProEMBDetailViewController.h"

#import "DTOProEMBDetailProcess.h"

#import "DTOACCOUNTProcess.h"
#import "DTOProductDetailObject.h"
#import "DTOPRODUCTMASTERProcess.h"

@interface ProEMBDetailViewController ()
{
    int smgSelect;

    IBOutlet UILabel *lblMaKH;
    IBOutlet UILabel *lblTenKH;
    IBOutlet UILabel *lblTenSanPhamThe;
    IBOutlet UILabel *lblNgayBatDau;
    IBOutlet UILabel *lblNgayKetThuc;
    IBOutlet UILabel *lblRM;
    IBOutlet UILabel *lblChiNhanhPhatHanh;
    DTOProEMBDetailProcess *dtoProEMBDetailProcess;
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

@implementation ProEMBDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    smgSelect = [[[NSUserDefaults standardUserDefaults] objectForKey:INTERFACE_OPTION] intValue];

    _fullNameLB.text = TITLE_PRODUCT_DETAIL_EMB;
    [self updateInterFaceWithOption:smgSelect];

    dtoProEMBDetailProcess = [DTOProEMBDetailProcess new];

    if (_dtoProductDetailObject) {
        NSMutableArray *resultArr = [dtoProEMBDetailProcess filterProductDetailWithClientId:_dtoProductDetailObject.clientId WithProductCode:_dtoProductDetailObject.productCode];
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


            DTOPRODUCTMASTERProcess *productMasterProcess = [DTOPRODUCTMASTERProcess new];
            NSMutableArray *resultProductMaster = [productMasterProcess filterProductWithProductCode:[proDetailDic valueForKey:@"PRODUCT_CODE"]];
            if (resultProductMaster.count>0) {
                NSDictionary *productMasterOB = [resultProductMaster objectAtIndex:0];
                [lblTenSanPhamThe setText:[productMasterOB valueForKey:DTOPRODUCTMASTER_name]];
            }

            [lblNgayBatDau setText:[proDetailDic valueForKey:@"START_DATE"]];
            [lblNgayKetThuc setText:[proDetailDic valueForKey:@"END_DATE"]];
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
