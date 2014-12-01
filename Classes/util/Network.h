//
//  NetworkHelper
//
//  Created by viettel on 7/10/14.
//  Copyright (c) 2014 ChuongPD. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetworkHelper: NSObject
    @property (nonatomic, strong) Reachability *reachability;
    @property (readonly, nonatomic) BOOL NETWORK_AVAIABLE;

- (BOOL)isNetworkAvaiable;
+ (instancetype)sharedManager;
@end
