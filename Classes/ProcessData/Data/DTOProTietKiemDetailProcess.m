//
//  DTOProTietKiemDetailProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProTietKiemDetailProcess.h"

#import "DataUtil.h"

#import "DTOProTietKiemDetailObject.h"

#import "Items.h"

#define TABLENAME_dtoProTietkiemDetail @"dtoProTietkiemDetail"

@implementation DTOProTietKiemDetailProcess

-(NSMutableArray*) filterProductDetailWithClientId:(NSString*)clientId WithProductCode:(NSString*)productCode{

    NSString *query = [NSString stringWithFormat:@"Select * from %@ where CLIENT_ID=%@ and PRODUCT_CODE=%@" ,TABLENAME_dtoProTietkiemDetail ,clientId,productCode];

    return [DataUtil BuilQueryGetListWithListFields:[DTOProTietKiemDetailObject allFields] selectQuery:query valueParameter:nil];
}
@end
