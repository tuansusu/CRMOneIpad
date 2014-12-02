//
//  BaseDataProcess.h
//  Voffice2.1
//
//  Created by VTIT on 7/31/13.
//
//

#import <Foundation/Foundation.h>

@interface BaseDataProcess : NSObject

-(BOOL) addToDBWithTableName:(NSString*) tableName dictionary : (NSMutableDictionary*) dic;
-(BOOL) addPureToDBWithTableName:(NSString*) tableName dictionary : (NSMutableDictionary*) dic;

-(BOOL) checkExistObjectWithTableName: (NSString*) tableName dictionaryKeys : (NSMutableDictionary*) dicKeys;
-(NSMutableArray*) getAllItemsWithTableName : (NSString*) tableName withFields: (NSArray*) allFields;

-(NSMutableArray*) getAllItemsWithTableName : (NSString*) tableName withFields: (NSArray*) allFields withOrderBy : (NSMutableArray*) orderByFields;

-(NSMutableArray*) getAllItemsWithTableNameAndCondition : (NSString*) tableName withFields: (NSArray*) allFields withCondition : (NSString*) condition;

//para memter chinh la danh sach cac gia tri
-(NSMutableArray*) getAllItemsWithTableName : (NSString*) tableName withFields: (NSArray*) allFields withConditionString : (NSString*) condition withParameter: (NSArray*) parameters withOrderByFields: (NSArray*) orderFields;

//para memter chinh la danh sach cac gia tri
-(NSMutableArray*) getAllItemsWithTableName : (NSString*) tableName withFields: (NSArray*) allFields withConditionString : (NSString*) condition withParameter: (NSArray*) parameters withOrderByFields: (NSArray*) orderFields withCurpage : (NSInteger) curPage withItemsPerpage : (NSInteger) limit;

-(BOOL) updateToTableName : (NSString*) tableName withFields: (NSMutableDictionary*) fieldsConditions withCondition : (NSDictionary*) condition;

-(NSInteger) getMaxClientIdWithTableName : (NSString*) tableName withField : (NSString*) fieldName;

@end
