//
//  CustomerCell.m
//  OfficeOneMB
//
//  Created by Dao Xuan Luong on 2/9/15.
//
//

#import "CustomerCell.h"

@implementation CustomerCell

- (void)awakeFromNib {
    // Initialization code
}
+(CustomerCell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomerCell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[CustomerCell class]])
        {
            return (CustomerCell *) curentObject;
            
        }
    }
    
    return nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
