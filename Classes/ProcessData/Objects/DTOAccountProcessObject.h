//
//  DTOAccountProcessObject.h
//  OfficeOneMB
//
//  Created by macpro on 12/20/14.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOAccountProcessObject : NSObject

@property (nonatomic, retain) NSString *name ;

-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;

@end
