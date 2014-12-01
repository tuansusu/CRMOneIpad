//
//  ListEmployeeAccountViewController.h
//  OfficeOneStudy
//
//  Created by viettel on 10/31/14.
//
//

#import "BaseViewController.h"
#import "DTOEMPLOYEEACCOUNTProcess.h"
#import "EmployeeAccountCell.h"

@interface ListEmployeeAccountViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tbData;

@end
