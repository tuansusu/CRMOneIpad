//
//  CompetionorCell.h
//  OfficeOneStudy
//
//  Created by viettel on 11/10/14.
//
//

#import <UIKit/UIKit.h>

@interface CompetionorCell : UITableViewCell

+(CompetionorCell *)getNewCell;

@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;

-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;


@end
