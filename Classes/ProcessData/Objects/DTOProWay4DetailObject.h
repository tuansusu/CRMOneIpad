//
//  DTOProWay4Detail.h
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOProWay4DetailObject : NSObject

@property (nonatomic, retain) NSString * ID;
@property (nonatomic, retain) NSString * CARD_NUMBER;
@property (nonatomic, retain) NSString * CARD_HOLDER_NAME;
@property (nonatomic, retain) NSString * CLIENT_ID;
@property (nonatomic, retain) NSString * CURRENT_ACCOUNT;
@property (nonatomic, retain) NSString * PRODUCT_CODE;
@property (nonatomic, retain) NSString * BRANCH_CODE;
@property (nonatomic, retain) NSString * OPEN_DATE;
@property (nonatomic, retain) NSString * EXPIRE_DATE;
@property (nonatomic, retain) NSString * AVAIABLE;
@property (nonatomic, retain) NSString * BLOCKED;
@property (nonatomic, retain) NSString * BALANCE;
@property (nonatomic, retain) NSString * STATUS;
@property (nonatomic, retain) NSString * TYPE;
@property (nonatomic, retain) NSString * BUSSINESS_DATE;
@property (nonatomic, retain) NSString * CREATED_DATE;
@property (nonatomic, retain) NSString * UPDATED_DATE;
@property (nonatomic, retain) NSString * RM_CODE;
@property (nonatomic, retain) NSString * CONTRACT_NUMBER;

+(NSArray*)allFields;
-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;

@end
