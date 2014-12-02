//
//  CalendarPickerViewController.h
//  Voffice2.1
//
//  Created by Tran Van Bang on 8/23/13.
//
//

#import <UIKit/UIKit.h>


@protocol CalendarSelectDatePickerDelegate <NSObject>
@optional
-(void) selectDatePickerWithDate : (NSDate *) date;
-(void) dismissPopoverView;
@end

@interface CalendarPickerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *toolBar;

//@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
//

@property(nonatomic,retain) IBOutlet UIDatePicker *datePicker;
@property (weak,nonatomic) id <CalendarSelectDatePickerDelegate> delegateDatePicker;
@property (nonatomic, retain) NSDate *dateSelected;
@property (nonatomic) bool isTimeMode;
-(IBAction)dismissView:(id)sender;

//@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnChoice;

@property (weak, nonatomic) IBOutlet UIButton *btnChoice;


@end
