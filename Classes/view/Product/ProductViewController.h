//
//  ProductViewController.h
//  OfficeOneStudy
//
//  Created by viettel on 11/12/14.
//
//

#import "BaseViewController.h"
#import "ProductCell.h"

@interface ProductViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>


//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;

@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *leftInMainView;

@property (weak, nonatomic) IBOutlet UIView *leftViewHeader;

@property (weak, nonatomic) IBOutlet UILabel *leftLabelHeader;


@property (weak, nonatomic) IBOutlet UIView *rightInMainView;
@property (weak, nonatomic) IBOutlet UIView *rightViewHeader;


@property (weak, nonatomic) IBOutlet UITableView *tbData;

@end
