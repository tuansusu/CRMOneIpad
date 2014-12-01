//
//  NetworkEngine.h
//  KunKun
//
//  Created by Nguyen Quang Hieu on 11/25/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPClient.h"

@interface NetworkEngine : NSObject {

}
+ (HTTPClient *) getHttpClient;
@end
