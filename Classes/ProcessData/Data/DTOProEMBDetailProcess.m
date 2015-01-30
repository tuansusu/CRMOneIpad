//
//  DTOProEMBDetailProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProEMBDetailProcess.h"

#import "DataUtil.h"

#import "DTOProEMBDetailObject.h"

#import "Items.h"

#define TABLENAME_dtoProEMBDetail @"dtoProEMBDetail"

@implementation DTOProEMBDetailProcess

-(NSMutableArray*) filterProductDetailWithClientId:(NSString*)clientId WithProductCode:(NSString*)productCode{

    NSString *query = [NSString stringWithFormat:@"Select * from %@ where CLIENT_ID=%@ and PRODUCT_CODE=%@",TABLENAME_dtoProEMBDetail ,clientId,productCode];

    return [DataUtil BuilQueryGetListWithListFields:[DTOProEMBDetailObject allFields] selectQuery:query valueParameter:nil];
}

@end
