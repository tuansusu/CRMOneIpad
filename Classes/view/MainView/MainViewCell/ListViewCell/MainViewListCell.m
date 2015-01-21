//
//  MainViewListCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/25/14.
//
//

#import "MainViewListCell.h"

#import "DTOWidgetObject.h"

@implementation MainViewListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:Nil] objectAtIndex:0];
        [subListMainView initData];
    }
    return self;
}

+(MainViewListCell*) initNibCell{

    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MainViewListCell" owner:nil options:nil];

    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[MainViewListCell class]])
        {
            return (MainViewListCell *) curentObject;

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


-(void)loadDataCellWithWidgetObject:(DTOWidgetObject*)widgetOB{
    [lblTitle setText:widgetOB.widgetName];
    [subListMainView initData];
}

@end
