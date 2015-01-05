//
//  TaskActionCell.h
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import <UIKit/UIKit.h>

@protocol TaskActionCellDelegate;

@interface TaskActionCell : UITableViewCell

    @property (nonatomic, assign) id <TaskActionCellDelegate> delegate;

    + (UINib *)nib;
    - (void)loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect;

@end

@protocol TaskActionCellDelegate <NSObject>

    - (void)taskActionCell:(TaskActionCell *)taskActionCell changeStatusWithData:(NSMutableDictionary *)dicData;

@end