//
//  DTOProductLeadTypeObject.h
//  OfficeOneMB
//
//  Created by macpro on 12/31/14.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOProductLeadTypeObject : NSObject

@property (nonatomic, retain) NSString *productTypeId;
@property (nonatomic, retain) NSString *name ;
@property (nonatomic, retain) NSString *code ;
@property (nonatomic, retain) NSString *isActive ;

-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;

@end
