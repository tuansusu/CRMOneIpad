//
//  ProposeProductCell.h
//  OfficeOneStudy
//
//  Created by viettel on 11/10/14.
//
//

#import <UIKit/UIKit.h>

@interface ProposeProductCell : UITableViewCell

+(ProposeProductCell *)getNewCell;

@property (weak, nonatomic) IBOutlet UILabel *lbName;


@property (weak, nonatomic) IBOutlet UILabel *lbMoney1;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney2;


-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;


@end
