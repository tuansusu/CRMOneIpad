//
//  EditNoteViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 1/17/15.
//
//

#import "EditNoteViewCell.h"

#import "FileManagerUtil.h"

@implementation EditNoteViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:Nil] objectAtIndex:0];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadDataCellWithImageName:(NSString*)imgName{
    NSString *fullPath = [FileManagerUtil getPathWithWithName:imgName];
    if (fullPath) {
        [imgNote setImage:[UIImage imageWithContentsOfFile:fullPath]];
    }else{
        [imgNote setImage:[UIImage imageNamed:@"imageDefault"]];
    }
    [lblNoteName setText:imgName];
}

@end
