//
//  EditWidgetViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/20/15.
//
//

#import <UIKit/UIKit.h>

@class EditWidgetViewController;
@protocol EditWidgetViewControllerDelegate <NSObject>

@optional
- (void)closeEditWidgetViewController:(EditWidgetViewController*)editWidgetViewController;

@end

@interface EditWidgetViewController : UIViewController

@property (nonatomic,assign) id<EditWidgetViewControllerDelegate>delegate;

@end
