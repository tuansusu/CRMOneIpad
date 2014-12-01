//
//  NetworkHelper.m
//
//  Created by viettel on 7/10/14.
//  Copyright (c) 2014 ChuongPD. All rights reserved.
//

#import "Network.h"

@implementation NetworkHelper

static NetworkHelper *sharedManager = nil;

- (id)init
{
    self = [super init];
    if (self) {
        [self checkNetwork];
    }
    return  self;
}

+ (instancetype)sharedManager {
    @synchronized(self)
    {
        if (sharedManager && [sharedManager isKindOfClass:[self class]]){
            return sharedManager;
        }else{
            sharedManager = [[self alloc] init];
            
            return sharedManager;
        }
    }
}

#pragma Network listener

- (void)checkNetwork
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifierNetworkConnection:) name:kReachabilityChangedNotification object:nil];
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    [self notifierNetworkConnection:nil];
}

- (void)notifierNetworkConnection:(NSNotification*) notification
{
    NetworkStatus status = [self.reachability currentReachabilityStatus];
    switch (status) {
        case ReachableViaWiFi:
            _NETWORK_AVAIABLE = YES;
            break;
        case ReachableViaWWAN:
            _NETWORK_AVAIABLE = YES;
            break;
        default:
            _NETWORK_AVAIABLE = NO;
            break;
    }
}

- (BOOL)isNetworkAvaiable
{
    return _NETWORK_AVAIABLE;
}

@end
