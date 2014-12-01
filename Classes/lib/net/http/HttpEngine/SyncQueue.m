//
//  SyncQueue.m
//  NetworkDemo
//
//  Created by rd on 6/7/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import "SyncQueue.h"
#include <mach/mach_traps.h>


@implementation SyncQueue
NSConditionLock *theConditionLock;
enum {
    kWorkTodo = 1,
    kNoWorkTodo = 0
};

-(id) init {
	if (self = [super init]) {
		isBlocking = FALSE;
		sem = 0;
		if (theConditionLock) {
			[theConditionLock release];
			theConditionLock = nil;
		}
		theConditionLock = [[NSConditionLock alloc] initWithCondition: kNoWorkTodo];
//		semaphoreTask = mach_task_self();
//		semaphore_create(semaphoreTask, &sem, SYNC_POLICY_FIFO, 0);
		isBlocking = TRUE;
		array =[[NSMutableArray alloc] init];
	}
	
	return self;
}

// Queues are first-in-first-out, so we remove objects from the head
- (id)pop {
	[theConditionLock lockWhenCondition:kWorkTodo]; // Wait until there is work to do
	//semaphore_wait(sem);
	id queueObject = nil;
	@synchronized(self) {
		if ([array count] == 0) {
		}
		else {
			queueObject = [array objectAtIndex:0];
			//avoid queueObject is destroyed
			[queueObject retain];
			[array removeObjectAtIndex:0];
		}
	}
//	if (array.count==0) {

	[theConditionLock unlockWithCondition:kNoWorkTodo];
		
//	}		
	if (array.count!=0) {
	
	[theConditionLock unlockWithCondition:kWorkTodo];
	}		
	
    return [queueObject autorelease];
}

// Queues are first-in-first-out, so we remove objects from the head
- (id)popNotWait {
	id queueObject = nil;
	@synchronized(self) {
		if ([array count] == 0) {
		}
		else {
			queueObject = [array objectAtIndex:0];
			//avoid queueObject is destroyed
			[queueObject retain];
			[array removeObjectAtIndex:0];
		}
	}
    return [queueObject autorelease];
}

// Add to the tail of the queue
- (void) pushNotWait:(id)anObject {
	@synchronized(self) {
		//this method automatically adds to the end of the array
		//[self addObject:anObject];
		[array addObject:anObject];
	}
}


// Add to the tail of the queue
- (void) push:(id)anObject {
	[theConditionLock lock];
	@synchronized(self) {
		//this method automatically adds to the end of the array
		//[self addObject:anObject];
		
		[array addObject:anObject];
	}
	
	//signal semaphore
	//semaphore_signal(sem);
	[theConditionLock unlockWithCondition:kWorkTodo];
}

- (void) unblock {
	if (isBlocking == TRUE) {
		//semaphore_destroy(semaphoreTask, sem);
		[theConditionLock release];
		theConditionLock=nil;
		isBlocking = FALSE;
	}
}

-(void) dealloc {
	[self unblock];
	[array release];
	[super dealloc];	
}
@end
