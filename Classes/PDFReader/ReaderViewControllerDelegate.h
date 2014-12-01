//
//  ReaderViewControllerDelegate.h
//  Voffice2.1
//
//  Created by VTIT on 3/4/14.
//
//

#import <Foundation/Foundation.h>
//#import "ReaderViewController.h"


@protocol ReaderViewControllerDelegate <NSObject>

@optional // Delegate protocols

- (void)dismissReaderViewController:(UIViewController *)viewController;
- (void)dismissBackReaderViewController:(UIViewController *)viewController;
- (void) dismissWhenSuccess;

@end

