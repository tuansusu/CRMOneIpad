//
//  TestMapViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/29/14.
//
//

#import "TestMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MDDirectionService.h"
#import "DTOACCOUNTLEADProcess.h"
#import "CustomerViewCell.h"

#define ZOOM_RATIO 15

#define BTN_TAG_CUSTOMER 1
#define BTN_TAG_CUSTOMER 2
#define BTN_TAG_CUSTOMER 3

@interface TestMapViewController ()<CLLocationManagerDelegate,GMSMapViewDelegate,CustomerViewCellDelegate>
{
    NSUserDefaults *defaults;
    int smgSelect ; //option layout

    GMSMapView *mapView_;
    GMSCameraPosition *camera;
    CLLocationManager *locationManager;

    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;
    IBOutlet UIView *mainView;
    float zoomRatio;
    CLLocation *currentLocation;

    IBOutlet UIView *containerOptionView;
    IBOutlet UIView *customerView;
    IBOutlet UITableView *customerTbv;
    IBOutlet UIView *directionView;
    BOOL expandOptionSelected;
    NSArray *arrayData;
    DTOACCOUNTLEADProcess *dtoLeadProcess;
}
@end

@implementation TestMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    waypoints_ = [[NSMutableArray alloc]init];
    waypointStrings_ = [[NSMutableArray alloc]init];

    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];

    }

    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];

    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    // add start location
    NSLog(@"_lan = %f : _lon = %f", _lan, _lon);
    _lan = 21.032439554704172;
    _lon = 105.79308874905109;
    zoomRatio = ZOOM_RATIO;
    camera = [GMSCameraPosition cameraWithLatitude:_lan
                                         longitude:_lon
                                              zoom:zoomRatio];

    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.height)  camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.delegate = self;
    [mainView addSubview:mapView_];

    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];


    //marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.position = CLLocationCoordinate2DMake(_lan, _lon);
    //marker.title = @"Sydney";
    if (![StringUtil stringIsEmpty:_address]) {
        marker.title = _address;
    }else{
        marker.title =@"";
    }
    marker.snippet = @"Viet Nam";
    marker.map = mapView_;
    [waypoints_ addObject:marker];
    NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
                                _lan,_lon];
    [waypointStrings_ addObject:positionString];

    [self initLocation];
    [self initData];

}

-(void)initData{
    dtoLeadProcess = [DTOACCOUNTLEADProcess new];
    arrayData  = [NSArray new];
    arrayData = [dtoLeadProcess filter];
    [customerTbv reloadData];
}

//Home button
- (IBAction)homeBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
}

- (void) updateInterFaceWithOption : (int) option
{
    //self.fullNameLB.text = TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Button action

#pragma mark tab action
-(IBAction)btnCustomerTabAction:(id)sender{

    [customerView setHidden:NO];
    [directionView setHidden:YES];
}

-(IBAction)btnDirectionTabAction:(id)sender{
    [directionView setHidden:NO];
    [customerView setHidden:YES];
}

-(IBAction)btnExpandTabAction:(id)sender{
    if (expandOptionSelected) {
        [containerOptionView setHidden:NO];
        expandOptionSelected= NO;
    }else{
        [containerOptionView setHidden:YES];
        expandOptionSelected= YES;
    }
}


-(IBAction)btnZoomPlusAction:(id)sender{
    if (zoomRatio<21) {
        zoomRatio+=1;
        CGPoint point = mapView_.center;
        CLLocationCoordinate2D coor = [mapView_.projection coordinateForPoint:point];
        camera = [GMSCameraPosition cameraWithLatitude:coor.latitude
                                             longitude:coor.longitude
                                                  zoom:zoomRatio];
        GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setCamera:camera];
        [mapView_ animateWithCameraUpdate:cameraUpdate];
    }
}
-(IBAction)btnZoomMinusAction:(id)sender{
    if (zoomRatio>1) {
        zoomRatio-=1;
        CGPoint point = mapView_.center;
        CLLocationCoordinate2D coor = [mapView_.projection coordinateForPoint:point];
        camera = [GMSCameraPosition cameraWithLatitude:coor.latitude
                                             longitude:coor.longitude
                                                  zoom:zoomRatio];
        GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setCamera:camera];
        [mapView_ animateWithCameraUpdate:cameraUpdate];
    }
}

