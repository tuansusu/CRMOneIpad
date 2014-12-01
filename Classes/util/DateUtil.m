//
//  DateUtil.m
//  VofficeIpad2.0
//
//  Created by VTIT on 7/16/13.
//
//

#import "DateUtil.h"

#define DAY_OF_WEEK_SUNDAY @"Chủ Nhật"
//NSArray *daysOfWeek = @[@"", @"Chủ Nhật",@"Thứ Hai",@"Thứ Ba",@"Thứ Tư",@"Thứ Năm",@"Thứ Sáu",@"Thứ Bảy"];


@implementation DateUtil


+(int) getCurrentYear {
    NSDate *todayDate = [NSDate date];
    return [[DateUtil formatDate:todayDate :@"yyyy"] intValue];
}

+(int) getCountWeekInYear{
    //cai nay phai tinh theo nam
    return 52;
}

//-----------------------------------------------------------------------------------------------------//
#pragma mark - getMondayOfWeek Descirption -
//-----------------------------------------------------------------------------------------------------//

+(NSDate *) getMondayOfWeek {

    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = [comps weekday];
    
    NSDate *todayDate = [NSDate date];    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSString *nowStr = [NSString stringWithFormat:@"%@",[df stringFromDate:todayDate]];
    NSDate *now = [DateUtil getDateFromString:nowStr :@"dd/MM/yyyy"];
    
    
    return  [now dateByAddingTimeInterval:24 * 60 * 60*(2-weekday)];
    
}




+(NSDate *) getMondayOfWeekWithDate : (NSDate*) inputDate {
    
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:inputDate];
    int weekday = [comps weekday];
   
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSString *nowStr = [NSString stringWithFormat:@"%@",[df stringFromDate:inputDate]];
    NSDate *now = [DateUtil getDateFromString:nowStr :@"dd/MM/yyyy"];
    
    return  [now dateByAddingTimeInterval:24 * 60 * 60*(2-weekday)];
    
}


+(NSString *) formatDate: (NSDate *) date : (NSString *) format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *stringFromDate = [formatter stringForObjectValue:date];
    return  stringFromDate;

}

+(NSDate *) getDateFromString : (NSString *) dateString : (NSString *) format{
    @try {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:format];
        NSDate* d = [df dateFromString:dateString];
        
        return  d;
    }
    @catch (NSException *exception) {
        [LogUtil writeLogWithException:exception];
    }
    
    return [NSDate date];
    
}


//Ham lay String duoc dinh dang -- Thu A  --
+(NSString *) getDayOfWeek :(NSDate *) date{
    
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = [comps weekday];
    //NSLog(@"--weekday = %d", weekday);
    
	NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    
	NSArray *daysOfWeek = @[@"", DAY_OF_WEEK_SUNDAY,@"Thứ Hai",@"Thứ Ba",@"Thứ Tư",@"Thứ Năm",@"Thứ Sáu",@"Thứ Bảy"];
    
	[nowDateFormatter setDateFormat:@"e"];
    
	//NSInteger weekdayNumber = (NSInteger)[[nowDateFormatter stringFromDate:date] integerValue];
    //NSLog(@"--weekdayNumber=%d", weekdayNumber);
	return [daysOfWeek objectAtIndex:weekday];
    
}


+(int)dateDiffrenceFromDate:(NSString *)date1 second:(NSString *)date2 {
    // Manage Date Formation same for both dates
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *startDate = [formatter dateFromString:date1];
    NSDate *endDate = [formatter dateFromString:date2];
    
    
    unsigned flags = NSDayCalendarUnit;
    NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:startDate toDate:endDate options:0];
    
    int dayDiff = [difference day];
    
    return dayDiff;
}


+(int)dateDiffrence:(NSDate *)date1 second:(NSDate *)date2 {
    // Manage Date Formation same for both dates
   
    unsigned flags = NSDayCalendarUnit;
    NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:date1 toDate:date2 options:0];
    
    int dayDiff = [difference day];
    
    return dayDiff;
}




//+(int) getCountWeekInYear {
//    NSDate *monday  = [DateUtil getMondayOfWeek];
//    int year = [[DateUtil formatDate:[monday dateByAddingTimeInterval:6*24*60*60] :@"yyyy"] intValue];
//    
//    //lay ngay dau tien cua nam
//    NSDate *dateTheFirst = [DateUtil getFirstDayInYear:year];
//    NSDate *currentDate = [NSDate date];
//    
//    unsigned flags = NSDayCalendarUnit;
//    NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:dateTheFirst toDate:currentDate options:0];
//    
//    int dayDiff = [difference day];
//    
//    int totalWeek = 0;
//    totalWeek = dayDiff/7+1;
//    return totalWeek;
//}


