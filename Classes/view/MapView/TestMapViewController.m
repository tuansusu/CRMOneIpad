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

#import "CustomerViewCell.h"
#import "CustomInfoView.h"
#import "MapsModel.h"
#import "DTOAccountProcessObject.h"
#import "DTOAcountLeadProcessObject.h"

#define ZOOM_RATIO 15

#define BUTTON_KH_COLOR_SELECTED [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f]
#define BUTTON_KH_COLOR_DEFAULT [UIColor colorWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:0.4f]

#define KEY_MARKER_KHDM @"khdmMarkAtIndex%d"
#define KEY_MARKER_KH360 @"kh360MarkAtIndex%d"

typedef enum {
    typeKHDM,
    typeKH360
} CustomerType;

@interface TestMapViewController ()<CLLocationManagerDelegate,GMSMapViewDelegate,CustomerViewCellDelegate>
{
    NSUserDefaults *defaults;
    int smgSelect ; //option layout

    GMSMapView *mapView_;
    GMSCameraPosition *camera;
    CLLocationManager *locationManager;

    NSMutableArray *waypoints_;
    NSMutableDictionary *polyLineDic_;
    NSMutableArray *waypointStrings_;

    IBOutlet UIView *mainView;
    float zoomRatio;
    CLLocation *currentLocation;

    IBOutlet UIView *containerOptionView;
    IBOutlet UIView *customerView;
    IBOutlet UITableView *customerTbv;
    IBOutlet UIView *directionView;
    BOOL expandOptionSelected;

    NSMutableArray *listCustomerDirections;
    NSMutableArray *listKH360Flag;
    NSMutableArray *listKHDMFlag;
    MapsModel *_mapModel;
    BOOL khdmSelected;
    IBOutlet UIButton *btnKHDM;
    IBOutlet UIButton *btnKH360;
    IBOutlet UIImageView *imgCusSelected;
    IBOutlet UIImageView *imgDirSelected;
    CustomerType customerType;
    NSInteger indexDirectionSelected;
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

    _mapModel = [[MapsModel alloc] init];
    listCustomerDirections = [[NSMutableArray alloc] init];
    listKH360Flag = [[NSMutableArray alloc] init];
    listKHDMFlag = [[NSMutableArray alloc] init];
    waypoints_ = [[NSMutableArray alloc]init];
    polyLineDic_ = [[NSMutableDictionary alloc] init];
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

    marker.map = mapView_;
    [waypoints_ addObject:marker];
    NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",_lan,_lon];
    [waypointStrings_ addObject:positionString];

    [self initLocation];
    [self initDataKH];

    //    DTOAcountLeadProcessObject *customerData=[_mapModel.listCustomerKHDM objectAtIndex:1];
    //    [marker setUserData:customerData];
}

