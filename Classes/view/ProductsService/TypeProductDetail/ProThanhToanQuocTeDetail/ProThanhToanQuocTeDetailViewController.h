//
//  ProThanhToanQuocTeDetailViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import <UIKit/UIKit.h>

@class ProThanhToanQuocTeDetailViewController;

@protocol ProThanhToanQuocTeDetailViewControllerDelegate <NSObject>

@optional
- (void)closeThanhToanQuocTeDetailView:(ProThanhToanQuocTeDetailViewController*)ThanhToanQuocTeDetailVC;

@end

@interface ProThanhToanQuocTeDetailViewController : UIViewController

@property (nonatomic,assign) id<ProThanhToanQuocTeDetailViewControllerDelegate>delegate;

@end
