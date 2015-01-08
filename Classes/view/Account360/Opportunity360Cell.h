//
//  Opportunity360Cell.h
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/22/14.
//
//

#import <UIKit/UIKit.h>
#import "NZLabel.h"

@interface Opportunity360Cell : UITableViewCell
+(Opportunity360Cell *)getNewCell;
//@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet NZLabel *lbName;


@property (weak, nonatomic) IBOutlet UILabel *lbLevel; //tiem nang

@property (weak, nonatomic) IBOutlet UILabel *lbContact;

@property (weak, nonatomic) IBOutlet UILabel *lbDate;

@property (weak, nonatomic) IBOutlet UILabel *lbType;


-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;


@end
