//
//  MapsModel.m
//  OfficeOneMB
//
//  Created by Pham Ngoc Hoang on 12/20/14.
//
//

#import "MapsModel.h"
#import "NSDictionary+QS.h"

@implementation MapsModel

-(id)init{
    self = [super init];
    
    if(self){
        _listCustomer= [[NSMutableArray alloc] init];
        dtoLeadProcess = [DTOACCOUNTLEADProcess new];
    }
    return self;
}

-(void)getAllCustomer{
    [_listCustomer removeAllObjects];
    NSMutableArray *resultArr = [dtoLeadProcess filter];
    for (NSDictionary *dic in resultArr) {
        [_listCustomer addObject:[dic dtoAcountLeadProcessOb]];
    }
}

@end
