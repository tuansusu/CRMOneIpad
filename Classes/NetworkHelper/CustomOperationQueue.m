
#import "CustomOperationQueue.h"
#import "AFNetworking.h"
@implementation CustomOperationQueue
static CustomOperationQueue *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (CustomOperationQueue *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        appQueue=[[NSOperationQueue alloc] init];
        [appQueue setMaxConcurrentOperationCount:5];
        // Work your initialising magic here as you normally would
    }
    
    return self;
}

-(void)addOperation:(NSOperation*)_operation{
    [appQueue addOperation:_operation];
}


// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [self sharedInstance];
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
