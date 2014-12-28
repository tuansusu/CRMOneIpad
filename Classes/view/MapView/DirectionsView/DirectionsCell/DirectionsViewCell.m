//
//  DirectionsViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/28/14.
//
//

#import "DirectionsViewCell.h"

@implementation DirectionsViewCell

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

-(void)loadDataCellWithStepOB:(UICGStep*)stepOB{
    [lblDescription setText:stepOB.htmlInstructions];
}

@end
