//
//  TestMapViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/29/14.
//
//

#import "TestMapViewController.h"





#define ZOOM_RATIO 15

#define BUTTON_KH_COLOR_SELECTED [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f]
#define BUTTON_KH_COLOR_DEFAULT [UIColor colorWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:0.4f]




@interface TestMapViewController ()<CLLocationManagerDelegate,GMSMapViewDelegate,CustomerViewCellDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,CustomInfoViewDelegate>
{
    NSUserDefaults *defaults;
    int smgSelect ; //option layout

    GMSMapView *mapView_;
    GMSCameraPosition *camera;
    CLLocationManager *locationManager;

    NSMutableArray *waypoints_;
    NSMutableDictionary *polyLineDic_;
    NSMutableDictionary *wayPointDic_;
    NSMutableArray *waypointStrings_;
    NSMutableDictionary *wayPointStrDic_;

    NSMutableArray *listRoutes;
    NSMutableDictionary *listRoutesDic;

    IBOutlet UIView *mainView;
    float zoomRatio;
    CLLocation *currentLocation;

    IBOutlet UIView *containerOptionView;
    IBOutlet UIView *customerView;
    IBOutlet UITableView *customerTbv;

    IBOutlet UIView *directionView;
    IBOutlet RoutesDirectionsView *routesDirectionsView;
    BOOL expandOptionSelected;

    NSMutableArray *listCustomerDirections;
    NSMutableArray *listKH360Flag;
    NSMutableArray *listKHDMFlag;
    MapsModel *_mapModel;
    BOOL khdmSelected;
    IBOutlet UIButton *btnKHDM;
    IBOutlet UIButton *btnKH360;

    IBOutlet UIButton *btnCar;
    IBOutlet UIButton *btnMoto;
    IBOutlet UIButton *btnWalking;
    IBOutlet UIImageView *imgCarSelected;
    IBOutlet UIImageView *imgMotoSelected;
    IBOutlet UIImageView *imgWalkingSelected;

    IBOutlet UISearchBar *searchBarCustomer;

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
    // init mode vehicles
    [[NSUserDefaults standardUserDefaults] setValue:VEHICLES_DRIVING forKey:VEHICLES_SELECTED];

    _mapModel = [[MapsModel alloc] init];
    listCustomerDirections = [[NSMutableArray alloc] init];
    listKH360Flag = [[NSMutableArray alloc] init];
    listKHDMFlag = [[NSMutableArray alloc] init];
    waypoints_ = [[NSMutableArray alloc]init];
    polyLineDic_ = [[NSMutableDictionary alloc] init];
    wayPointDic_ = [[NSMutableDictionary alloc] init];
    wayPointStrDic_ = [[NSMutableDictionary alloc] init];
    waypointStrings_ = [[NSMutableArray alloc]init];

    listRoutes = [[NSMutableArray alloc]init];
    listRoutesDic = [[NSMutableDictionary alloc] init];

    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];

    }

    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];

    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];

    zoomRatio = ZOOM_RATIO;

    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.height)  camera:nil];
    mapView_.myLocationEnabled = YES;
    mapView_.delegate = self;
    [mainView addSubview:mapView_];

    // Creates a marker in the center of the map.


    [self initLocation];


    if (self.typeMapView == typeMapView_Manager) {
        [self initDataKH];
    }else{
        self.viewMap1.hidden = YES;
        self.viewMap2.hidden = YES;
        self.imgHomeMenu.image = [UIImage imageNamed:@"btn-back-1-1.png"];
        
        
        
        //fix vi tri mac dinh la HaNoi :d
        zoomRatio = ZOOM_RATIO*0.9;
        camera = [GMSCameraPosition cameraWithLatitude:21.0215447f
                                             longitude:105.8395089f
                                                  zoom:zoomRatio];
        mapView_.camera = camera;
        
    }
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);

}



-(void)initDataKH{
    [_mapModel getFirstPageCustomerKHDMWithKey:searchBarCustomer.text];
    [_mapModel getFirstPageCustomerKH360WithKey:searchBarCustomer.text];
    [customerTbv reloadData];
    [self initFirstPageKHDMDirectionsFlag];
    [self initFirstPageKHD360irectionsFlag];
}

//Home button
- (IBAction)homeBack:(id)sender {


    if (self.typeMapView == typeMapView_Manager) {
        [Util backToHome:self];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (void) updateInterFaceWithOption : (int) option
{

    for (UIView *viewTemp in self.viewMap1.subviews) {

        if ([viewTemp isKindOfClass:[UIImageView class]]) {

            [((UIImageView*) viewTemp) setAlpha:1.0f];
        }

    }

    for (UIView *viewTemp in directionView.subviews) {
        for (UIView *subview in viewTemp.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {

                [((UIImageView*) subview) setAlpha:1.0f];
            }
        }
    }
    //self.fullNameLB.text = TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;


    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];


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
        [_mapModel getFirstPageCustomerKH360WithKey:searchBarCustomer.text];
        [customerTbv reloadData];
    }
}

