//
//  DTOTaskObject.h
//  OfficeOneMB
//
//  Created by macpro on 1/8/15.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOTaskObject : NSObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * clientTaskId;
@property (nonatomic, retain) NSString * clientId;
@property (nonatomic, retain) NSString * clientLeadId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * startDate;
@property (nonatomic, retain) NSString * endDate;
@property (nonatomic, retain) NSString * updatedDate;
@property (nonatomic, retain) NSString * taskStatus;

-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;
@end
