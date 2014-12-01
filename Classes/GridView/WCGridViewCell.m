//
//  WCGridViewCell.m
//  StandingHere
//
//  Created by Wess Cope on 5/3/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import "WCGridViewCell.h"
#import "UIView+AUISelectiveBorder.h"

@interface WCGridViewCell()
{
    NSInteger indexTap;
}
@end

@implementation WCGridViewCell
@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize fileNameArr,filePathArr;
@synthesize tableListFileDoc;
@synthesize lbSigner,lbTime,lbTitle;
@synthesize delegateGridCell;
@synthesize dataSend;


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self init];
    if(self)
    {
        _reuseIdentifier = reuseIdentifier;
        
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   // _titleLabel.frame = CGRectInset(self.bounds, 10.0f, 10.0f);
}


- (IBAction)actionTapToCell:(id)sender {
    
    [delegateGridCell tapToCell:dataSend atCell:self];
}

- (IBAction)action_infor:(id)sender {
    
    [delegateGridCell showMoreInfor:dataSend atCell:self];
}


@end
