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

@interface EditTaskLeadViewController : BaseViewController<SelectIndexDelegate>

//DATA
/*
 * chuyen tu form danh sahc lien he(co ca clientLeaderId)
 */
@property (nonatomic, retain) NSDictionary *dataSend;

/*
 * chuyen tu form KHDM
 */
@property (nonatomic, retain) NSDictionary *dataRoot;


@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end
