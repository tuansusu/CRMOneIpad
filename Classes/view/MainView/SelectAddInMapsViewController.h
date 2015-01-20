//
//  SelectAddInMapsViewController.h
//  OfficeOneMB
//
//  Created by Luong Hoang on 1/6/15.
//
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SelectAddInMapsViewController : BaseViewController<UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UISearchBar *txtSearchBar;
@property (weak, nonatomic) IBOutlet MKMapView *mkMapview;

@end
   