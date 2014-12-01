//
//  EmployeeAccountCell.h
//  OfficeOneStudy
//
//  Created by viettel on 10/31/14.
//
//

#import <UIKit/UIKit.h>
#import "DTOEMPLOYEEACCOUNTProcess.h"

@interface EmployeeAccountCell : UITableViewCell




@property (weak, nonatomic) IBOutlet UILabel *lbAccountID;

@property (weak, nonatomic) IBOutlet UILabel *lbLeaderID;


-(void) loadDataToCell : (NSDictionary *) data;


@end
