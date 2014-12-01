//
//  WeekPickerViewController.h
//  Voffice2.1
//
//  Created by VTIT on 12/30/13.
//
//

#import <UIKit/UIKit.h>


@protocol WeekPickerDelegate <NSObject>
@optional
-(void) selectWeekPickerWithWeek : (int) inputWeek withYear : (int) inputYear  withTextSelected :(NSString*) inputTextSelected ;
-(void) dismissPopoverView;

@end

@interface WeekPickerViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>


@property (weak, nonatomic) IBOutlet UIPickerView *picker;


@property (nonatomic) NSInteger year;

@property (nonatomic) NSInteger weekIndex;

@property (weak,nonatomic) id <WeekPickerDelegate> delegatePicker;


- (IBAction)dismissView:(id)sender;



@end
