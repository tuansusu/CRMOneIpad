//
//  AFNetworkRequestHelper.m

#import "AFNetworkRequestHelper.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "DejalActivityView.h"
//#import "UserDefaultHelper.h"


@implementation AFNetworkRequestHelper
@synthesize delegate;

- (id) initWithRequestDownload:(NSString *)aRequestString andParams:(NSDictionary *)aParams
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString: aRequestString];
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL: url];
        [httpClient defaultValueForHeader: @"Accept"];
        
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path: aRequestString parameters: aParams];
        
        // AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            //[DejalBezelActivityView removeView];
          //  NSLog(@"response: %@", [response allHeaderFields]);
            if ([[[response allHeaderFields] objectForKey:@"SUCCESS"] isEqualToString:@"0"] && [[[response allHeaderFields] objectForKey:@"ERROR_CODE"] isEqualToString:@"2"]) {
              //  NSLog(@"bad token");
                if ([delegate respondsToSelector:@selector(sessionExpired:)]) {
                    [delegate sessionExpired: JSON];
                }
            } else {
                if ([delegate respondsToSelector:@selector(requestSuccessfulWithResult:)]) {
                    [delegate requestSuccessfulWithResult: JSON];
                }
            }
            
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
           // NSLog(@"Error %@", error);
            
            if ([delegate respondsToSelector:@selector(requestFailed:)]) {
                if ([error.localizedDescription isEqualToString:@"The request timed out."]) {
                    [delegate requestFailed: NSLocalizedString(@"timeout_message", @"")];
                } else if ([error.localizedDescription isEqualToString:@"Could not connect to the server."]
                           || [error.localizedDescription rangeOfString:@"offline"].location != NSNotFound || [error.localizedDescription rangeOfString:@"hostname could not be found"].location != NSNotFound) {
                    [delegate requestFailed: NSLocalizedString(@"lost_connection_message", @"")];
                } else {
                    [delegate requestFailed: error.localizedDescription];
                }
            }
            [DejalBezelActivityView removeView];
            
        }];
        
        [operation start];
    }
    
    return self;
}



- (id) initWithRequest:(NSString *)aRequestString andParams:(NSDictionary *)aParams
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString: aRequestString];
        //    NSLog(@"URL : %@", url);
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL: url];
        [httpClient defaultValueForHeader: @"Accept"];
        
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path: aRequestString parameters: aParams];
        
       // AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            if ([[[response allHeaderFields] objectForKey:@"SUCCESS"] isEqualToString:@"0"] && [[[response allHeaderFields] objectForKey:@"ERROR_CODE"] isEqualToString:@"2"]) {
               // NSLog(@"bad token");
                if ([delegate respondsToSelector:@selector(sessionExpired:)]) {
                    [delegate sessionExpired: JSON];
                }
            } else {
                if ([delegate respondsToSelector:@selector(requestSuccessfulWithResult:)]) {
                    [delegate requestSuccessfulWithResult: JSON];
                }
            }
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
           // NSLog(@"Error %@", error);

            if ([delegate respondsToSelector:@selector(requestFailed:)]) {
                if ([error.localizedDescription isEqualToString:@"The request timed out."]) {
                    [delegate requestFailed: NSLocalizedString(@"timeout_message", @"")];
                } else if ([error.localizedDescription isEqualToString:@"Could not connect to the server."] 
                           || [error.localizedDescription rangeOfString:@"offline"].location != NSNotFound || [error.localizedDescription rangeOfString:@"hostname could not be found"].location != NSNotFound) {
                    [delegate requestFailed: NSLocalizedString(@"lost_connection_message", @"")];
                } else {
                    [delegate requestFailed: error.localizedDescription];            
                }            
            }
            [DejalBezelActivityView removeView];

        }];
       
        [operation start];
    }
    
    return self;
}

- (id) initWithRequest:(NSString *)aRequestString
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString: aRequestString];
        NSURLRequest *request = [NSURLRequest requestWithURL: url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            //NSLog(@"response: %@", [response allHeaderFields]);
            if ([[[response allHeaderFields] objectForKey:@"SUCCESS"] isEqualToString:@"0"] && [[[response allHeaderFields] objectForKey:@"ERROR_CODE"] isEqualToString:@"2"]) {
               // NSLog(@"bad token");
                if ([delegate respondsToSelector:@selector(sessionExpired:)]) {
                    [delegate sessionExpired: JSON];
                }
            } else {
                if ([delegate respondsToSelector:@selector(requestSuccessfulWithResult:)]) {
                    [delegate requestSuccessfulWithResult: JSON];
                }
            }
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
           // NSLog(@"Error %@", error);
            if ([delegate respondsToSelector:@selector(requestFailed:)]) {
                if ([error.localizedDescription isEqualToString:@"The request timed out."]) {
                    [delegate requestFailed: NSLocalizedString(@"timeout_message", @"")];
                } else if ([error.localizedDescription isEqualToString:@"Could not connect to the server."]
                           || [error.localizedDescription rangeOfString:@"offline"].location != NSNotFound || [error.localizedDescription rangeOfString:@"hostname could not be found"].location != NSNotFound) {
                    [delegate requestFailed: NSLocalizedString(@"lost_connection_message", @"")];
                } else {
                    [delegate requestFailed: error.localizedDescription];            
                }     
            }
            [DejalBezelActivityView removeView];
        }];
        
        [operation start];
    }
    
    return self;
}

- (id) initWithRequestCheckFacebookSessionValid
{
    self = [super init];
    if (self) {
        }
    
    return self;
}

@end
