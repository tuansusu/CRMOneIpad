//
//  CustomerViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/17/14.
//
//

#import "CustomerViewCell.h"

@implementation CustomerViewCell

+(CustomerViewCell*) initNibCell{

    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomerViewCell" owner:nil options:nil];

    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[CustomerViewCell class]])
        {
            return (CustomerViewCell *) curentObject;

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

-(void) loadDataToCellWithData:(NSDictionary *)dicData{
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_name]]) {
        lblName.text = [dicData objectForKey:DTOLEAD_name];
    }
}

-(IBAction)cellSelectedAtIndex:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedAtCell:)]) {
        [_delegate didSelectedAtCell:self];
    }
}

@end
