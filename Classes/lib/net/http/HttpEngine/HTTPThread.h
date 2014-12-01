//
//  HTTPThread.h
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSThread.h>
#import "SyncQueue.h"
#import "HTTPEngine.h"


@interface HTTPThread : NSObject {
	SyncQueue* syncQueue;
	HTTPEngine* httpEngine;
	BOOL isRunning;
	BOOL bStopRequest;
	int threadID;
	//UIActivityIndicatorView *ai;
}
@property (readwrite, assign, nonatomic) SyncQueue* requestQueue;
//@property (nonatomic, retain) UIActivityIndicatorView *ai;


-(id) initWithHTTPClient:(HTTPClient*) httpClient;
-(void) start;
-(void) stop;
-(void) threadFunction:(id) object;
@end
