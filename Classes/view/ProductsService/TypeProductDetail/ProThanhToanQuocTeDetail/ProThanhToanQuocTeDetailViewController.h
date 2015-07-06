//
//  ProThanhToanQuocTeDetailViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import <UIKit/UIKit.h>

@class DTOProductDetailObject;
@class ProThanhToanQuocTeDetailViewController;

@protocol ProThanhToanQuocTeDetailViewControllerDelegate <NSObject>

@optional
- (void)closeThanhToanQuocTeDetailView:(ProThanhToanQuocTeDetailViewController*)ThanhToanQuocTeDetailVC;

@end

@interface ProThanhToanQuocTeDetailViewController : BaseViewController

@property (nonatomic,assign) id<ProThanhToanQuocTeDetailViewControllerDelegate>delegate;
@property (nonatomic,retain) DTOProductDetailObject *dtoProductDetailObject;

@end
