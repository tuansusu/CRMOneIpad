//
//  ProfileViewController.h
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblCodeOfficerTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblCodeOfficerDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblCodeTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCodeDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblFullnameTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFullnameDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblSexTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSexDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthdayTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthdayDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblEnterOrgDateTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblEnterOrgDateDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblBranchTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblBranchDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblDepartmentTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDepartmentDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblPositionTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPositionDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblDayStartPositionTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDayStartPositionDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblMobileTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMobileDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneOrgTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneOrgDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneRetailTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneRetailDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblFaxTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFaxDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblAddressTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAddressDetail;

@property (weak, nonatomic) IBOutlet UILabel *fullnameLB;
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UIView *detailViewBar;

@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UILabel *barLabel;

@end
