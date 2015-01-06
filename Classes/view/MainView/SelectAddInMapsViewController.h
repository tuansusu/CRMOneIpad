//
//  SelectAddInMapsViewController.h
//  OfficeOneMB
//
//  Created by Luong Hoang on 1/6/15.
//
//

#import "BaseViewController.h"

@interface SelectAddInMapsViewController : BaseViewController<UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UISearchBar *txtSearchBar;

@end
