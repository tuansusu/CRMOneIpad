
#import <Foundation/Foundation.h>
@class AFHTTPClient;
@interface CustomOperationQueue : NSObject
{
    @private
    NSOperationQueue *appQueue;
}
+ (id)sharedInstance;
-(void)addOperation:(NSOperation*)_operation;

@end
