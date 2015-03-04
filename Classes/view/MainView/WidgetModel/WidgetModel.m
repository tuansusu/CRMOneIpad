//
//  WidgetModel.m
//  OfficeOneMB
//
//  Created by macpro on 3/2/15.
//
//

#import "WidgetModel.h"

#import "DataUtil.h"

#import "DTOWidgetTypeObject.h"

#import "Items.h"

#define TABLENAME_DTORMDAILYTIETKIEM @"dtoRmDailyTietkiem"
#define TABLENAME_DTORMDAILYTHANHTOAN1 @"dtoRmDailyThanhToan1"

#define TABLENAME_DTORMMONTHLYHDV @"dtoRmMonthlyHDV"

#define TABLENAME_DTORMDAILYTINDUNG @"dtoRmDailyTindung"
#define TABLENAME_DTORMMONTHLYTINDUNG @"dtoRmMonthlyTindung"

@implementation WidgetModel

-(NSMutableArray*) filterHDVThoiDiemFromDate:(NSString*)fromDate toDate:(NSString*)toDate{

    NSArray *allFields =[NSArray arrayWithObjects:BALANCE_QD, BUSSINESS_DATE, nil];

    NSString *query = [NSString stringWithFormat:@"select SUM(BALANCE_QD) as BALANCE_QD ,"  @"strftime('%%Y-%%m',BUSSINESS_DATE) as BUSSINESS_DATE from("
                        @" SELECT BUSSINESS_DATE,BALANCE_QD FROM %@"
                        @" UNION ALL"
                        @" SELECT BUSSINESS_DATE,BALANCE_QD FROM %@"
                        @" ) as WidgetData"
                       @" where BUSSINESS_DATE  between '%@' and '%@'"
                       @" group by strftime('%%Y-%%m', BUSSINESS_DATE)"
                       @" order by BUSSINESS_DATE asc",TABLENAME_DTORMDAILYTIETKIEM,TABLENAME_DTORMDAILYTHANHTOAN1,fromDate,toDate];

    NSLog(@"query attach:%@", query);

    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

-(NSMutableArray*) filterHDVBinhQuanFromDate:(NSString*)fromDate toDate:(NSString*)toDate{

    NSArray *allFields =[NSArray arrayWithObjects:BALANCE_QD, BUSSINESS_DATE, nil];

    NSString *query = [NSString stringWithFormat:@"select SUM(BALANCE_QD) as BALANCE_QD ,"  @"strftime('%%Y-%%m',BUSSINESS_DATE) as BUSSINESS_DATE from %@"
                       @" where BUSSINESS_DATE  between '%@' and '%@'"
                       @" group by strftime('%%Y-%%m', BUSSINESS_DATE)"
                       @" order by BUSSINESS_DATE asc",TABLENAME_DTORMMONTHLYHDV,fromDate,toDate];

    NSLog(@"query attach:%@", query);

    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

-(NSMutableArray*) filterDataTinDungDNTDFromDate:(NSString*)fromDate toDate:(NSString*)toDate{

    NSArray *allFields =[NSArray arrayWithObjects:BALANCE_QD, BUSSINESS_DATE, nil];

    NSString *query = [NSString stringWithFormat:@"select SUM(BALANCE_QD) as BALANCE_QD ,"  @"strftime('%%Y-%%m',BUSSINESS_DATE) as BUSSINESS_DATE from %@"
                       @" where BUSSINESS_DATE  between '%@' and '%@'"
                       @" group by strftime('%%Y-%%m', BUSSINESS_DATE)"
                       @" order by BUSSINESS_DATE asc",TABLENAME_DTORMDAILYTINDUNG,fromDate,toDate];

    NSLog(@"query attach:%@", query);

    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

-(NSMutableArray*) filterDataTinDungDNBQFromDate:(NSString*)fromDate toDate:(NSString*)toDate{

    NSArray *allFields =[NSArray arrayWithObjects:BALANCE_QD, BUSSINESS_DATE, nil];

    NSString *query = [NSString stringWithFormat:@"select SUM(BALANCE_QD) as BALANCE_QD ,"  @"strftime('%%Y-%%m',BUSSINESS_DATE) as BUSSINESS_DATE from %@"
                       @" where BUSSINESS_DATE  between '%@' and '%@'"
                       @" group by strftime('%%Y-%%m', BUSSINESS_DATE)"
                       @" order by BUSSINESS_DATE asc",TABLENAME_DTORMMONTHLYTINDUNG,fromDate,toDate];

    NSLog(@"query attach:%@", query);

    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}


@end
