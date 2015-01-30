//
//  EditNoteViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 1/17/15.
//
//

#import <UIKit/UIKit.h>

@interface EditNoteViewCell : UITableViewCell
{
    IBOutlet UIImageView *imgNote;
    IBOutlet UILabel *lblNoteName;
}

-(void)loadDataCellWithImageName:(NSString*)imgName;

@end
