//
//  ProBaoLanhDetailViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import <UIKit/UIKit.h>

@class ProBaoLanhDetailViewController;

@protocol ProBaoLanhDetailViewControllerDelegate <NSObject>

@optional
- (void)closeProBaoLanhDetailView:(ProBaoLanhDetailViewController*)baoLanhDetailViewController;

@end

@interface ProBaoLanhDetailViewController : UIViewController

@property (nonatomic,assign) id<ProBaoLanhDetailViewControllerDelegate>delegate;

@end