-(void)initDataKH{

    [_mapModel getFirstPageCustomerKHDM];
    [_mapModel getFirstPageCustomerKH360];
    [customerTbv reloadData];
    [self initFirstPageKHDMDirectionsFlag];
    [self initFirstPageKHD360irectionsFlag];
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

#pragma mark list directions action

-(void)initFirstPageKHDMDirectionsFlag{
    [listKHDMFlag removeAllObjects];
    if (_mapModel.listCustomerKHDM.count>0) {
        for (int i=0;i<_mapModel.listCustomerKHDM.count;i++) {
            DTOAcountLeadProcessObject *khdmOB = [_mapModel.listCustomerKHDM objectAtIndex:i];
            if (khdmOB.lat && khdmOB.lon) {
                [self addMarkerCustomerithKHDMOB:khdmOB];
            }
            [listKHDMFlag addObject:@"NO"];
        }
    }
}
-(void)updateNextPageKHDMDirectionsFlag{

    for (int i=listKHDMFlag.count;i<_mapModel.listCustomerKHDM.count;i++) {
        DTOAcountLeadProcessObject *khdmOB = [_mapModel.listCustomerKHDM objectAtIndex:i];
        if (khdmOB.lat && khdmOB.lon) {
            [self addMarkerCustomerithKHDMOB:khdmOB];
        }
        [listKHDMFlag addObject:@"NO"];
    }

}

-(void)initFirstPageKHD360irectionsFlag{
    [listKH360Flag removeAllObjects];
    if (_mapModel.listCustomerKH360.count>0) {
        for (int i=0;i<_mapModel.listCustomerKH360.count;i++) {
            DTOAccountProcessObject *kh360OB = [_mapModel.listCustomerKH360 objectAtIndex:i];
            if (kh360OB.lat && kh360OB.lon) {
                [self addMarkerCustomerithKH360OB:kh360OB];
            }
            [listKH360Flag addObject:@"NO"];
        }
    }
}
-(void)updateNextPageKH360DirectionsFlag{
    for (int i=listKH360Flag.count;i<_mapModel.listCustomerKH360.count;i++) {
        DTOAccountProcessObject *kh360OB = [_mapModel.listCustomerKH360 objectAtIndex:i];
        if (kh360OB.lat && kh360OB.lon) {
            [self addMarkerCustomerithKH360OB:kh360OB];
        }
        [listKH360Flag addObject:@"NO"];
    }
}


- (void)updatelistCustomerDirectionsFlagAtIndex:(int)index withStatus:(NSString *)status
{
    if (khdmSelected) {
        [listKHDMFlag replaceObjectAtIndex:index withObject:status];
    }else{
        [listKH360Flag replaceObjectAtIndex:index withObject:status];
    }

}

#pragma mark add Marker customer to map view

-(void)addMarkerCustomerithKHDMOB:(DTOAcountLeadProcessObject*)khdmOB{
    GMSMarker *marker = [[GMSMarker alloc] init];

    marker.position = CLLocationCoordinate2DMake([khdmOB.lat floatValue], [khdmOB.lon floatValue]);
    DTOAcountLeadProcessObject *customerData=khdmOB;
    [marker setUserData:customerData];
    marker.map = mapView_;
}

-(void)addMarkerCustomerithKH360OB:(DTOAccountProcessObject*)kh360OB{
    GMSMarker *marker = [[GMSMarker alloc] init];

    marker.position = CLLocationCoordinate2DMake([kh360OB.lat floatValue], [kh360OB.lon floatValue]);
    DTOAccountProcessObject *customerData=kh360OB;
    [marker setUserData:customerData];
    marker.map = mapView_;
}


#pragma mark Button action

#pragma mark tim duong di ngan nhat action
-(IBAction)btnTDDNNSelected:(id)sender{
    //    if([waypoints_ count]>1){
    //        NSString *sensor = @"false";
    //        NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
    //                               nil];
    //        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
    //        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
    //                                                          forKeys:keys];
    //        MDDirectionService *mds=[[MDDirectionService alloc] init];
    //        SEL selector = @selector(addDirections:);
    //        [mds setDirectionsQuery:query
    //                   withSelector:selector
    //                   withDelegate:self];
    //    }
}

#pragma mark change kh action
-(IBAction)btnKH360Selected:(id)sender{
    [btnKH360 setBackgroundColor:BUTTON_KH_COLOR_SELECTED];
    [btnKH360 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btnKHDM setBackgroundColor:BUTTON_KH_COLOR_DEFAULT];
    [btnKHDM setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (khdmSelected) {
        khdmSelected = NO;
        [customerTbv reloadData];
    }
}

-(IBAction)btnKHDMSelected:(id)sender{

    [btnKHDM setBackgroundColor:BUTTON_KH_COLOR_SELECTED];
    [btnKHDM setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (!khdmSelected) {
        khdmSelected = YES;
        [customerTbv reloadData];
    }

    [btnKH360 setBackgroundColor:BUTTON_KH_COLOR_DEFAULT];
    [btnKH360 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

#pragma mark tab action
-(IBAction)btnCustomerTabAction:(id)sender{

    [customerView setHidden:NO];
    [directionView setHidden:YES];

    [imgCusSelected setHidden:NO];
    [imgDirSelected setHidden:YES];
}

-(IBAction)btnDirectionTabAction:(id)sender{
    [directionView setHidden:NO];
    [customerView setHidden:YES];

    [imgCusSelected setHidden:YES];
    [imgDirSelected setHidden:NO];
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
    //    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(
    //                                                                 coordinate.latitude,
    //                                                                 coordinate.longitude);
}

- (void)addDirections:(NSDictionary *)json {

    NSDictionary *routes = [json objectForKey:@"routes"][0];

    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
    NSString *overview_route = [route objectForKey:@"points"];
    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.map = mapView_;
    if (customerType==typeKHDM) {
        [polyLineDic_ setObject:polyline forKey:[NSString stringWithFormat:@"%@%d",KEY_MARKER_KHDM,indexDirectionSelected]];
    }else if(customerType==typeKH360){
        [polyLineDic_ setObject:polyline forKey:[NSString stringWithFormat:@"%@%d",KEY_MARKER_KH360,indexDirectionSelected]];
    }

}

- (void)removeDirectionsWithTypeCustomer:(CustomerType)cusType withInxex:(NSInteger)index {
    GMSPolyline *polyline;
    if (cusType==typeKHDM) {
        polyline =[polyLineDic_ objectForKey:[NSString stringWithFormat:@"%@%d",KEY_MARKER_KHDM,index]];
    }else if(cusType==typeKH360){
        polyline =[polyLineDic_ objectForKey:[NSString stringWithFormat:@"%@%d",KEY_MARKER_KH360,index]];
    }
    if (polyline) {
        polyline.map = nil;
    }
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    CustomInfoView *infoView = [[CustomInfoView alloc] initWithFrame:CGRectZero];

    if ([marker.userData isKindOfClass:[DTOAcountLeadProcessObject class]]) {
        DTOAcountLeadProcessObject *customerData= marker.userData;
        [infoView loadViewWithKHDMOB:customerData];
    }else if ([marker.userData isKindOfClass:[DTOAccountProcessObject class]]) {
        DTOAccountProcessObject *customerData= marker.userData;
        [infoView loadViewWithKH360OB:customerData];
    }

    return infoView;
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
    if (khdmSelected) {
        return  _mapModel.listCustomerKHDM.count;
    }else{
        return _mapModel.listCustomerKH360.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CustomerViewCell";
    CustomerViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];

    if (!cell) {
        cell = [CustomerViewCell initNibCell];
        cell.delegate = self;
    }
    if (khdmSelected) {
        if (_mapModel.listCustomerKHDM.count>0) {
            DTOAcountLeadProcessObject *khdmOB = [_mapModel.listCustomerKHDM objectAtIndex:indexPath.row];
            [cell loadDataToCellWithKHDMOB:khdmOB withStatus:[listKHDMFlag objectAtIndex:indexPath.row]];

        }
    }else{
        if (_mapModel.listCustomerKH360.count>0) {
            DTOAccountProcessObject *kh360OB = [_mapModel.listCustomerKH360 objectAtIndex:indexPath.row];
            [cell loadDataToCellWithKH360OB:kh360OB withStatus:[listKH360Flag objectAtIndex:indexPath.row]];
        }
    }

    return cell;

}

#pragma mark Customer Cell Delegate

- (void)didSelectedAtCell:(id)cell withStatus:(NSString *)status
{
    CustomerViewCell *currentCell = (CustomerViewCell *)cell;
    NSIndexPath *indexPath = [customerTbv indexPathForCell:currentCell];

    [self updatelistCustomerDirectionsFlagAtIndex:indexPath.row withStatus:status];
    [customerTbv reloadData];
    if (khdmSelected) {
        DTOAcountLeadProcessObject *khdmOB = [_mapModel.listCustomerKHDM objectAtIndex:indexPath.row];

        if ([status isEqualToString:@"YES"]) {
            [listCustomerDirections addObject:khdmOB];
            if (khdmOB.lat && khdmOB.lon) {
                GMSMarker *marker = [[GMSMarker alloc] init];

                marker.position = CLLocationCoordinate2DMake([khdmOB.lat floatValue], [khdmOB.lon floatValue]);
                [marker setUserData:khdmOB];

                [waypoints_ addObject:marker];
                NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
                                            [khdmOB.lat floatValue],[khdmOB.lon floatValue]];
                [waypointStrings_ addObject:positionString];
                if([waypoints_ count]>1){
                    NSString *sensor = @"false";
                    NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
                                           nil];
                    NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
                    NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                                      forKeys:keys];
                    MDDirectionService *mds=[[MDDirectionService alloc] init];
                    customerType = typeKHDM;
                    indexDirectionSelected = indexPath.row;
                    SEL selector = @selector(addDirections:);
                    [mds setDirectionsQuery:query
                               withSelector:selector
                               withDelegate:self];
                }
            }

        }else{
            [self removeDirectionsWithTypeCustomer:typeKHDM withInxex:indexPath.row];
            [listCustomerDirections removeObject:khdmOB];
        }

    }else{
        DTOAccountProcessObject *kh360OB = [_mapModel.listCustomerKH360 objectAtIndex:indexPath.row];
        if ([status isEqualToString:@"YES"]) {
            [listCustomerDirections addObject:kh360OB];
            if (kh360OB.lat && kh360OB.lon) {
                GMSMarker *marker = [[GMSMarker alloc] init];

                marker.position = CLLocationCoordinate2DMake([kh360OB.lat floatValue], [kh360OB.lon floatValue]);
                [marker setUserData:kh360OB];

                [waypoints_ addObject:marker];
                NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
                                            [kh360OB.lat floatValue],[kh360OB.lon floatValue]];
                [waypointStrings_ addObject:positionString];

                if([waypoints_ count]>1){

                    NSString *sensor = @"false";
                    NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
                                           nil];
                    NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
                    NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                                      forKeys:keys];
                    MDDirectionService *mds=[[MDDirectionService alloc] init];
                    customerType = typeKH360;
                    indexDirectionSelected = indexPath.row;
                    SEL selector = @selector(addDirections:);
                    [mds setDirectionsQuery:query
                               withSelector:selector
                               withDelegate:self];

                }
            }
        }else{
            [self removeDirectionsWithTypeCustomer:typeKH360 withInxex:indexPath.row];
            [listCustomerDirections removeObject:kh360OB];
        }

    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;

    if (currentOffset - maximumOffset >= 40) {
        if (khdmSelected) {
            [_mapModel getNextPageCustomerKHDM];
            [customerTbv reloadData];
            [self updateNextPageKHDMDirectionsFlag];
        }else{
            [_mapModel getNextPageCustomerKH360];
            [customerTbv reloadData];
            [self updateNextPageKH360DirectionsFlag];
        }
    }
}


@end
