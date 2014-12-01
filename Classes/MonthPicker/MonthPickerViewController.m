//
//  MonthPickerViewController.m
//  Voffice2.1
//
//  Created by Tran Van Bang on 10/31/13.
//
//

#import "MonthPickerViewController.h"

@interface MonthPickerViewController ()

@end

@implementation MonthPickerViewController

//@synthesize monthPicker;
@synthesize dateSend;
@synthesize delegateMonthPicker;
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
    self.monthPicker.monthPickerDelegate = self;
        
    // Some options to play around with
    self.monthPicker.maximumYear = @2100;
    self.monthPicker.minimumYear = @2000;
   // self.monthPicker.yearFirst = YES;
    if (dateSend) {
        self.monthPicker.date = dateSend;
    }
    else
    {
        self.monthPicker.date = [NSDate date];
    }
   
    // Do any additional setup after loading the view from its nib.
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
  int  smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
}


-(void) updateInterFaceWithOption : (int) option{
    switch (option) {
        case 1:
        {

            [self.btnToolbar setBackgroundColor:HEADER_VIEW_COLOR1];
            [self.btnChoice setStyleNormalWithOption:1];
            
        }
            break;
            
        default:
            break;
    }
}


- (void)monthPickerDidChangeDate:(SRMonthPicker *)monthPicker
{
    [delegateMonthPicker selectMonthPickerWithDate:monthPicker.date];
    
}

- (void) labelChange
{
    
}

-(IBAction)dismissView:(id)sender
{
    [delegateMonthPicker dismissMonthPopoverView];
}

//- (NSString*)formatDate:(NSDate *)date
//{
//    // A convenience method that formats the date in Month-Year format
//    
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"MMMM y";
//    return [formatter stringFromDate:date];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
