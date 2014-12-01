//
//  DateUtil.h
//  VofficeIpad2.0
//
//  Created by tuannv36 on 7/16/13.
//
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

/** Method result monday of week
 @see Date need get day of week
 @see yyyy/MM/dd HH:mm:ss ... (Format of date)
 */
+(int) getCurrentYear;

+(NSDate *) getMondayOfWeek;

+(NSString *) formatDate: (NSDate *) date : (NSString *) format;

+(NSDate *) getDateFromString : (NSString *) dateString : (NSString *) format;

+(NSString *) getDayOfWeek : (NSDate *) date;

+(int)dateDiffrenceFromDate:(NSString *)date1 second:(NSString *)date2;

+(int)dateDiffrence:(NSDate *)date1 second:(NSDate *)date2;

//+(NSArray*) getAllWeekInYear;

//+(NSArray*) getAllWeekInYear : (int*) inputWeekCurrentIndex ;

+(NSArray*) getAllWeekInYearByDate: (NSDate*) inputDate;

+(int) getCountWeekInYear;
//tinh tong so tuan cua nam xac dinh
+(int) getCountWeekInYear : (int) inputYear;

+(NSArray*) getAllWeekInYear:(int) inputYear withWeekOut: (int *)inputWeekCurrentIndex;

+(NSDate*) getMondayInWeekIndex : (int) inputWeekIndex inYear : (int) inputYear;


@end
