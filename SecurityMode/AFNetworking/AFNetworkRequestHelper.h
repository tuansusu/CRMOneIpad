//
//  AFNetworkRequestHelper.h


#import <Foundation/Foundation.h>

@protocol AFNetworkRequestDelegate <NSObject>
    
@optional
- (void) requestSuccessfulWithResult:(id)JSON;
- (void) requestFailed:(NSString *)errorDescription;
- (void) sessionExpired:(id)JSON;
- (void) facebookSessionExpired:(BOOL)expired;
@end

@interface AFNetworkRequestHelper : NSObject {
@private
    id<AFNetworkRequestDelegate> delegate;
}

@property (strong, nonatomic) id<AFNetworkRequestDelegate> delegate;
- (id) initWithRequest:(NSString *)aRequestString andParams:(NSDictionary *)aParams;
- (id) initWithRequest:(NSString *)aRequestString;
- (id) initWithRequestCheckFacebookSessionValid;
@end
