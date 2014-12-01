//
//  MonthPickerViewController.h
//  Voffice2.1
//
//  Created by Tran Van Bang on 10/31/13.
//
//

#import <UIKit/UIKit.h>
#import "SRMonthPicker.h"

@protocol MonthPickerDelegate <NSObject>
@optional
-(void) selectMonthPickerWithDate : (NSDate *) date;
-(void) dismissMonthPopoverView;

@end

@interface MonthPickerViewController : UIViewController <SRMonthPickerDelegate>

@property (weak, nonatomic) IBOutlet SRMonthPicker *monthPicker;
@property (strong, nonatomic) NSDate *dateSend;
@property (weak,nonatomic) id <MonthPickerDelegate> delegateMonthPicker;
//@property (assign, nonatomic) NSInteger month;
//@property (assign, nonatomic) NSInteger year;

-(IBAction)dismissView:(id)sender;

//@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnChoice;
//
//@property (weak, nonatomic) IBOutlet UIToolbar *btnToolbar;

@property (weak, nonatomic) IBOutlet UIButton *btnChoice;
@property (weak, nonatomic) IBOutlet UIView *btnToolbar;



@end
