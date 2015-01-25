//
//  DTOProWay4DetailProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProWay4DetailProcess.h"
#import "DataUtil.h"

#import "DTOProWay4DetailObject.h"

#import "Items.h"

#define TABLENAME_dtoProWay4Detail @"dtoProWay4Detail"

@implementation DTOProWay4DetailProcess

-(NSMutableArray*) filterProductDetailWithClientId:(NSString*)clientId WithProductCode:(NSString*)productCode{

    NSString *query = [NSString stringWithFormat:@"Select * from %@ where CLIENT_ID=%@ and PRODUCT_CODE=%@ and STATUS=1",TABLENAME_dtoProWay4Detail ,clientId,productCode];

    return [DataUtil BuilQueryGetListWithListFields:[DTOProWay4DetailObject allFields] selectQuery:query valueParameter:nil];
}

@end
