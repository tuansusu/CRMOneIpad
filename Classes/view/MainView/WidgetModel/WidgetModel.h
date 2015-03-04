//
//  WidgetModel.h
//  OfficeOneMB
//
//  Created by macpro on 3/2/15.
//
//

#import "BaseDataProcess.h"

#define BALANCE_QD @"BALANCE_QD"
#define BUSSINESS_DATE @"BUSSINESS_DATE"

@interface WidgetModel : BaseDataProcess


-(NSMutableArray*) filterHDVThoiDiemFromDate:(NSString*)fromDate toDate:(NSString*)toDate;
-(NSMutableArray*) filterHDVBinhQuanFromDate:(NSString*)fromDate toDate:(NSString*)toDate;

-(NSMutableArray*) filterDataTinDungDNTDFromDate:(NSString*)fromDate toDate:(NSString*)toDate;
-(NSMutableArray*) filterDataTinDungDNBQFromDate:(NSString*)fromDate toDate:(NSString*)toDate;

@end
