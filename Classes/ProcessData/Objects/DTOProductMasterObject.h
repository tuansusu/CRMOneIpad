//
//  DTOProductMasterObject.h
//  OfficeOneMB
//
//  Created by macpro on 1/1/15.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOProductMasterObject : NSObject

@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *name ;

+(NSArray*)allFields;
-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;

@end
