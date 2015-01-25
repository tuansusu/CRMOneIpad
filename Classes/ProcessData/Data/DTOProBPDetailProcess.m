//
//  DTOProBPDetailProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProBPDetailProcess.h"

#import "DataUtil.h"

#import "DTOProBPDetailObject.h"

#import "Items.h"

#define TABLENAME_dtoProBPDetail @"dtoProBPDetail"

@implementation DTOProBPDetailProcess

-(NSMutableArray*) filterProductDetailWithClientId:(NSString*)clientId WithProductCode:(NSString*)productCode{

    NSString *query = [NSString stringWithFormat:@"Select * from %@ where CLIENT_ID=%@ and PRODUCT_CODE=%@ and STATUS=1",TABLENAME_dtoProBPDetail ,clientId,productCode];

    return [DataUtil BuilQueryGetListWithListFields:[DTOProBPDetailObject allFields] selectQuery:query valueParameter:nil];
}

@end