-(IBAction)btnCurrentLocationAction:(id)sender{
    if (currentLocation) {
        camera = [GMSCameraPosition cameraWithLatitude:currentLocation.coordinate.latitude
                                             longitude:currentLocation.coordinate.longitude
                                                  zoom:zoomRatio];
        GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setCamera:camera];
        [mapView_ animateWithCameraUpdate:cameraUpdate];
    }else{
        [[[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_NotGetCurrentLocation delegate:nil cancelButtonTitle:SYS_Notification_CancelTitle otherButtonTitles: nil] show];
    }
}

#pragma mark init location
-(void)initLocation{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];

    [locationManager startUpdatingLocation];
}

#pragma mark location delegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    currentLocation = [locations lastObject];
    NSLog(@"currentLocation lat : %f - currentLocation lon : %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
}

#pragma mark map delegate
/**
 * Called after a long-press gesture at a particular coordinate.
 *
 * @param mapView The map view that was pressed.
 * @param coordinate The location that was pressed.
 */
- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate{
    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:coordinate completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error) {
        NSLog(@"reverse geocoding results:");
        for(GMSAddress* addressObj in [response results])
        {
            NSLog(@"coordinate.latitude=%f", addressObj.coordinate.latitude);
            NSLog(@"coordinate.longitude=%f", addressObj.coordinate.longitude);
            NSLog(@"thoroughfare=%@", addressObj.thoroughfare);
            NSLog(@"locality=%@", addressObj.locality);
            NSLog(@"subLocality=%@", addressObj.subLocality);
            NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
            NSLog(@"postalCode=%@", addressObj.postalCode);
            NSLog(@"country=%@", addressObj.country);
            NSLog(@"lines=%@", addressObj.lines);
        }
    }];
}


/**
 * Called after a tap gesture at a particular coordinate, but only if a marker
 * was not tapped.  This is called before deselecting any currently selected
 * marker (the implicit action for tapping on the map).
 */
- (void)mapView:(GMSMapView *)mapView
didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(
                                                                 coordinate.latitude,
                                                                 coordinate.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.map = mapView_;
    [waypoints_ addObject:marker];
    NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
                                coordinate.latitude,coordinate.longitude];
    [waypointStrings_ addObject:positionString];
    if([waypoints_ count]>1){
        NSString *sensor = @"false";
        NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
                               nil];
        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                          forKeys:keys];
        MDDirectionService *mds=[[MDDirectionService alloc] init];
        SEL selector = @selector(addDirections:);
        [mds setDirectionsQuery:query
                   withSelector:selector
                   withDelegate:self];
    }
}

- (void)addDirections:(NSDictionary *)json {

    NSDictionary *routes = [json objectForKey:@"routes"][0];

    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
    NSString *overview_route = [route objectForKey:@"points"];
    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.map = mapView_;
}

#pragma mark tableview delegate
#pragma mark - Table View


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return  arrayData.count;


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CustomerViewCell";
    CustomerViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];

    if (!cell) {
        cell = [CustomerViewCell initNibCell];
        cell.delegate = self;
    }

    if (arrayData.count>0) {
        [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row]];
//        cell.delegate = (id<AccountLeadCellDelegate>) self;
    }

    return cell;

}

#pragma mark Customer Cell Delegate

- (void)didSelectedAtCell:(id)cell
{
    CustomerViewCell *currentCell = (CustomerViewCell *)cell;
    NSIndexPath *indexPath = [customerTbv indexPathForCell:currentCell];

    NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection){

        [tableView deselectRowAtIndexPath:selection animated:YES];
    }

    NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];



//    DetailLeadViewController *viewController = [[DetailLeadViewController alloc]initWithNibName:@"DetailLeadViewController" bundle:nil];
//    viewController.dataSend = dicData;
//    [self presentViewController:viewController animated:YES completion:nil];

}



@end
