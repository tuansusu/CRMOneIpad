//
//  DataUtil.h
//  Voffice2.1
//
//  Created by VTIT on 7/31/13.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataUtil : NSObject
/*
 *Lay duong dan file sqlite
 */
+(NSString*) getPathFileSqlLite;
/*
 *Dem tong so items trong table
 */
+(NSInteger) getCountItemsByTableName : (NSString*) tableName;
/*
 *Dem tong so item trong cau truy van
 */
+(NSInteger) getCountItemsselectQuery : (NSString*) query valueParamemter : (NSArray*) paramemters;
/*
 *Tra danh sach du lieu tu cau truy van!
 */
+(NSMutableArray*) BuilQueryGetListWithListFields : (NSArray*) allFields  selectQuery : (NSString*) query valueParameter : (NSArray*) parameters;
+(sqlite3*) openDatabase ;
+(BOOL) closeDatabase;
/*
 * thuc hien cau truy van
 */
+(BOOL) exeQuery : (NSString*) query;
+(void) setCheckInsertedCache : (BOOL) checkInsert;
+(BOOL) getCheckInsertCache ;
+(BOOL) vacuumDatabase;


@end
