//
//  ProBankPlusDetailViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import <UIKit/UIKit.h>

@class DTOProductDetailObject;
@class ProBankPlusDetailViewController;

@protocol ProBankPlusDetailViewControllerDelegate <NSObject>

@optional
- (void)closeBankPlusDetailView:(ProBankPlusDetailViewController*)bankPlusDetailViewController;

@end

@interface ProBankPlusDetailViewController : UIViewController

@property (nonatomic,assign) id<ProBankPlusDetailViewControllerDelegate>delegate;
@property (nonatomic,retain) DTOProductDetailObject *dtoProductDetailObject;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleMaKH;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleTenSanPhamThe;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleNgayDangKy;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleSoDienThoaiDangKy;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleRM;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleTenKH;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleTinhTrang;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleNgayCapNhat;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleCMT;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleChiNhanhPhatHanh;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
