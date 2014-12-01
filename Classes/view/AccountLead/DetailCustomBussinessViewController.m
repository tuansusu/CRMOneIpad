//
//  DetailCustomBussinessViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/22/14.
//
//

#import "DetailCustomBussinessViewController.h"

@interface DetailCustomBussinessViewController ()
{
    int smgSelect ; //option layout
    NSUserDefaults *defaults ;
}
@end

@implementation DetailCustomBussinessViewController

@synthesize dataSend;

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
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
}
//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    if (!self.dataSend) {
        return;
    }
    
    
    
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_charter]]) {
        _lbCharter.text = [dataSend objectForKey:DTOLEAD_charter];
        
    }
    
    
        _lbDateOfEstablishment.text =@"";
        
    
    
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_fax]]) {
        _lbFax.text = [dataSend objectForKey:DTOLEAD_fax];
    }
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_employeeNumber]]) {
        _lbNumberEmployee.text = [dataSend objectForKey:DTOLEAD_employeeNumber];
    }
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_profitNonTax]]) {
        _lbProfitNoTax.text = [dataSend objectForKey:DTOLEAD_profitNonTax];
    }
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_registrationNumber]]) {
        _lbRegisterNumber.text = [dataSend objectForKey:DTOLEAD_registrationNumber];
    }
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_revenue]]) {
        _lbRevenue.text = [dataSend objectForKey:DTOLEAD_revenue];
    }
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_assetTotal]]) {
        _lbTotalAsset.text = [dataSend objectForKey:DTOLEAD_assetTotal];
    }
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_assetTotal]]) {
        _lbTypeOfCompany.text = [dataSend objectForKey:DTOLEAD_assetTotal];
    }
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_website]]) {
        _lbWebsite.text = [dataSend objectForKey:DTOLEAD_website];
    }
    NSString *strNoContact = @"";
    
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_disableEmail]]) {
        if ([ObjectToStr([dataSend objectForKey:DTOLEAD_disableEmail]) isEqualToString:@"1"]) {
            [strNoContact stringByAppendingString:@"Email"];
        }
    }
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_disableMeeting]]) {
        if ([ObjectToStr([dataSend objectForKey:DTOLEAD_disableMeeting]) isEqualToString:@"1"]) {
            
            if ([strNoContact isEqualToString:@""]) {
                [strNoContact stringByAppendingString:@"Gặp mặt"];
            }else{
                [strNoContact stringByAppendingString:@", Gặp mặt"];
            }
            
            
        }
    }
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_disablePhone]]) {
        if ([ObjectToStr([dataSend objectForKey:DTOLEAD_disablePhone]) isEqualToString:@"1"]) {
            
            if ([strNoContact isEqualToString:@""]) {
                [strNoContact stringByAppendingString:@"Điện thoại"];
            }else{
                [strNoContact stringByAppendingString:@", Điện thoại"];
            }
            
            
        }
    }
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_disableSms]]) {
        if ([ObjectToStr([dataSend objectForKey:DTOLEAD_disableSms]) isEqualToString:@"1"]) {
            
            if ([strNoContact isEqualToString:@""]) {
                [strNoContact stringByAppendingString:@"SMS"];
            }else{
                [strNoContact stringByAppendingString:@", SMS"];
            }
            
            
        }
    }
    
    self.lbNoContact.text = strNoContact;
    
}

- (void) updateInterFaceWithOption : (int) option
{
    
    for (UIView *viewSubTemp in self.view.subviews) {
        
        if ([viewSubTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
