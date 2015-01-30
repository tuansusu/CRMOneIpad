//
//  DTOProductDetailObject.h
//  OfficeOneMB
//
//  Created by macpro on 1/1/15.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOProductDetailObject : NSObject

@property (nonatomic, retain) NSString *productDetailId;
@property (nonatomic, retain) NSString *contractNumber ;
@property (nonatomic, retain) NSString *balance ;
@property (nonatomic, retain) NSString *openDate;
@property (nonatomic, retain) NSString *expiredDate;
@property (nonatomic, retain) NSString *status ;
@property (nonatomic, retain) NSString *type ;
@property (nonatomic, retain) NSString *branchCode ;
@property (nonatomic, retain) NSString *currency ;
@property (nonatomic, retain) NSString *productCode ;
@property (nonatomic, retain) NSString *clientId ;
@property (nonatomic, retain) NSString *bussinessDate ;
@property (nonatomic, retain) NSString *createdDate ;
@property (nonatomic, retain) NSString *updatedDate ;
@property (nonatomic, retain) NSString *rmCode ;
@property (nonatomic, retain) NSString *balanceQD ;
@property (nonatomic, retain) NSString *Khoi;
@property (nonatomic, retain) NSString *rmBancheo ;

+(NSArray*)allFields;
-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;


@end
