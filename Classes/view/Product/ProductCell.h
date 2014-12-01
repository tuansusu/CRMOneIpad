//
//  ProductCell.h
//  OfficeOneStudy
//
//  Created by viettel on 11/12/14.
//
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell

+(ProductCell *)getNewCell;

@property (weak, nonatomic) IBOutlet UILabel *lbCode;

@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet UILabel *lbDateEffect;
@property (weak, nonatomic) IBOutlet UILabel *lbEndDateEffect;
@property (weak, nonatomic) IBOutlet UIView *viewStatus;

@property (weak, nonatomic) IBOutlet UILabel *lbStatus;

-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;

@end
