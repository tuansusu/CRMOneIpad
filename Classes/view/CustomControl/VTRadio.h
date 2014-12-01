//
//  VTRadio.h
//  OfficeOneStudy
//
//  Created by viettel on 11/1/14.
//
//

#import <UIKit/UIKit.h>
#import "VTCheckBoxDelegate.h"

@interface VTRadio : UIView{
   BOOL checked;
    __weak IBOutlet UIButton *btnCheckBox;
}

@property (nonatomic, retain) id <VTCheckBoxDelegate> delegate;
@property (nonatomic) NSInteger index;
@property (nonatomic) NSInteger rowIndex;
@property (nonatomic) NSInteger columnIndex;


-(void) setCheck: (BOOL) inputCheck;
-(BOOL) getCheck;

@end
