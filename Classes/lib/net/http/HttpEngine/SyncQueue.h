//
//  SyncQueue.h
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libkern/OSAtomic.h>
#include <mach/semaphore.h>
#include <mach/task.h>

@interface SyncQueue : NSObject {
	//OSSpinLock lock;
	//OSSpinLock lock2;
	//NSConditionLock *conLock;
	//int lockCondition;
	NSMutableArray * array;
	semaphore_t sem;
	task_t semaphoreTask;
	bool isBlocking;
}

- (id)pop;
- (void) push:(id)anObject;
- (void) unblock;
- (id) popNotWait;
- (void) pushNotWait:(id)anObject;
@end
