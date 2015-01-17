
#import <Foundation/Foundation.h>

typedef enum {
    HttpMethodGet,
    HttpMethodPost,
    HttpMethodPut,
    HttpMethodDelete
}HttpMethod;

@interface RequestHelper : NSObject


+ (void)requestWithURL:(NSURL*)_URL
                method:(HttpMethod)_method
                params:(NSDictionary*)_params
               success:(void (^)(id result))success
               failure:(void (^)(NSError *error))failure;

@end
