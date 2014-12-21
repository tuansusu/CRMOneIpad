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
#define MAX_ROW_A_PAGE 20

@interface MapsModel : NSObject
{
    DTOACCOUNTLEADProcess *dtoLeadProcess;
    DTOACCOUNTProcess *dtoProcess;
}

@property (nonatomic,readonly) NSMutableArray *listCustomerKHDM;
@property (nonatomic,readonly) NSMutableArray *listCustomerKH360;
@property (nonatomic,assign) NSInteger currentPageKHDM;
@property (nonatomic,assign) NSInteger currentPageKH360;

-(void)getFirstPageCustomerKHDM;
-(void)getNextPageCustomerKHDM;

-(void)getFirstPageCustomerKH360;
-(void)getNextPageCustomerKH360;

@end
