//
//  Task360Cell.h
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/22/14.
//
//

#import <UIKit/UIKit.h>
@protocol Task360CellDelegate <NSObject>

- (void) Account360CellDelegate_ActionChangeTaskStatusWithData : (NSMutableDictionary*) dicData ;

@end
@interface Task360Cell : UITableViewCell
+(Task360Cell*) initNibCell;

@property (weak, nonatomic) id <Task360CellDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *dicData;

@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet UILabel *lbTime;


@property (weak, nonatomic) IBOutlet UIButton *btnChangeStatus;


-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;

- (IBAction)actionChangeStatus:(id)sender;
@end
