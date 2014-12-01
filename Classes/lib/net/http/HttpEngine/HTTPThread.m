//
//  HTTPThread.m
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import "HTTPThread.h"
#import "HTTPRequest.h"
#import "HTTPResponse.h"
#import "NetworkUtils.h"
#import "Constants.h"
#import "FrameworkAppDelegate.h"
#import "NetworkEngine.h"
#import "NSMutableDictionary-(KunKun).h"

static int nextThreadID = 0;

@implementation HTTPThread

@synthesize requestQueue = syncQueue;

-(id) initWithHTTPClient:(HTTPClient*) httpClient {
	if (self = [super init])
	{
        //NSLog(@"nextThreadID %d", nextThreadID);
		threadID = nextThreadID++;
		syncQueue = nil;
		isRunning = NO;
		bStopRequest = NO;
		httpEngine = [[HTTPEngine alloc] initWithHTTPClient:httpClient];
	}
	return self;
}

-(id) init
{
    self = [super init];
	[self initWithHTTPClient:nil];
	return self;
}

-(void) dealloc
{
	[self stop];
	[httpEngine release];
	[super dealloc];
}

-(void) start
{
	if (isRunning == YES) {
		return;
	}
	bStopRequest = NO;
    ///////////////'
    //NSLog(@"HTTPThread/start/");
	[NSThread detachNewThreadSelector:@selector(threadFunction:) toTarget:self withObject:nil];
}

-(void) stop
{
	if (isRunning == NO) {
		return;
	}
	bStopRequest = YES;
	while (isRunning == YES) {
		usleep(200);
	}
}

-(void) threadFunction:(id) object
{
    ///////////////'
    //NSLog(@"HTTPThread/threadFunction/");
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	isRunning = YES;
	while (bStopRequest == NO) {
		@try {
			HTTPRequest* httpRequest = (HTTPRequest*)[syncQueue pop];
			if (httpRequest != nil) {
				HTTPResponse* pResponse = [httpEngine request:httpRequest];
				if(httpRequest.observer != nil) {
					if (pResponse != nil) {
						if(pResponse.resCode != 200)
						{
							NSArray *arguments = [[NSArray alloc] initWithObjects: httpRequest, pResponse, NSLocalizedString(@"TEXT_NO_CONNECT_INTERNET", nil), nil];
							[self performSelectorOnMainThread:@selector(handleReceiveError:) withObject:arguments waitUntilDone:NO];
							[arguments release];
						} else {
							NSMutableArray *arguments =  [[NSMutableArray alloc] initWithObjects: httpRequest, pResponse, nil];
							[self performSelectorOnMainThread:@selector(handleReceiveData:) withObject:arguments waitUntilDone:NO];
							[arguments release];
						}
					}
					else {
						NSArray *arguments = [[NSArray alloc] initWithObjects: httpRequest, pResponse, NSLocalizedString(@"TEXT_NO_CONNECT_INTERNET", nil), nil];
						[self performSelectorOnMainThread:@selector(handleReceiveError:) withObject:arguments waitUntilDone:NO];
						[arguments release];
					}
				}
				[httpRequest release];
				httpRequest = nil;
				if (pResponse != nil) {
					[pResponse release];
					pResponse = nil;
				}
			}
		}@catch (NSException *e) {
			[pool release];
			return;
		}
		
	}
	isRunning = NO;
	[pool release];
}
	
-(void) handleReceiveData: (NSArray *) arguments{
    //NSLog(@"handleReceiveData");
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	@try{
		HTTPRequest *httpRequest = (HTTPRequest *) [arguments objectAtIndex:0];
		HTTPResponse *httpResponse = [(HTTPResponse *) [arguments objectAtIndex:1] retain];
		[httpRequest.observer onHttpReceivedData:httpResponse];
		[httpResponse release];
	}@catch (NSException *e) {
        [LogUtil writeLogWithException:e];
	}
	[pool release];
}

- (void) handleReceiveError:(NSArray *)arguments{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	HTTPRequest *httpRequest = (HTTPRequest *) [arguments objectAtIndex:0];
	HTTPResponse *httpResponse = (HTTPResponse *) [arguments objectAtIndex:1];
	NSString *httpError = (NSString *) [arguments objectAtIndex:2];
	@try{
		if (httpRequest.userData) {
//			HTTPRequest *req = [self getTrackingRequest: arguments];
//			[[NetworkEngine getHttpClient] request: req];
//			[req release];
		}
		[httpRequest.observer onHttpReceivedError: httpResponse:httpError];
	}@catch (NSException *e) {
		[httpRequest.observer onHttpReceivedData:httpResponse];

	}
	[pool release];
}

@end