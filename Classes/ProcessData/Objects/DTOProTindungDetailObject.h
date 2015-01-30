//
//  DTOProTindungDetailObject.h
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOProTindungDetailObject : NSObject
@property (nonatomic, retain) NSString * BRANCH_CODE;
@property (nonatomic, retain) NSString * CONTRACT_NUMBER;
@property (nonatomic, retain) NSString * OPEN_DATE;
@property (nonatomic, retain) NSString * EXPIRE_DATE;
@property (nonatomic, retain) NSString * EXTENSION_DATE;
@property (nonatomic, retain) NSString * BALANCE;
@property (nonatomic, retain) NSString * BALANCE_QD;
@property (nonatomic, retain) NSString * SOD_BALANCE;
@property (nonatomic, retain) NSString * SOD_BALANCE_QD;
@property (nonatomic, retain) NSString * CURRENCY;
@property (nonatomic, retain) NSString * CLIENT_ID;
@property (nonatomic, retain) NSString * TERM;
@property (nonatomic, retain) NSString * TERM_TYPE;
@property (nonatomic, retain) NSString * DEPT_GROUP;
@property (nonatomic, retain) NSString * DEPT_GROUP2;
@property (nonatomic, retain) NSString * FIXED_INTEREST;
@property (nonatomic, retain) NSString * INTEREST_MARGIN;
@property (nonatomic, retain) NSString * INTEREST;
@property (nonatomic, retain) NSString * RECEIVEABLE_AMOUNT;
@property (nonatomic, retain) NSString * STATUS;
@property (nonatomic, retain) NSString * BUSSINESS_DATE;
@property (nonatomic, retain) NSString * INITIAL_BALANCE;
@property (nonatomic, retain) NSString * PREPAID_INTEREST;
@property (nonatomic, retain) NSString * OVERDUE_INTEREST;
@property (nonatomic, retain) NSString * SECTOR;
@property (nonatomic, retain) NSString * SOURCE_OF_FUND;
@property (nonatomic, retain) NSString * SECURE;
@property (nonatomic, retain) NSString * GL;
@property (nonatomic, retain) NSString * INDUSTRY_CODE;
@property (nonatomic, retain) NSString * INTEREST_TYPE;
@property (nonatomic, retain) NSString * INTEREST_KEY;
@property (nonatomic, retain) NSString * INPUTTER;
@property (nonatomic, retain) NSString * PRODUCT_CODE;
@property (nonatomic, retain) NSString * RM_CODE;
@property (nonatomic, retain) NSString * KHOI;
@property (nonatomic, retain) NSString * RM_BANCHEO;
@property (nonatomic, retain) NSString * PURPOSE;

+(NSArray*)allFields;
-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;
@end
