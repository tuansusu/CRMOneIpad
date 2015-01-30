//
//  DTOWidgetObject.h
//  OfficeOneMB
//
//  Created by macpro on 1/18/15.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOWidgetObject : NSObject

@property (nonatomic, retain) NSString * confId;
@property (nonatomic, retain) NSString * accountName;
@property (nonatomic, retain) NSString * typeGraphically;
@property (nonatomic, retain) NSString * colorDisplay1;
@property (nonatomic, retain) NSString * createDate;
@property (nonatomic, retain) NSString * isShowData;
@property (nonatomic, retain) NSString * colorDisplay2;
@property (nonatomic, retain) NSString * widgetId;
@property (nonatomic, retain) NSString * widgetName;
@property (nonatomic, retain) NSString * widgetType;
@property (nonatomic, retain) NSString * status;

+(NSArray*)allFields;
-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;

@end
