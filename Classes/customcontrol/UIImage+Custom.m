//
//  UIImage+Custom.m
//  Voffice2.1
//
//  Created by VTIT on 2/24/14.
//
//

#import "UIImage+Custom.h"

@implementation UIImage (Custom)

+ (UIImage *)imageWithOverlayColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
