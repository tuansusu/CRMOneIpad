//
//  ProTaiKhoanThanhToanDetailViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import <UIKit/UIKit.h>


@class ProTaiKhoanThanhToanDetailViewController;

@protocol ProTaiKhoanThanhToanDetailViewControllerDelegate <NSObject>

@optional
- (void)closeProTaiKhoanThanhToanDetailView:(ProTaiKhoanThanhToanDetailViewController*)taiKhoanThanhToanDetailViewController;

@end

@interface ProTaiKhoanThanhToanDetailViewController : UIViewController

@property (nonatomic,assign) id<ProTaiKhoanThanhToanDetailViewControllerDelegate>delegate;

@end
