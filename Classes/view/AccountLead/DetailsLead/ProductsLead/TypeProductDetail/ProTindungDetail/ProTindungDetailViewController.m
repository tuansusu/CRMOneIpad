//
//  ProTindungDetailViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import "ProTindungDetailViewController.h"

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
}

@end

@implementation ProTindungDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    mainView.layer.cornerRadius = 20;
    mainView.layer.masksToBounds = YES;
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
    if (_delegate && [_delegate respondsToSelector:@selector(closeProTindungDetailView:)]) {
        [_delegate closeProTindungDetailView:self];
    }
}

@end
