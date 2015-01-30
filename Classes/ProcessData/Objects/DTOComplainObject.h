//
//  DTOComplainObject.h
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOComplainObject : NSObject

@property (nonatomic, retain) NSString * casesId;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * reason;
@property (nonatomic, retain) NSString * result;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * fromReceived;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * priority;
@property (nonatomic, retain) NSString * receiverId;
@property (nonatomic, retain) NSString * receivedDate;
@property (nonatomic, retain) NSString * processerId;
@property (nonatomic, retain) NSString * processedDate;
@property (nonatomic, retain) NSString * closedId;
@property (nonatomic, retain) NSString * closedDate;
@property (nonatomic, retain) NSString * accountId;
@property (nonatomic, retain) NSString * productMasterId;
@property (nonatomic, retain) NSString * acceptTypeId;
@property (nonatomic, retain) NSString * agentText;
@property (nonatomic, retain) NSString * assignBy;
@property (nonatomic, retain) NSString * blackList;
@property (nonatomic, retain) NSString * callLenght;


+(NSArray*)allFields;
-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;

@end
