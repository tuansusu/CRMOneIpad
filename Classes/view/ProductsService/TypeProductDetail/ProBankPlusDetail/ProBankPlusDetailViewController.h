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

@end