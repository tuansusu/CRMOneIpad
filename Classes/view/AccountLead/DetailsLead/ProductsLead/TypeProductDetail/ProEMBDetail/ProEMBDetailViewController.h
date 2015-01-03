//
//  ProEMBDetailViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import <UIKit/UIKit.h>

@class ProEMBDetailViewController;
@protocol ProEMBDetailViewControllerDelegate <NSObject>

@optional
- (void)closeEMBDetailView:(ProEMBDetailViewController*)eMBDetailVC;

@end

@interface ProEMBDetailViewController : UIViewController

@property (nonatomic,assign) id<ProEMBDetailViewControllerDelegate>delegate;

@end
