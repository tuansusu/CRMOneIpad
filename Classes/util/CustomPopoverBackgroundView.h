//
//  CustomPopoverBackgroundView.h
//  Voffice2.1
//
//  Created by VTIT on 2/8/14.
//
//

#import <UIKit/UIKit.h>

@interface CustomPopoverBackgroundView : UIPopoverBackgroundView
{
    UIImageView *_borderImageView;
    UIImageView *_arrowView;
    CGFloat _arrowOffset;
    UIPopoverArrowDirection _arrowDirection;
}



@end
