//
//  SearchAdvanceLeadViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/7/14.
//
//

#import "SearchAdvanceLeadViewController.h"
#import "Util.h"

@interface SearchAdvanceLeadViewController ()
{
    ///control
    __weak IBOutlet UITextField *txtCode;
    
    __weak IBOutlet UITextField *txtName;
    
    __weak IBOutlet UITextField *txtMobile;
    
    __weak IBOutlet UITextField *txtEmail;
    
    __weak IBOutlet UITextField *txtMSThue;
    
    __weak IBOutlet UITextField *txtCMT;
    
    __weak IBOutlet UITextField *txtSDKKD;
    
    //khai báo biến
    int smgSelect ; //option layout
    NSUserDefaults *defaults ;
    Language *obj;
    Util *util;
    
}
@end

@implementation SearchAdvanceLeadViewController

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
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    obj=[Language getInstance];
    obj.str=[defaults objectForKey:@"Language"];
    LocalizationSetLanguage(obj.str);
    [self setLanguage];
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    util=[Util new];
}


- (void) updateInterFaceWithOption : (int) option
{
    
    
    
        
        for (UIView *viewSubTemp in self.view.subviews) {
            
            
            if ([viewSubTemp isKindOfClass:[UILabel class]]) {
                ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
            }
            
            
            if ([viewSubTemp isKindOfClass:[UITextView class]]) {
                ((UITextView*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextView*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextView*) viewSubTemp).layer.borderWidth = BORDER_WITH;
            }
            if ([viewSubTemp isKindOfClass:[UITextField class]]) {
                ((UITextField*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextField*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
//                ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
//                ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
                [((UITextField*) viewSubTemp) setPaddingLeft];
                [((UITextField*) viewSubTemp) setBorderWithOption:smgSelect];
            }
            
            if ([viewSubTemp isKindOfClass:[UIButton class]]) {
                
                [((UIButton*) viewSubTemp) setStyleNormalWithOption:smgSelect];
            }
            
        }
        
    
        
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionSearch:(id)sender {
    
    if (self.advanceSearchDelegate && [self.advanceSearchDelegate respondsToSelector:@selector(actionSearchAdvanceWithCode:withName:withMobile:withEmail:withmsthue:withCMT:withDKKD:)]) {
        [self.advanceSearchDelegate actionSearchAdvanceWithCode:txtCode.text withName:txtName.text withMobile:txtMobile.text withEmail:txtEmail.text withmsthue:txtMSThue.text withCMT:txtCMT.text withDKKD:txtSDKKD.text];
    }
    
}

- (IBAction)actionCancel:(id)sender {
    if (self.advanceSearchDelegate && [self.advanceSearchDelegate respondsToSelector:@selector(dismissPopoverView)]) {
        [self.advanceSearchDelegate dismissPopoverView];
    }
}
-(void)setLanguage{
    [_btnSearch setTitle:LocalizedString(@"KEY_SEARCH") forState:UIControlStateNormal];
    [_btnCancel setTitle:LocalizedString(@"KEY_CANCEL") forState:UIControlStateNormal];
    _lbmakh.text=LocalizedString(@"KEY_SEARCH_CODE");
    _lbsdt.text=LocalizedString(@"KEY_SEARCH_PHONE");
    _lbtenkh.text=LocalizedString(@"KEY_SEARCH_NAME");
    _lbmsthue.text=LocalizedString(@"KEY_SEARCH_THUE");
    _lbsocmt.text=LocalizedString(@"KEY_SEARCH_CMT");
    _lbsodk.text=LocalizedString(@"KEY_SEARCH_DKKD");
    txtCMT.placeholder=LocalizedString(@"KEY_SEARCH_CMT");
    txtCode.placeholder=LocalizedString(@"KEY_SEARCH_CODE");
    txtEmail.placeholder=@"Email";
    txtMobile.placeholder=LocalizedString(@"KEY_SEARCH_PHONE");
    txtMSThue.text=LocalizedString(@"KEY_SEARCH_THUE");
    txtName.placeholder=LocalizedString(@"KEY_SEARCH_NAME");
    txtSDKKD.placeholder=LocalizedString(@"KEY_SEARCH_DKKD");
}
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==txtName) {
        BOOL result = [util CharacterNoEnter:textField.text];
        if (result) {
            return NO;
        }else{
            return  YES;
        }
    }
    
}
@end
