//
//  TaskOpportunityCell.h
//  OfficeOneMB
//
//  Created by viettel on 12/26/14.
//
//

#import <UIKit/UIKit.h>

@interface TaskOpportunityCell : UITableViewCell

+(TaskOpportunityCell *)getNewCell;

@property (weak, nonatomic) IBOutlet UILabel *lbName;


@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;

@property (weak, nonatomic) IBOutlet UIButton *btnChangeStatus;

-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;
@end
