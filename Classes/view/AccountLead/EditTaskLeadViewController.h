//
//  EditTaskLeadViewController.h
//  OfficeOneMB
//
//  Created by viettel on 12/7/14.
//
//

#import "BaseViewController.h"
#import "CalendarPickerViewController.h"
#import "SelectIndexViewController.h"

@class EditTaskLeadViewController;

@protocol EditTaskLeadViewControllerDelegate <NSObject,UITableViewDataSource,UITableViewDelegate>

@optional
- (void)closeEditTaskLeadViewController:(EditTaskLeadViewController*)editTaskLeadViewController;

@end

@interface EditTaskLeadViewController : BaseViewController<SelectIndexDelegate>

@property (nonatomic,assign) id<EditTaskLeadViewControllerDelegate>delegate;

//DATA
/*
 * chuyen tu form danh sahc lien he(co ca clientLeaderId)
 */
@property (nonatomic, retain) NSDictionary *dataSend;

/*
 * chuyen tu form KHDM
 */
@property (nonatomic, retain) NSDictionary *dataRoot;

@property (nonatomic,assign) BOOL isKHDM;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end
