#import "UICheckBox.h"

//declear our own delegate


@implementation UICheckBox
@synthesize checked;
@synthesize myDelegate;
@synthesize index;

@synthesize rowIndex,columnIndex;


-(id)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    
    if(self){
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        if (self.typeCheck == TypeCheck_CheckBox) {
            [self setImage:[UIImage imageNamed:Image_CheckBox_UnCheck] forState:UIControlStateNormal];
        } else {
            [self setImage:[UIImage imageNamed:Image_Radio_UnChec] forState:UIControlStateNormal];
        }
        
        [self addTarget:self action:@selector(checkBoxClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
        
}

-(void) initChecked{
    if(self.checked == YES)
    {
       // self.checked = YES;
        
        
        
        if (self.typeCheck == TypeCheck_CheckBox) {
            [self setImage:[UIImage imageNamed:Image_CheckBox_Check] forState:UIControlStateNormal];
        } else {
            [self setImage:[UIImage imageNamed:Image_Radio_Check] forState:UIControlStateNormal];
        }
        
    }
    else{
     
        
        if (self.typeCheck == TypeCheck_CheckBox) {
            [self setImage:[UIImage imageNamed:Image_CheckBox_UnCheck] forState:UIControlStateNormal];
        } else {
            [self setImage:[UIImage imageNamed:Image_Radio_UnChec] forState:UIControlStateNormal];
        }
    }
}

-(IBAction)checkBoxClicked:(id)sender{
    
    if(self.checked == NO)
    {
        self.checked = YES;
        if (self.typeCheck == TypeCheck_CheckBox) {
            [self setImage:[UIImage imageNamed:Image_CheckBox_Check] forState:UIControlStateNormal];
        } else {
            [self setImage:[UIImage imageNamed:Image_Radio_Check] forState:UIControlStateNormal];
        }
        
        
        
        [myDelegate getMessageString:index:sender:rowIndex:columnIndex];
        
        [myDelegate checkBoxClick:sender withIndex:index withTypeCheck:self.typeCheck];
    }
    else{
        self.checked = NO;
        
        if (self.typeCheck == TypeCheck_CheckBox) {
            [self setImage:[UIImage imageNamed:Image_CheckBox_UnCheck] forState:UIControlStateNormal];
        } else {
            [self setImage:[UIImage imageNamed:Image_Radio_UnChec] forState:UIControlStateNormal];
        }
        
        
         //NSLog(@"checkBoxUnChecked");
        [myDelegate getMessageString:index:sender:rowIndex:columnIndex];
        
        [myDelegate checkBoxClick:sender withIndex:index withTypeCheck:self.typeCheck];
    }
    
}

-(void) dealloc{
    //[super dealloc];
}

@end
