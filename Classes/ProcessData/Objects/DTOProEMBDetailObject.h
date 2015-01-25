//
//  DTOProEMBDetailObject.h
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOProEMBDetailObject : NSObject

@property (nonatomic, retain) NSString * ID;
@property (nonatomic, retain) NSString * CONTRACT_NUMBER;
@property (nonatomic, retain) NSString * PRODUCT_CODE;
@property (nonatomic, retain) NSString * CLIENT_ID;
@property (nonatomic, retain) NSString * BRANCH_CODE;
@property (nonatomic, retain) NSString * CMT;
@property (nonatomic, retain) NSString * START_DATE;
@property (nonatomic, retain) NSString * END_DATE;
@property (nonatomic, retain) NSString * BUSSINESS_DATE;
@property (nonatomic, retain) NSString * CREATED_DATE;
@property (nonatomic, retain) NSString * UPDATE_DATE;
@property (nonatomic, retain) NSString * RM_CODE;

+(NSArray*)allFields;
-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;


@end
