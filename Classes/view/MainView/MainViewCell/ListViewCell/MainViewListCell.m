//
//  MainViewListCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/25/14.
//
//

#import "MainViewListCell.h"

#import "DTOWidgetObject.h"
#import "Globals.h"

@implementation MainViewListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:Nil] objectAtIndex:0];
        [subListMainView initDataWithWidgetObject:_widgetOB];
        btnDelete.layer.cornerRadius = CORNER_RADIUS_BUTTON*3;
        btnDelete.clipsToBounds = YES;
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
    _widgetOB = widgetOB;
    [lblTitle setText:widgetOB.widgetName];
    [subListMainView initDataWithWidgetObject:widgetOB];
    btnDelete.layer.cornerRadius = CORNER_RADIUS_BUTTON*3;
    btnDelete.clipsToBounds = YES;
}

#pragma mark button action

-(IBAction)deleteAction:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteWidgetObject:)]) {
        [self.delegate deleteWidgetObject:_widgetOB];
    }
}

@end
