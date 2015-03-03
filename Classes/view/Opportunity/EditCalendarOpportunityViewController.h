//
//  EditCalendarLeadViewController.h
//  OfficeOneMB
//
//  Created by viettel on 12/8/14.
//
//

#import "BaseViewController.h"

@class EditCalendarOpportunityViewController;

@protocol EditCalendarOpportunityViewControllerDelegate <NSObject>

@optional
- (void)reloadListCalendarTask;

@end

@interface EditCalendarOpportunityViewController : BaseViewController

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

@property (nonatomic,assign) id<EditCalendarOpportunityViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPosition;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblEventType;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblRepeat;
@property (weak, nonatomic) IBOutlet UILabel *lblReminder;
@property (weak, nonatomic) IBOutlet UILabel *lblTypeObject;


@end
