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
        _listCustomerKHDM= [[NSMutableArray alloc] init];
        dtoLeadProcess = [DTOACCOUNTLEADProcess new];

        dtoProcess = [DTOACCOUNTProcess new];
        _listCustomerKH360= [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)getAllCustomerKHDM{
    [_listCustomerKHDM removeAllObjects];
    NSMutableArray *resultArr = [dtoLeadProcess filter];
    for (NSDictionary *dic in resultArr) {
        [_listCustomerKHDM addObject:[dic dtoAcountLeadProcessOb]];
    }
}
-(void)getAllCustomerKH360{
    [_listCustomerKH360 removeAllObjects];
    NSMutableArray *resultArr = [dtoProcess filter];
    for (NSDictionary *dic in resultArr) {
        [_listCustomerKH360 addObject:[dic dtoAcountProcessOb]];
    }
}

@end