-(IBAction)btnKHDMSelected:(id)sender{

    [btnKHDM setBackgroundColor:BUTTON_KH_COLOR_SELECTED];
    [btnKHDM setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (!khdmSelected) {
        khdmSelected = YES;
        [_mapModel getFirstPageCustomerKHDMWithKey:searchBarCustomer.text];
        [customerTbv reloadData];
    }

    [btnKH360 setBackgroundColor:BUTTON_KH_COLOR_DEFAULT];
    [btnKH360 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

#pragma mark vehicles action
-(IBAction)btnCarSelected:(id)sender{
    [imgCarSelected setHidden:NO];
    [imgMotoSelected setHidden:YES];
    [imgWalkingSelected setHidden:YES];
    [[NSUserDefaults standardUserDefaults] setValue:VEHICLES_DRIVING forKey:VEHICLES_SELECTED];
}

-(IBAction)btnMotoSelected:(id)sender{
    [imgCarSelected setHidden:YES];
    [imgMotoSelected setHidden:NO];
    [imgWalkingSelected setHidden:YES];
    [[NSUserDefaults standardUserDefaults] setValue:VEHICLES_CYCLING forKey:VEHICLES_SELECTED];
}

-(IBAction)btnWalkingSelected:(id)sender{
    [imgCarSelected setHidden:YES];
    [imgMotoSelected setHidden:YES];
    [imgWalkingSelected setHidden:NO];
    [[NSUserDefaults standardUserDefaults] setValue:VEHICLES_WALKING forKey:VEHICLES_SELECTED];
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
    [routesDirectionsView loadDataTableWithRoutesList:listRoutes];
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

    GMSMarker *currentLocationMarker = [[GMSMarker alloc] init];
    currentLocationMarker.position = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    if (waypoints_.count>0 && waypointStrings_.count>0) {
        [waypoints_ replaceObjectAtIndex:0 withObject:currentLocationMarker];
        NSString *currentPositionString = [[NSString alloc] initWithFormat:@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude];
        [waypointStrings_ replaceObjectAtIndex:0 withObject:currentPositionString];
    }else{
        [waypoints_ addObject:currentLocationMarker];
        NSString *currentPositionString = [[NSString alloc] initWithFormat:@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude];
        [waypointStrings_ addObject:currentPositionString];
    }

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
        NSLog(@"reverse geocoding results: %lu", (unsigned long)[[response results] count] );
        for(GMSAddress* addressObj in [response results])
        {

            if (self.selectMapDelegate && [self.selectMapDelegate respondsToSelector:@selector(selectAddress:)]) {
                [self.selectMapDelegate selectAddress:addressObj];

                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }






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
    NSMutableDictionary *dicJSON =[json objectForKey:@"routes"];
    if (dicJSON.count>0) {
        NSDictionary *routes = [json objectForKey:@"routes"][0];
        NSArray *Legs =[routes objectForKey:@"legs"];
        for (NSDictionary *routeDic in Legs) {
            UICGRoute *routesOB = [UICGRoute routeWithDictionaryRepresentation:routeDic];
            NSLog(@"address : %@",routesOB.endAddress);

            [listRoutes addObject:routesOB];
            [listRoutesDic setObject:routesOB forKey:[NSString stringWithFormat:@"%@%ld",KEY_POLYLINE_KHDM,(long)indexDirectionSelected]];
        }

        NSDictionary *route = [routes objectForKey:@"overview_polyline"];
        NSString *overview_route = [route objectForKey:@"points"];
        GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.map = mapView_;
        // add Polyline Dictionary
        if (customerType==typeKHDM) {
            [polyLineDic_ setObject:polyline forKey:[NSString stringWithFormat:@"%@%ld",KEY_POLYLINE_KHDM,(long)indexDirectionSelected]];
        }else if(customerType==typeKH360){
            [polyLineDic_ setObject:polyline forKey:[NSString stringWithFormat:@"%@%ld",KEY_POLYLINE_KH360,(long)indexDirectionSelected]];
        }
    }
}

- (void)removeDirectionsWithTypeCustomer:(CustomerType)cusType withInxex:(NSInteger)index {
    GMSPolyline *polyline;
    if (cusType==typeKHDM) {

        // remove Polyline dictionary KHDM
        polyline =[polyLineDic_ objectForKey:[NSString stringWithFormat:@"%@%ld",KEY_POLYLINE_KHDM,(long)index]];

        // remove GMSMarker string KHDM
        GMSMarker *marker = [wayPointDic_ objectForKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_KHDM,(long)index]];
        [waypoints_ removeObject:marker];
        [wayPointDic_ removeObjectForKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_KHDM,(long)index]];

        // remove marker string KHDM
        NSString *markerStr = [wayPointStrDic_ objectForKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_STRING_KHDM,(long)index]];
        [waypointStrings_ removeObject:markerStr];
        [wayPointStrDic_ removeObjectForKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_STRING_KHDM,(long)index]];

    }else if(cusType==typeKH360){
        // remove Polyline dictionary kh360
        polyline =[polyLineDic_ objectForKey:[NSString stringWithFormat:@"%@%ld",KEY_POLYLINE_KH360,(long)index]];

        // remove GMSMarker string kh360
        GMSMarker *marker = [wayPointDic_ objectForKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_KH360,(long)index]];
        [waypoints_ removeObject:marker];
        [wayPointDic_ removeObjectForKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_KH360,(long)index]];

        // remove marker string kh360
        NSString *markerStr = [wayPointStrDic_ objectForKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_STRING_KH360,(long)index]];
        [waypointStrings_ removeObject:markerStr];
        [wayPointStrDic_ removeObjectForKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_STRING_KH360,(long)index]];
    }
    if (polyline) {
        polyline.map = nil;
    }
    UICGRoute *routesOB = [listRoutesDic objectForKey:[NSString stringWithFormat:@"%@%ld",KEY_POLYLINE_KHDM,(long)index]];
    [listRoutes removeObject:routesOB];
    [listRoutesDic removeObjectForKey:[NSString stringWithFormat:@"%@%ld",KEY_POLYLINE_KHDM,(long)index]];

}


- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    CustomInfoView *infoView = [[CustomInfoView alloc] initWithFrame:CGRectZero];
    infoView.delegate = self;
    if ([marker.userData isKindOfClass:[DTOAcountLeadProcessObject class]]) {
        DTOAcountLeadProcessObject *customerData= marker.userData;
        [infoView loadViewWithKHDMOB:customerData];
    }else if ([marker.userData isKindOfClass:[DTOAccountProcessObject class]]) {
        DTOAccountProcessObject *customerData= marker.userData;
        [infoView loadViewWithKH360OB:customerData];
    }

    return infoView;
}


/**
 * Called after a marker's info window has been tapped.
 */
- (void)mapView:(GMSMapView *)mapView
didTapInfoWindowOfMarker:(GMSMarker *)marker{
    if ([marker.userData isKindOfClass:[DTOAcountLeadProcessObject class]]) {
        DTOAcountLeadProcessObject *customerData= marker.userData;

        NSDictionary *dicData = [NSDictionary dictionaryWithObjectsAndKeys:customerData.clientLeadId,@"clientLeadId",customerData.leadType,@"leadType",customerData.address,@"address",customerData.name,@"name",customerData.id,@"id",customerData.updatedBy,@"updatedBy",customerData.mobile,@"mobile",customerData.code,@"code",customerData.email,@"email",customerData.leadId,@"leadId", nil];

        DetailLeadViewController *viewController = [[DetailLeadViewController alloc]initWithNibName:@"DetailLeadViewController" bundle:nil];
        viewController.dataSend = dicData;
        [self presentViewController:viewController animated:YES completion:nil];

    }else if ([marker.userData isKindOfClass:[DTOAccountProcessObject class]]) {
        DTOAccountProcessObject *customerData= marker.userData;

        NSDictionary *dicData = [NSDictionary dictionaryWithObjectsAndKeys:customerData.name,@"name",customerData.mobile,@"mobile",customerData.updatedBy,@"updatedBy",customerData.id,@"id",customerData.clientAccountId,@"clientAccountId", nil];

        DetailLeadViewController *viewController = [[DetailLeadViewController alloc]initWithNibName:@"DetailLeadViewController" bundle:nil];

        viewController.dataSend = dicData;
        [self presentViewController:viewController animated:YES completion:nil];
    }

}

#pragma mark tableview delegate
#pragma mark - Table View

