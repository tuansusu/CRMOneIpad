//
//  RoutesDirectionsView.m
//  OfficeOneMB
//
//  Created by macpro on 12/28/14.
//
//

#import "RoutesDirectionsView.h"
#import "DirectionsHeaderView.h"
#import "DirectionsViewCell.h"
#import "UICGRoute.h"
#import "Globals.h"

@implementation RoutesDirectionsView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)loadDataTableWithRoutesList:(NSMutableArray*)routesList{
    _listRoutes = routesList;
    [routesDirectionsTbv reloadData];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return _listRoutes.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DirectionsHeaderView *directionsSectionView = [[DirectionsHeaderView alloc] init];

    UICGRoute *routesOB = [_listRoutes objectAtIndex:section];

    [directionsSectionView loadViewWithTittle:routesOB.endAddress withImage:[UIImage imageNamed:ICON_END_ROUTES_OF_DIRECTION]];

    return directionsSectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    UICGRoute *routesOB = [_listRoutes objectAtIndex:section];
    return routesOB.steps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellId = @"DirectionsViewCell";
    DirectionsViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[DirectionsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];

        UICGRoute *routesOB = [_listRoutes objectAtIndex:indexPath.section];
        UICGStep *stepOB = [routesOB.steps objectAtIndex:indexPath.row];
        [cell loadDataCellWithStepOB:stepOB];
    }
    return cell;

}

@end
