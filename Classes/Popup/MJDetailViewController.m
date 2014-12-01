//
//  MJDetailViewController.m
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "MJDetailViewController.h"

@implementation MJDetailViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        return YES;
    }
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        return YES;
    }
    
    else
        return NO;
    
}

@end
