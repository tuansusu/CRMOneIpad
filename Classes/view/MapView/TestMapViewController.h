//
//  TestMapViewController.h
//  OfficeOneMB
//
//  Created by ADMIN on 11/29/14.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <MessageUI/MessageUI.h>

#import "CustomerViewCell.h"
#import "CustomInfoView.h"
#import "MapsModel.h"
#import "DTOAccountProcessObject.h"
#import "DTOAcountLeadProcessObject.h"
#import "SVProgressHUD.h"

#import "UICGRoute.h"
#import "Globals.h"
#import "Reachability.h"
#import "DirectionsHeaderView.h"
#import "DirectionsViewCell.h"

#import "RoutesDirectionsView.h"
#import "DetailLeadViewController.h"


enum TypeMapView{
    typeMapView_Choice, //Chọn địa điểm(form chi tiết)
    typeMapView_View, //Xem địa chỉ, chỉ dẫn đường(form danh sách)
    typeMapView_Manager //Quản lý bản đồ (quản lý bản đồ)
};

@protocol SelectMapDelegate <NSObject>
@optional
-(void) selectAddress: (GMSAddress*) gmsAddress;
@end



@interface TestMapViewController : UIViewController<CLLocationManagerDelegate>
{
    //CLLocationManager *locationManager;
}


@property (weak,nonatomic) id <SelectMapDelegate> selectMapDelegate;
@property (nonatomic) enum TypeMapView typeMapView;

@property (nonatomic)  float lan;
@property (nonatomic)  float lon;
@property (nonatomic, strong)  NSString* address;


//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgHomeMenu;

@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

///view add

@property (weak, nonatomic) IBOutlet UIView *viewMap1;
@property (weak, nonatomic) IBOutlet UIView *viewMap2;
@property (weak, nonatomic) IBOutlet UIView *viewMap3;


@end
