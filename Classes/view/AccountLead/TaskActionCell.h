//
//  TaskActionCell.h
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import <UIKit/UIKit.h>

@protocol TaskActionCellDelegate <NSObject>

- (void) AccountLeadCellDelegate_ActionChangeTaskStatusWithData : (NSMutableDictionary*) dicData ;

@end

@interface TaskActionCell : UITableViewCell

+(TaskActionCell*) initNibCell;

@property (weak, nonatomic) id <TaskActionCellDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *dicData;

@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet UILabel *lbTime;


@property (weak, nonatomic) IBOutlet UIButton *btnChangeStatus;


-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;

- (IBAction)actionChangeStatus:(id)sender;

@end
