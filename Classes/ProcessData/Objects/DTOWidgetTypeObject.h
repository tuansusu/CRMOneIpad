//
//  DTOWidgetTypeObject.h
//  OfficeOneMB
//
//  Created by macpro on 1/20/15.
//
//

#import <Foundation/Foundation.h>

@class Items;
@interface DTOWidgetTypeObject : NSObject

@property (nonatomic, retain) NSString * widgetId;
@property (nonatomic, retain) NSString * widgetName;
@property (nonatomic, retain) NSString * widgetType;

+(NSArray*)allFields;
-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;

@end
