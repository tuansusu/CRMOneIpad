//
//  DTOAccountProcessObject.h
//  OfficeOneMB
//
//  Created by macpro on 12/20/14.
//
//

#import <Foundation/Foundation.h>

@class Items;

@interface DTOAccountProcessObject : NSObject

@property (nonatomic, retain) NSString *accountId;
@property (nonatomic, retain) NSString *accountLevel ;
@property (nonatomic, retain) NSString *accountType ;
@property (nonatomic, retain) NSString *activityStatus ;
@property (nonatomic, retain) NSString *address ;
@property (nonatomic, retain) NSString *areaId ;
@property (nonatomic, retain) NSString *assetTotal ;
@property (nonatomic, retain) NSString *birthday ;
@property (nonatomic, retain) NSString *branchCode ;
@property (nonatomic, retain) NSString *charter ;
@property (nonatomic, retain) NSString *clientAccountId ;
@property (nonatomic, retain) NSString *clientId ;
@property (nonatomic, retain) NSString *code ;
@property (nonatomic, retain) NSString *createdBy ;
@property (nonatomic, retain) NSString *createdDate ;
@property (nonatomic, retain) NSString *disableEmail ;
@property (nonatomic, retain) NSString *disableMeeting ;
@property (nonatomic, retain) NSString *disablePhone ;
@property (nonatomic, retain) NSString *disableSms ;
@property (nonatomic, retain) NSString *email ;
@property (nonatomic, retain) NSString *employeeCode ;
@property (nonatomic, retain) NSString *employeeNumber ;
@property (nonatomic, retain) NSString *familyIncome ;
@property (nonatomic, retain) NSString *fax ;
@property (nonatomic, retain) NSString *identifiedIssueArea ;
@property (nonatomic, retain) NSString *identifiedIssueDate ;
@property (nonatomic, retain) NSString *identifiedNumber ;
@property (nonatomic, retain) NSString *industryBusiness ;
@property (nonatomic, retain) NSString *isActive ;
@property (nonatomic, retain) NSString *languageId ;
@property (nonatomic, retain) NSString *lastTransaction ;
@property (nonatomic, retain) NSString *lat ;
@property (nonatomic, retain) NSString *lon ;
@property (nonatomic, retain) NSString *marialStatus ;
@property (nonatomic, retain) NSString *mnemonic ;
@property (nonatomic, retain) NSString *mobile ;
@property (nonatomic, retain) NSString *name ;
@property (nonatomic, retain) NSString *openCodeDate ;
@property (nonatomic, retain) NSString *orgType ;
@property (nonatomic, retain) NSString *ownerEmployeeId ;
@property (nonatomic, retain) NSString *personalIncome ;
@property (nonatomic, retain) NSString *personalIndustry ;
@property (nonatomic, retain) NSString *phone ;
@property (nonatomic, retain) NSString *registrationAddress ;
@property (nonatomic, retain) NSString *registrationDate ;
@property (nonatomic, retain) NSString *registrationNumber ;
@property (nonatomic, retain) NSString *revenue ;
@property (nonatomic, retain) NSString *sector ;
@property (nonatomic, retain) NSString *setupDate ;
@property (nonatomic, retain) NSString *sex ;
@property (nonatomic, retain) NSString *shareholderNumber ;
@property (nonatomic, retain) NSString *status ;
@property (nonatomic, retain) NSString *swiftCode ;
@property (nonatomic, retain) NSString *sysOrganizationId ;
@property (nonatomic, retain) NSString *taxCode ;
@property (nonatomic, retain) NSString *taxIssuedDate ;
@property (nonatomic, retain) NSString *updatedBy ;
@property (nonatomic, retain) NSString *updatedDate ;
@property (nonatomic, retain) NSString *website ;
@property (nonatomic, retain) NSString *id ;

-(Items*)itemObject;
- (NSMutableDictionary *)convertToDictionary;
- (void)parseFromDictionary:(NSDictionary *)dictionary;
- (void)parseFromItem:(Items*)item;

@end
