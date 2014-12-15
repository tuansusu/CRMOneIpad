//
//  NoteLeadCell.h
//  OfficeOneMB
//
//  Created by viettel on 12/8/14.
//
//

#import <UIKit/UIKit.h>

@interface NoteLeadCell : UITableViewCell

+(NoteLeadCell*) initNibCell;


@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet UILabel *lbDescription;

@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgFile;



-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;

@end
