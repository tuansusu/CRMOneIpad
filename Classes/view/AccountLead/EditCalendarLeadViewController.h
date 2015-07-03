//
//  EditCalendarLeadViewController.h
//  OfficeOneMB
//
//  Created by viettel on 12/8/14.
//
//

#import "BaseViewController.h"
#import "MJDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"

@class EditCalendarLeadViewController;

@protocol EditCalendarLeadViewControllerDelegate <NSObject,UITableViewDataSource,UITableViewDelegate>

@optional
- (void)reloadListCalendarTask;

@end

@interface EditCalendarLeadViewController : BaseViewController

//DATA
/*
 * chuyen tu form danh sahc lien he(co ca clientLeaderId)
 */
@property (nonatomic, retain) NSDictionary *dataSend;

/*
 * chuyen tu form KHDM
 */
@property (nonatomic, retain) NSDictionary *dataRoot;

@property (nonatomic,assign) BOOL isKH360;

@property (nonatomic,assign) id<EditCalendarLeadViewControllerDelegate>delegate;


- (IBAction)actionDel:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDel;

@end
