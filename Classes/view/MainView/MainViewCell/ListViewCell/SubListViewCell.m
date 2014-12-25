//
//  SubListViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/26/14.
//
//

#import "SubListViewCell.h"

@implementation SubListViewCell

+(SubListViewCell*) initNibCell{

    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SubListViewCell" owner:nil options:nil];

    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[SubListViewCell class]])
        {
            return (SubListViewCell *) curentObject;

        }
    }
    
    return nil;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
