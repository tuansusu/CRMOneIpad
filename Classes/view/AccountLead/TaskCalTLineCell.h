//
//  TaskCalTLineCell.h
//  OfficeOneMB
//
//  Created by Duy Pham on 12/13/14.
//
//

#import <UIKit/UIKit.h>
typedef enum
{
    TaskCalTLineCell_Top,
    TaskCalTLineCell_Middle,
    TaskCalTLineCell_Bottom
}TaskCalTLineCellType;

@interface TaskCalTLineCell : UITableViewCell

@property (nonatomic, assign) TaskCalTLineCellType tbv_position;

+ (UINib *)nib;
- (void)loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect;

@end
