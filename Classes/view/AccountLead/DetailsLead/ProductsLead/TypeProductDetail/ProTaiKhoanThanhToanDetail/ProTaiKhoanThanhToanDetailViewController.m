//
//  ProTaiKhoanThanhToanDetailViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import "ProTaiKhoanThanhToanDetailViewController.h"

@interface ProTaiKhoanThanhToanDetailViewController ()
{

    IBOutlet UIView *mainView;

}
@end

@implementation ProTaiKhoanThanhToanDetailViewController

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
    if (_delegate && [_delegate respondsToSelector:@selector(closeProTaiKhoanThanhToanDetailView:)]) {
        [_delegate closeProTaiKhoanThanhToanDetailView:self];
    }
}

@end
