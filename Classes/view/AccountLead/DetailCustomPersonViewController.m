//
//  DetailCustomPersonViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/21/14.
//
//

#import "DetailCustomPersonViewController.h"

@interface DetailCustomPersonViewController ()
{
    int smgSelect ; //option layout
    NSUserDefaults *defaults ;
}
@end

@implementation DetailCustomPersonViewController

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
    
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_mobile]]) {
        self.lbPhone.text = [dataSend objectForKey:DTOLEAD_mobile];
    }
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_email]]) {
        self.lbEmail.text = [dataSend objectForKey:DTOLEAD_email];
        self.btnSendMail.hidden = NO;
    }
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_address]]) {
        self.lbAddress.text = [dataSend objectForKey:DTOLEAD_address];
        self.btnGoToAddressMap.hidden = NO;
    }
    
    
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_birthday]]) {
        self.lbDateOfBirth.text = [dataSend objectForKey:DTOLEAD_birthday];
    }
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_identifiedNumber]]) {
        self.lbIdentityNumber.text = [dataSend objectForKey:DTOLEAD_identifiedNumber];
    }
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_sex]]) {
        self.lbSex.text = [dataSend objectForKey:DTOLEAD_sex];
    }
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_marialStatus]]) {
        NSString *strMarialStatus = ObjectToStr([dataSend objectForKey:DTOLEAD_mobile]) ;
        if ([strMarialStatus isEqualToString:@"0"]) {
            self.lbMarialStatus.text = @"Chưa kết hôn";
        } else if ([strMarialStatus isEqualToString:@"1"]) {
            self.lbMarialStatus.text = @"Đã kết hôn";
        }else{
            self.lbMarialStatus.text = @"";
        }
    }
    if (![StringUtil stringIsEmpty:[dataSend objectForKey:DTOLEAD_monthlyIncome]]) {
        self.lbMonthlyIncome.text = [NSString stringWithFormat:@"%@ VND", [dataSend objectForKey:DTOLEAD_monthlyIncome]];
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

- (IBAction)actionSendMail:(id)sender {
}
- (IBAction)actionGoToMap:(id)sender {
}
@end
