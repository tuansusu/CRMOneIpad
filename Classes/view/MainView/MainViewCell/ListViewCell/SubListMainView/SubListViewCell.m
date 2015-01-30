//
//  SubListViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/26/14.
//
//

#import "SubListViewCell.h"

@implementation SubListViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:Nil] objectAtIndex:0];
    }
    return self;
}

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

-(void) loadDataToCellWithData:(NSDictionary *)dicData{

    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_title]]) {
        lblTitle.text = @"";

    }else{
        lblTitle.text = [dicData objectForKey:DTONOTE_title];
    }


    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_content]]) {
        lblDescription.text = @"";

    }else{
        lblDescription.text = [dicData objectForKey:DTONOTE_content];
    }


    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_updatedDate]]) {
        lblTime.text = @"";
    }else{
        lblTime.text = [dicData objectForKey:DTONOTE_updatedDate ] ;
    }

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
