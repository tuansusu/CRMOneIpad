//
//  TaskCalendarCell.h
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import <UIKit/UIKit.h>

@interface TaskCalendarCell : UITableViewCell

+ (UINib *)nib;
- (void)loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect;

@end
