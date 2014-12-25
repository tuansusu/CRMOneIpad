//
//  MainViewListCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/25/14.
//
//

#import "MainViewListCell.h"
#import "SubListViewCell.h"

@implementation MainViewListCell

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

#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return  0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *cellId = @"SubListViewCell";
        SubListViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];

        if (!cell) {
            cell = [SubListViewCell initNibCell];
        }
        return cell;
}

@end
