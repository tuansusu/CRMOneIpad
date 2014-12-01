//
//  OrderByObject.h
//  Voffice2.1
//
//  Created by VTIT on 8/5/13.
//
//

#import <Foundation/Foundation.h>

#define order_asc @"asc"
#define order_desc @"desc"

@interface OrderByObject : NSObject

@property(nonatomic, copy) NSString *fieldName;
@property(nonatomic, copy) NSString *typeOrder;

@end
