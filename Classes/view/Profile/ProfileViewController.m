//
//  ProfileViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import "ProfileViewController.h"
#import "DTOEMPLOYEEProcess.h"

@interface ProfileViewController ()
{
    DTOEMPLOYEEProcess *dtoEmployeeProcess;
    NSDictionary *employee;
    
     int smgSelect ; //option layout
     NSUserDefaults *defaults ;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

   
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];

    
    [self initData];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initData {
    
    dtoEmployeeProcess = [DTOEMPLOYEEProcess new];
    
    
    
    employee = [dtoEmployeeProcess getEmployeeByUsername:@"crm_admin"];
}

-(void)loadData{
    _lblCodeOfficerDetail.text = [employee objectForKey:@"aoCode"];
    _lblCodeDetail.text = [employee objectForKey:@"hrisCode"];
    _lblAccountDetail.text = [employee objectForKey:@"userLogin"];
    _lblFullnameDetail.text = [employee objectForKey:@"fullName"];
    _lblSexDetail.text = [employee objectForKey:@"sex"];
    _lblBirthdayDetail.text = [[employee objectForKey:@"birthday"] substringToIndex:10];
    _lblEnterOrgDateDetail.text = [[employee objectForKey:@"enterOrgDate"] substringToIndex:10];
    _lblBranchDetail.text = [employee objectForKey:@"branch"];
    _lblDepartmentDetail.text = [employee objectForKey:@"department"];
    _lblTitleDetail.text = [employee objectForKey:@"title"];
    _lblPositionDetail.text =[employee objectForKey:@"position"];
    _lblDayStartPositionDetail.text = [[employee objectForKey:@"dayStartPosition"] substringToIndex:10];
    _lblMobileDetail.text = [employee objectForKey:@"mobile"];
    _lblPhoneOrgDetail.text = [employee objectForKey:@"phoneOrg"];
    _lblPhoneRetailDetail.text = [employee objectForKey:@"phoneRetail"];
    _lblFaxDetail.text = [employee objectForKey:@"fax"];
    _lblAddressDetail.text = [employee objectForKey:@"address"];
}

- (void) updateInterFaceWithOption : (int) option
{
    self.fullnameLB.text = @"THÔNG TIN CÁ NHÂN"; //TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullnameLB.textColor = TEXT_COLOR_HEADER_APP;
    for (UIView *viewTemp in self.detailViewBar.subviews) {
        if ([viewTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
        
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            ((UIButton*) viewTemp).backgroundColor = BUTTON_IN_ACTIVE_COLOR_1;
            [((UIButton*) viewTemp) setTitleColor:TEXT_BUTTON_COLOR1 forState:UIControlStateNormal];
        }
        if ([viewTemp isKindOfClass:[UITextView class]]) {
            ((UITextView*) viewTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextView*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextView*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextView*) viewTemp).layer.borderWidth = BORDER_WITH;
        }
        if ([viewTemp isKindOfClass:[UITextField class]]) {
            ((UITextField*) viewTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextField*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextField*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextField*) viewTemp).layer.borderWidth = BORDER_WITH;
        }
        if ([viewTemp isKindOfClass:[UIImageView class]]) {
            
            [((UIImageView*) viewTemp) setAlpha:1.0f];
        }
        
    }

    
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction) homeBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
