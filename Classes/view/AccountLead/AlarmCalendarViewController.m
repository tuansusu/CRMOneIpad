//
//  AlarmCalendarViewController.m
//  OfficeOneMB
//
//  Created by Duy Pham on 4/1/15.
//
//

#import "AlarmCalendarViewController.h"
#import "VTRadio.h"

@interface AlarmCalendarViewController ()
<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

- (IBAction)onOffSwitchChanged:(UISegmentedControl *)sender;

- (IBAction)pickerBtnPressed:(UIButton *)sender;

- (IBAction)confirmBtnPressed:(id)sender;
- (IBAction)cancelBtnPressed:(id)sender;
@end

typedef enum {
    pickerType_day,
    pickerType_hour,
    pickerType_minute
} pickerType_t;

@implementation AlarmCalendarViewController
{
    __weak IBOutlet UISegmentedControl *_onOffSwitch;
    
    __weak IBOutlet UITextField * _dayTF;
    __weak IBOutlet UIButton    * _dayDDBtn;
    __weak IBOutlet UITextField * _hourTF;
    __weak IBOutlet UIButton    * _hourDDBtn;
    __weak IBOutlet UITextField * _minuteTF;
    __weak IBOutlet UIButton    * _minuteDDBtn;
    
    __weak IBOutlet UISwitch *_emailSwitch;
    __weak IBOutlet UISwitch *_smsSwitch;
    __weak IBOutlet UISwitch *_notifSwitch;
    
    __weak IBOutlet UIPickerView *_pickerView;
    pickerType_t pickerType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dayTF.delegate    = self;
    _hourTF.delegate   = self;
    _minuteTF.delegate = self;
    
    _pickerView.delegate   = self;
    _pickerView.dataSource = self;
    pickerType = pickerType_day;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onOffSwitchChanged:(UISegmentedControl *)sender
{
    if (sender == _onOffSwitch)
    {
        [self setConfigEnable:([sender selectedSegmentIndex] == 1)];
    }
    else
    {
        return;
    }
}

- (IBAction)pickerBtnPressed:(UIButton *)sender
{
    _pickerView.hidden = TRUE;
    if (sender == _dayDDBtn)
    {
        pickerType = pickerType_day;

    }
    else if (sender == _hourDDBtn)
    {
        pickerType = pickerType_hour;

    }
    else if (sender == _minuteDDBtn)
    {
        pickerType = pickerType_minute;

    }
    else
    {
        return;
    }
    
    [_pickerView reloadAllComponents];
    _pickerView.hidden = FALSE;
}

- (IBAction)confirmBtnPressed:(id)sender
{
}

- (IBAction)cancelBtnPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
       //??
    }];
}


#pragma mark -
- (void)setConfigEnable:(BOOL)configEnable
{
    [_onOffSwitch setSelectedSegmentIndex:configEnable?1:0];
    
    _dayTF.enabled       = configEnable;
    _dayDDBtn.enabled    = configEnable;
    _hourTF.enabled      = configEnable;
    _hourDDBtn.enabled   = configEnable;
    _minuteTF.enabled    = configEnable;
    _minuteDDBtn.enabled = configEnable;

    _emailSwitch.enabled = configEnable;
    _smsSwitch.enabled   = configEnable;
    _notifSwitch.enabled = configEnable;
}

#pragma mark - UIPickerView data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        if (pickerType == pickerType_day)
        {
            return 32;
        }
        else if (pickerType == pickerType_hour)
        {
            return 24;
        }
        else if (pickerType == pickerType_minute)
        {
            return 60;
        }
    }
    
    return 0;
}

#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (component == 0)
    {
        return [NSString stringWithFormat:@"%ld", (long)row];
    }
    
    return @"N/A";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerType == pickerType_day)
    {
        _dayTF.text = [NSString stringWithFormat:@"%ld", (long)row];
    }
    else if (pickerType == pickerType_hour)
    {
        _hourTF.text = [NSString stringWithFormat:@"%ld", (long)row];
    }
    else if (pickerType == pickerType_minute)
    {
        _minuteTF.text = [NSString stringWithFormat:@"%ld", (long)row];
    }
//    _pickerView.hidden = TRUE;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _dayTF)
    {
        [_dayDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _hourTF)
    {
        /* show status picker */
        [_hourDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _minuteTF)
    {
        /* show date from picker */
        [_minuteDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        
    }
    
    return FALSE;
}
@end