//
//  DTOProTTQTDetail.h
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOProTTQTDetailObject : NSObject

@property (nonatomic, retain) NSString * ID;
@property (nonatomic, retain) NSString * BRANCH_CODE;
@property (nonatomic, retain) NSString * CONTRACT_NUMBER;
@property (nonatomic, retain) NSString * CLIENT_ID;
@property (nonatomic, retain) NSString * LC_TYPE;
@property (nonatomic, retain) NSString * IMP_EXP;
@property (nonatomic, retain) NSString * ISSUE_DATE;
@property (nonatomic, retain) NSString * LC_CCY;
@property (nonatomic, retain) NSString * LC_AMOUNT;
@property (nonatomic, retain) NSString * LC_AMOUNT_USD;
@property (nonatomic, retain) NSString * OUT_TYPE;
@property (nonatomic, retain) NSString * OUT_CCY;
@property (nonatomic, retain) NSString * OUT_AMOUNT;
@property (nonatomic, retain) NSString * OUT_AMOUNT_USD;
@property (nonatomic, retain) NSString * OUT_VALUE_DATE;
@property (nonatomic, retain) NSString * STATUS;
@property (nonatomic, retain) NSString * SECTOR;
@property (nonatomic, retain) NSString * BUSSINESS_DATE;
@property (nonatomic, retain) NSString * CREATED_DATE;
@property (nonatomic, retain) NSString * UPDATE_DATE;
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
