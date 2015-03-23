//
//  ClueContactCell.h
//  OfficeOneStudy
//
//  Created by viettel on 11/11/14.
//
//

#import <UIKit/UIKit.h>

@interface ClueContactCell : UITableViewCell

+(ClueContactCell *)getNewCell;

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbMobile;

@property (weak, nonatomic) IBOutlet UILabel *lbEmail;

@property (weak, nonatomic) IBOutlet UILabel *lbPosition;


-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect;

@end
