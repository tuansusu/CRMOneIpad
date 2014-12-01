//
//  TestMapViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/29/14.
//
//

#import "TestMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface TestMapViewController ()
{
    NSUserDefaults *defaults;
    int smgSelect ; //option layout
    
    GMSMapView *mapView_;
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
    
    
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
        
    }
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
//                                                            longitude:151.20
//                                                                 zoom:6];
    
    NSLog(@"_lan = %f : _lon = %f", _lan, _lon);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_lan
                                                            longitude:_lon
                                                                 zoom:15];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    
    self.view = mapView_;
    //[self.mainView addSubview:mapView_];
    
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
    

    
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(20, 6, 32, 32)];

    
    [btnBack setImage:[UIImage imageNamed:@"icon_menu-1.png"] forState:UIControlStateNormal];
    
    [btnBack addTarget:self action:@selector(homeBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [mapView_ addSubview:btnBack];
    

    
}

//Home button
- (IBAction)homeBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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



@end
