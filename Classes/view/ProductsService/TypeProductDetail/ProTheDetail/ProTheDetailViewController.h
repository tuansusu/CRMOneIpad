//
//  ProTheDetailViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import <UIKit/UIKit.h>

@class DTOProductDetailObject;
@class ProTheDetailViewController;

@protocol ProTheDetailViewControllerDelegate <NSObject>

@optional
- (void)closeProTheDetailView:(ProTheDetailViewController*)theDetailVC;

@end

@interface ProTheDetailViewController : UIViewController

@property (nonatomic,assign) id<ProTheDetailViewControllerDelegate>delegate;
@property (nonatomic,retain) DTOProductDetailObject *dtoProductDetailObject;

@end
