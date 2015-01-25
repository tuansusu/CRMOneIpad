//
//  ProTindungDetailViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import <UIKit/UIKit.h>

@class DTOProductDetailObject;

@class ProTindungDetailViewController;

@protocol ProTindungDetailViewControllerDelegate <NSObject>

@optional
- (void)closeProTindungDetailView:(ProTindungDetailViewController*)tinDungDetailVC;

@end

@interface ProTindungDetailViewController : UIViewController

@property (nonatomic,assign) id<ProTindungDetailViewControllerDelegate>delegate;

@property (nonatomic,retain) DTOProductDetailObject *dtoProductDetailObject;

@end
