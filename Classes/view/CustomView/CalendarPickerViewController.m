//
//  CalendarPickerViewController.m
//  Voffice2.1
//
//  Created by Tran Van Bang on 8/23/13.
//
//

#import "CalendarPickerViewController.h"

@interface CalendarPickerViewController ()

@end

@implementation CalendarPickerViewController
@synthesize datePicker;
@synthesize delegateDatePicker;
@synthesize dateSelected;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isTimeMode = false;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
    if(self.isTimeMode)
    {
        datePicker.datePickerMode = UIDatePickerModeTime;
        
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
        [self.datePicker setLocale:locale];
    }
    else
    {
        datePicker.datePickerMode = UIDatePickerModeDate;
    }
	datePicker.hidden = NO;
	//
    if (dateSelected) {
        datePicker.date = dateSelected;
    }
    else
    {
        datePicker.date = [NSDate date];
    }
	[datePicker addTarget:self
	               action:@selector(labelChange)
	     forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    // Do any additional setup after loading the view from its nib.
    
//    self.toolBar.backgroundColor = HEADER_VIEW_COLOR1;
//    self.toolBar.barStyle = UIBarStyleBlackTranslucent;
//    self.toolBar.tintColor =HEADER_VIEW_COLOR1;
    
    //self.btnChoice.tintColor = TEXT_BUTTON_COLOR1;
    [self.btnChoice setStyleNormalWithOption:1];
    [self.toolBar setBackgroundColor:HEADER_VIEW_COLOR1];
    
}




- (void) labelChange
{
    
    [delegateDatePicker selectDatePickerWithDate:datePicker.date];
}

-(IBAction)dismissView:(id)sender
{
    [delegateDatePicker selectDatePickerWithDate:datePicker.date];
    [delegateDatePicker dismissPopoverView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidUnload {
    self.toolBar = nil;
    dateSelected = nil;
    datePicker = nil;
    [super viewDidUnload];
}


@end
