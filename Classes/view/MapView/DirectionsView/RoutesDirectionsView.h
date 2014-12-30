//
//  RoutesDirectionsView.h
//  OfficeOneMB
//
//  Created by macpro on 12/28/14.
//
//

#import <UIKit/UIKit.h>

@interface RoutesDirectionsView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *routesDirectionsTbv;
    NSMutableArray *_listRoutes;

    
}

-(void)loadDataTableWithRoutesList:(NSMutableArray*)routesList;

@end
