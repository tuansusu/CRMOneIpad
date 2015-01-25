//
//  DTOProBaoLanhDetail.h
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOProBaoLanhDetailObject : NSObject

@property (nonatomic, retain) NSString * ID;
@property (nonatomic, retain) NSString * BRANCH_CODE;
@property (nonatomic, retain) NSString * CONTRACT_NUMBER;
@property (nonatomic, retain) NSString * CATEGORY;
@property (nonatomic, retain) NSString * REF;
@property (nonatomic, retain) NSString * CLIENT_ID;
@property (nonatomic, retain) NSString * SECTOR;
@property (nonatomic, retain) NSString * INDUSTRY_CODE;
@property (nonatomic, retain) NSString * CURRENCY;
@property (nonatomic, retain) NSString * BALANCE;
@property (nonatomic, retain) NSString * OPEN_DATE;
@property (nonatomic, retain) NSString * VALUE_DATE;
@property (nonatomic, retain) NSString * EXPIRE_DATE;
@property (nonatomic, retain) NSString * MD_FREE;
@property (nonatomic, retain) NSString * MARGIN;
@property (nonatomic, retain) NSString * MARGIN_AMOUNT;
@property (nonatomic, retain) NSString * RECEIVER_CODE;
@property (nonatomic, retain) NSString * RECEIVER_NAME;
@property (nonatomic, retain) NSString * UPDATE_LIMIT;
@property (nonatomic, retain) NSString * PROVISION;
@property (nonatomic, retain) NSString * MARGIN_FLAG;
@property (nonatomic, retain) NSString * MARGIN2;
@property (nonatomic, retain) NSString * LIQUIDATION_MODE;
@property (nonatomic, retain) NSString * FEE_TYPE;
@property (nonatomic, retain) NSString * FREQUENCY;
@property (nonatomic, retain) NSString * AUTO_EXPIRE;
@property (nonatomic, retain) NSString * BUSSINESS_DATE;
@property (nonatomic, retain) NSString * CMS_DATE;
@property (nonatomic, retain) NSString * CMS_AMT;
@property (nonatomic, retain) NSString * DESCRIPTION;
@property (nonatomic, retain) NSString * INITIAL_MARGIN;
@property (nonatomic, retain) NSString * BALANCE_QD;
@property (nonatomic, retain) NSString * FOREX_RATE;
@property (nonatomic, retain) NSString * PRODUCT_CODE;
@property (nonatomic, retain) NSString * RM_CODE;
@property (nonatomic, retain) NSString * KHOI;
@property (nonatomic, retain) NSString * RM_BANCHEO;

+(NSArray*)allFields;
-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;

@end
