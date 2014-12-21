//
//  TaskCalTLineCell.h
//  OfficeOneMB
//
//  Created by Duy Pham on 12/13/14.
//
//

#import <UIKit/UIKit.h>

@interface TaskCalTLineCell : UITableViewCell

+ (UINib *)nib;
- (void)loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect;

@end
