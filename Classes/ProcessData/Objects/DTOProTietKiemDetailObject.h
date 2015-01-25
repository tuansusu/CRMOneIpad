//
//  DTOProTietKiemDetail.h
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOProTietKiemDetailObject : NSObject

@property (nonatomic, retain) NSString * ID;
@property (nonatomic, retain) NSString * BRANCH_CODE;
@property (nonatomic, retain) NSString * CONTRACT_NUMBER;
@property (nonatomic, retain) NSString * OPEN_DATE;
@property (nonatomic, retain) NSString * EXPIRED_DATE;
@property (nonatomic, retain) NSString * TRANSACTION_DATE;
@property (nonatomic, retain) NSString * BALANCE;
@property (nonatomic, retain) NSString * BALANCE_QD;
@property (nonatomic, retain) NSString * CARD_FLAG;
@property (nonatomic, retain) NSString * ACC_STATUS;
@property (nonatomic, retain) NSString * SOD_BALANCE;
@property (nonatomic, retain) NSString * SOD_BALANCE_QD;
@property (nonatomic, retain) NSString * CURRENCY;
@property (nonatomic, retain) NSString * CLIENT_ID;
@property (nonatomic, retain) NSString * TERM_DAY;
@property (nonatomic, retain) NSString * TERM_WEEK;
@property (nonatomic, retain) NSString * TERM_TXT;
@property (nonatomic, retain) NSString * SUSPEND_INTEREST;
@property (nonatomic, retain) NSString * INTEREST;
@property (nonatomic, retain) NSString * EXPENSE_INTEREST;
@property (nonatomic, retain) NSString * LINE_T24;
@property (nonatomic, retain) NSString * INDUSTRY_CODE;
@property (nonatomic, retain) NSString * SECTOR;
@property (nonatomic, retain) NSString * GL;
@property (nonatomic, retain) NSString * PRODUCT_CODE;
@property (nonatomic, retain) NSString * RM_CODE;
@property (nonatomic, retain) NSString * BUSSINESS_DATE;
@property (nonatomic, retain) NSString * KHOI;


+(NSArray*)allFields;
-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;

@end
