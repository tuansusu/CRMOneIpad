//
//  MapsModel.h
//  OfficeOneMB
//
//  Created by Pham Ngoc Hoang on 12/20/14.
//
//

#import <Foundation/Foundation.h>

#import "DTOACCOUNTLEADProcess.h"
#import "DTOACCOUNTProcess.h"

@interface MapsModel : NSObject
{
    DTOACCOUNTLEADProcess *dtoLeadProcess;
    DTOACCOUNTProcess *dtoProcess;
}

@property (nonatomic,readonly) NSMutableArray *listCustomerKHDM;
@property (nonatomic,readonly) NSMutableArray *listCustomerKH360;

-(void)getAllCustomerKHDM;
-(void)getAllCustomerKH360;

@end