//tinh tong so tuan cua nam xac dinh
+(int) getCountWeekInYear : (int) inputYear{
    //khoi tao ngay dau tien cua nam
    NSDate *firstDateInYear = [DateUtil getFirstDayInYear:inputYear];
    int totalWeek = 0;
    //lay ngay cuoi cung cua nam
    NSDate *theLastDate = [DateUtil getDateFromString:[NSString stringWithFormat:@"31/12/%d", inputYear] :@"dd/MM/yyyy"];
    //kiem tra xem neu ngay cuoi cung la chu nhat thoi
    //nguoc lai se lay ngay chu nhat la ngay cuoi nam
    
    unsigned flags = NSDayCalendarUnit;
    NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:firstDateInYear toDate:theLastDate options:0];
    
    int dayDiff = [difference day];
    
    totalWeek = dayDiff/7;
    if (![[DateUtil getDayOfWeek:theLastDate] isEqualToString:DAY_OF_WEEK_SUNDAY]) {
        //totalWeek = totalWeek -1;
    }
    return totalWeek;
}

//neu ma nam khong phai hien tai thi lay tuan cuoi cung cua nam la tuan hien thi
+(NSArray*) getAllWeekInYear:(int) inputYear withWeekOut: (int *)inputWeekCurrentIndex{
    
    
    
    NSDate *dateTheFirstYear = [DateUtil getFirstDayInYear:inputYear];
    NSDate *firstDateInYear = [DateUtil getFirstDayInYear:inputYear];
    int totalWeek = 0;
    //lay ngay cuoi cung cua nam
    NSDate *theLastDate = [DateUtil getDateFromString:[NSString stringWithFormat:@"31/12/%d", inputYear] :@"dd/MM/yyyy"];
    //kiem tra xem neu ngay cuoi cung la chu nhat thoi
    //nguoc lai se lay ngay chu nhat la ngay cuoi nam
    
    unsigned flags = NSDayCalendarUnit;
    NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:firstDateInYear toDate:theLastDate options:0];
    
    int dayDiff = [difference day];
    totalWeek = dayDiff/7;
    *inputWeekCurrentIndex  = totalWeek-1;
    NSString *textOfMonDayWeek = @"";
    NSString *textOfSunDayWeek = @"";
    NSDate *lastWeekDate ;//= [NSDate new]
    
    NSMutableArray *arrayWeekInYear = [[NSMutableArray alloc]init];
    
    for (int i=0; i<totalWeek; i++) {
        lastWeekDate=[dateTheFirstYear dateByAddingTimeInterval:6*24 * 60 * 60];
        textOfMonDayWeek = [DateUtil formatDate:dateTheFirstYear :@"dd/MM"];
        textOfSunDayWeek = [DateUtil formatDate:lastWeekDate :@"dd/MM"];
        [arrayWeekInYear addObject:[NSString stringWithFormat:@"T(%d) từ %@-%@", (i+1),textOfMonDayWeek, textOfSunDayWeek ]];
        
        dateTheFirstYear = [dateTheFirstYear dateByAddingTimeInterval:7*24 * 60 * 60];
    }
    
    return [NSArray arrayWithArray:arrayWeekInYear];
}

/*
 Lay cac tuan tu dau nam
 */
+(NSArray*) getAllWeekInYearByDate: (NSDate*) inputDate{
    NSMutableArray *arrayWeekInYear = [[NSMutableArray alloc]init];
    NSDate *monday  = [DateUtil getMondayOfWeekWithDate:inputDate];
    int year = [[DateUtil formatDate:[monday dateByAddingTimeInterval:6*24*60*60] :@"yyyy"] intValue];
    
    NSDate *dateTheFirst = [DateUtil getFirstDayInYear:year];
    unsigned flags = NSDayCalendarUnit;
    NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:dateTheFirst toDate:inputDate options:0];
    int dayDiff = [difference day];
    
    int totalWeek = 0;
    totalWeek = dayDiff/7+1;
    
    NSString *textOfMonDayWeek = @"";
    NSString *textOfSunDayWeek = @"";
    NSDate *lastWeekDate ;//= [NSDate new]
    for (int i=0; i<totalWeek; i++) {
        lastWeekDate=[dateTheFirst dateByAddingTimeInterval:6*24 * 60 * 60];
        textOfMonDayWeek = [DateUtil formatDate:dateTheFirst :@"dd/MM"];
        textOfSunDayWeek = [DateUtil formatDate:lastWeekDate :@"dd/MM"];
        [arrayWeekInYear addObject:[NSString stringWithFormat:@"T(%d) từ %@-%@", (i+1),textOfMonDayWeek, textOfSunDayWeek]];
        
        dateTheFirst = [dateTheFirst dateByAddingTimeInterval:7*24 * 60 * 60];
    }
    
    return [NSArray arrayWithArray:arrayWeekInYear];
}
//lay ngay dau tien cua nam 2014 la 30/12/2013
+(NSDate*) getFirstDayInYear : (int) inputYear {
   
    NSDate *theFirstDate = [DateUtil getDateFromString:[NSString stringWithFormat:@"01/01/%d", inputYear] :@"dd/MM/yyyy"];
    return [DateUtil getMondayOfWeekWithDate:theFirstDate];
}


//lay ngay dau tien cua nam 2014 la 30/12/2013
+(NSDate*) getMondayInWeekIndex : (int) inputWeekIndex inYear : (int) inputYear {
    NSDate *theFirstDateInYear = [DateUtil getFirstDayInYear: inputYear];
    return [theFirstDateInYear dateByAddingTimeInterval:inputWeekIndex*7*24*60*60];
}

@end
