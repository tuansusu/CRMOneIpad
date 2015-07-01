//
//  ComplainDetailViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import <UIKit/UIKit.h>
#import "EnumClass.h"
@class DTOComplainObject;
@class ComplainDetailViewController;

@protocol ComplainDetailViewControllerDelegate <NSObject>

@optional
- (void)closeComplainDetailView:(ComplainDetailViewController*)complainDetailViewController;
- (void)updateComplainDetailViewWithComplainOB:(DTOComplainObject*)complainOB;

@end

@interface ComplainDetailViewController : UIViewController

@property (nonatomic,assign) id<ComplainDetailViewControllerDelegate>delegate;
@property (nonatomic,retain) NSString *leadId;

//danh sách nhưng tooltip
@property (nonatomic, retain) NSMutableArray *visiblePopTipViews;
@property (nonatomic, strong) id currentPopTipViewTarget;

-(void)loadDataWithComplainOB:(DTOComplainObject*)complainOB;

@end
