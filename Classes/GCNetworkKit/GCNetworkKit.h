//
//  GCNetworkKit.h
//
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
//
//  Copyright 2012 Giulio Petek
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#import "NSString+GCNetworkRequest.h"
#import "GCNetworkDownloadRequest.h"
#import "GCNetworkFormRequest.h"
#import "GCNetworkRequest.h"
#import "GCNetworkAPIWrapper.h"
#import "GCNetworkCenter.h"
#import "GCNetworkRequestOperation.h"
#import "GCNetworkRequestQueue.h"
#import "GCDataTransformer.h"
#import "GCNetworkImageRequest.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 50000
#define __GC_weak __weak
#else
#define __GC_weak __unsafe_unretained
#endif