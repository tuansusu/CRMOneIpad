//
//  DTOProThanhToanDetailProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProThanhToanDetailProcess.h"


#import "DataUtil.h"

#import "DTOProThanhToanDetailObject.h"

#import "Items.h"

#define TABLENAME_dtoProThanhtoanDetail @"dtoProThanhtoanDetail"

@implementation DTOProThanhToanDetailProcess

-(NSMutableArray*) filterProductDetailWithClientId:(NSString*)clientId WithProductCode:(NSString*)productCode{

    NSString *query = [NSString stringWithFormat:@"Select * from %@ where CLIENT_ID=%@ and PRODUCT_CODE=%@",TABLENAME_dtoProThanhtoanDetail ,clientId,productCode];

    return [DataUtil BuilQueryGetListWithListFields:[DTOProThanhToanDetailObject allFields] selectQuery:query valueParameter:nil];
}

@end
