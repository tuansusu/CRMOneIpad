//
//  DTOAcountLeadProcessObject.h
//  OfficeOneMB
//
//  Created by Pham Ngoc Hoang on 12/20/14.
//
//

#import <Foundation/Foundation.h>

@class Items;
@interface DTOAcountLeadProcessObject : NSObject

@property (nonatomic, retain) NSString *accountId;
@property (nonatomic, retain) NSString *address ;
@property (nonatomic, retain) NSString *areaId ;
@property (nonatomic, retain) NSString *assetTotal ;
@property (nonatomic, retain) NSString *auditId ;
@property (nonatomic, retain) NSString *birthday ;
@property (nonatomic, retain) NSString *campaignId ;
@property (nonatomic, retain) NSString *clientId ;
@property (nonatomic, retain) NSString *clientLeadId ;
@property (nonatomic, retain) NSString *code ;
@property (nonatomic, retain) NSString *companyPhone ;
@property (nonatomic, retain) NSString *createdBy ;
@property (nonatomic, retain) NSString *createdDate;
@property (nonatomic, retain) NSString *charter ;
@property (nonatomic, retain) NSString *disableEmail ;
@property (nonatomic, retain) NSString *disableMeeting ;
@property (nonatomic, retain) NSString *disablePhone ;
@property (nonatomic, retain) NSString *disableSms ;
@property (nonatomic, retain) NSString *email ;
@property (nonatomic, retain) NSString *employeeNumber ;
@property (nonatomic, retain) NSString *equityOwner ;
@property (nonatomic, retain) NSString *fax ;
@property (nonatomic, retain) NSString *identifiedNumber ;
@property (nonatomic, retain) NSString *isFi ;
@property (nonatomic, retain) NSString *languageId ;
@property (nonatomic, retain) NSString *lat ;
@property (nonatomic, retain) NSString *leadId ;
@property (nonatomic, retain) NSString *leadStatusId ;
@property (nonatomic, retain) NSString *leadType ;
@property (nonatomic, retain) NSString *lon ;
@property (nonatomic, retain) NSString *marialStatus ;
@property (nonatomic, retain) NSString *mergedLeadId ;
@property (nonatomic, retain) NSString *mobile ;
@property (nonatomic, retain) NSString *monthlyIncome ;
@property (nonatomic, retain) NSString *name ;

-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;

@end
