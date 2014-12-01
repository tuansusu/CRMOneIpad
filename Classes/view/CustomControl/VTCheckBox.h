//
//  VTCheckBox.h
//  VTCustomView
//
//  Created by ADMIN on 9/4/14.
//  Copyright (c) 2014 ADMIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTCheckBoxDelegate.h"

@interface VTCheckBox : UIView{
    
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
