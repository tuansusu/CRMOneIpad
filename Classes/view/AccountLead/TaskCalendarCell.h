//
//  TaskCalendarCell.h
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import <UIKit/UIKit.h>

@interface TaskCalendarCell : UITableViewCell


+(TaskCalendarCell*) initNibCell;
@property (nonatomic, strong) NSDictionary *dicData;
-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbTime;

@property (weak, nonatomic) IBOutlet UILabel *lbAddress;

@end
