//
//  ProposeProductPopupCell.h
//  OfficeOneMB
//
//  Created by viettel on 4/16/15.
//
//

#import <UIKit/UIKit.h>

@interface ProposeProductPopupCell : UITableViewCell

+(ProposeProductPopupCell *)getNewCell;

@property (weak, nonatomic) IBOutlet UILabel *lbName;


@property (weak, nonatomic) IBOutlet UILabel *lbMoney2;


-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;


@end