//thêm cái line đến tận left margin
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

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
    return 0;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    if (khdmSelected) {
        DTOAcountLeadProcessObject *khdmOB = [_mapModel.listCustomerKHDM objectAtIndex:indexPath.row];

        if (khdmOB.lat && khdmOB.lon) {
            _lan = [khdmOB.lat floatValue];
            _lon = [khdmOB.lon floatValue];
        }
    }else{
        DTOAccountProcessObject *kh360OB = [_mapModel.listCustomerKH360 objectAtIndex:indexPath.row];
        if (kh360OB.lat && kh360OB.lon) {
            _lan = [kh360OB.lat floatValue];
            _lon = [kh360OB.lon floatValue];
        }
    }
    zoomRatio = ZOOM_RATIO*1.3;
    camera = [GMSCameraPosition cameraWithLatitude:_lan
                                         longitude:_lon
                                              zoom:zoomRatio];
    mapView_.camera = camera;

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

                // add GMSMarker KHDM
                GMSMarker *marker = [[GMSMarker alloc] init];
                marker.position = CLLocationCoordinate2DMake([khdmOB.lat floatValue], [khdmOB.lon floatValue]);
                [marker setUserData:khdmOB];
                [waypoints_ addObject:marker];
                [wayPointDic_ setObject:marker forKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_KHDM,(long)indexPath.row]];

                // add marker string KHDM
                NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
                                            [khdmOB.lat floatValue],[khdmOB.lon floatValue]];
                [waypointStrings_ addObject:positionString];
                [wayPointStrDic_ setObject:positionString forKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_STRING_KHDM,(long)indexPath.row]];
                // implement Routes of Directions with Google API

                if([waypoints_ count]>1){
                    [SVProgressHUD show];
                    NSString *sensor = @"false";
                    NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
                                           nil];
                    NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
                    NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                                      forKeys:keys];
                    customerType = typeKHDM;
                    indexDirectionSelected = indexPath.row;
                    [self.view setUserInteractionEnabled:NO];
                    [_mapModel requestDirectionsQuery:query success:^(id result) {
                        [SVProgressHUD dismiss];
                        [self.view setUserInteractionEnabled:YES];
                        if (result) {
                            [self addDirections:result];
                        }

                    } failure:^(NSError *error) {
                        [self.view setUserInteractionEnabled:YES];
                        [SVProgressHUD dismiss];
                        [[[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_FIND_ROUTES_DIRECTION_FAIL delegate:nil cancelButtonTitle:SYS_Notification_OKButton otherButtonTitles: nil] show];
                    }];
                }
            }

        }else{
            // remove Routes of Directions
            [self removeDirectionsWithTypeCustomer:typeKHDM withInxex:indexPath.row];
            [listCustomerDirections removeObject:khdmOB];
        }

    }else{
        DTOAccountProcessObject *kh360OB = [_mapModel.listCustomerKH360 objectAtIndex:indexPath.row];
        if ([status isEqualToString:@"YES"]) {

            [listCustomerDirections addObject:kh360OB];
            if (kh360OB.lat && kh360OB.lon) {

                // add GMSMarker kh360
                GMSMarker *marker = [[GMSMarker alloc] init];
                marker.position = CLLocationCoordinate2DMake([kh360OB.lat floatValue], [kh360OB.lon floatValue]);
                [marker setUserData:kh360OB];
                [waypoints_ addObject:marker];
                [wayPointDic_ setObject:marker forKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_KH360,(long)indexPath.row]];

                // add marker string kh360
                NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
                                            [kh360OB.lat floatValue],[kh360OB.lon floatValue]];
                [waypointStrings_ addObject:positionString];
                [wayPointStrDic_ setObject:positionString forKey:[NSString stringWithFormat:@"%@%ld",KEY_MARKER_STRING_KH360,(long)indexPath.row]];

                // implement Routes of Directions with Google API
                if([waypoints_ count]>1){
                    [SVProgressHUD show];
                    NSString *sensor = @"true";
                    NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
                                           nil];
                    NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
                    NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                                      forKeys:keys];
                    customerType = typeKH360;
                    indexDirectionSelected = indexPath.row;
                    [self.view setUserInteractionEnabled:NO];
                    [_mapModel requestDirectionsQuery:query success:^(id result) {
                        [SVProgressHUD dismiss];
                        [self.view setUserInteractionEnabled:YES];
                        if (result) {
                            [self addDirections:result];
                        }

                    } failure:^(NSError *error) {
                        [self.view setUserInteractionEnabled:YES];
                        [SVProgressHUD dismiss];
                        [[[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_FIND_ROUTES_DIRECTION_FAIL delegate:nil cancelButtonTitle:SYS_Notification_OKButton otherButtonTitles: nil] show];
                    }];
                }
            }
        }else{
            // remove Routes of Directions
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
            [_mapModel getNextPageCustomerKHDMWithKey:searchBarCustomer.text];
            [self updateNextPageKHDMDirectionsFlag];
        }else{
            [_mapModel getNextPageCustomerKH360WithKey:searchBarCustomer.text];
            [self updateNextPageKH360DirectionsFlag];
        }
        [customerTbv reloadData];
    }
}

#pragma mark Search Bar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (khdmSelected) {
        [_mapModel getFirstPageCustomerKHDMWithKey:searchText];
    }else{
        [_mapModel getFirstPageCustomerKH360WithKey:searchText];
    }
    
    [customerTbv reloadData];
}


@end
