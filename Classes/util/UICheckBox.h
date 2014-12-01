#import <Foundation/Foundation.h>

#define Image_CheckBox_Check @"checkbox_ticked.png"
#define Image_CheckBox_UnCheck @"checkbox_not_ticked.png"

#define Image_Radio_Check @"checkbox_ticked.png"
#define Image_Radio_UnChec @"checkbox_not_ticked.png"

//#define Image_Radio_Check @"icon_radio-button_on.png"
//#define Image_Radio_UnChec @"icon_radio-button_off.png"

enum TypeCheck{
    TypeCheck_CheckBox,
    typeCheck_Radio
};

@protocol MyDelegate <NSObject>

@optional
-(NSString *) getMessageString : (NSInteger) index :(id) sender : (NSInteger) rowIndex : (NSInteger) columnIndex;

-(void) checkBoxClick : (id) sender withIndex : (NSInteger) index withTypeCheck : (enum TypeCheck) typeCheck;


@end

@interface UICheckBox : UIButton {
    
    BOOL checked;
}
@property (nonatomic, retain) id <MyDelegate> myDelegate;
@property (nonatomic, assign) BOOL checked;

@property (nonatomic) NSInteger index;

@property (nonatomic) NSInteger rowIndex;
@property (nonatomic) NSInteger columnIndex;

@property (nonatomic) enum TypeCheck typeCheck;

-(IBAction)checkBoxClicked:(id)sender;

-(void) initChecked;


@end
