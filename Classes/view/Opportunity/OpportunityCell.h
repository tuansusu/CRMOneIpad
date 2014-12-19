//
//  OpportunityCell.h
//  OfficeOneStudy
//
//  Created by ADMIN on 10/31/14.
//
//

#import <UIKit/UIKit.h>
#import "NZLabel.h"

@interface OpportunityCell : UITableViewCell

+(OpportunityCell *)getNewCell;
//@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet NZLabel *lbName;


@property (weak, nonatomic) IBOutlet UILabel *lbLevel; //tiem nang

@property (weak, nonatomic) IBOutlet UILabel *lbContact;

@property (weak, nonatomic) IBOutlet UILabel *lbDate;

@property (weak, nonatomic) IBOutlet UILabel *lbType;


-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;

@end
