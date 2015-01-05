//
//  ProTaiKhoanTietKiemDetailViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import <UIKit/UIKit.h>

@class ProTaiKhoanTietKiemDetailViewController;

@protocol ProTaiKhoanTietKiemDetailViewControllerDelegate <NSObject>

@optional
- (void)closeTaiKhoanTietKiemDetailView:(ProTaiKhoanTietKiemDetailViewController*)taiKhoanTietKiemDetailVC;

@end

@interface ProTaiKhoanTietKiemDetailViewController : UIViewController

@property (nonatomic,assign) id<ProTaiKhoanTietKiemDetailViewControllerDelegate>delegate;

@end
