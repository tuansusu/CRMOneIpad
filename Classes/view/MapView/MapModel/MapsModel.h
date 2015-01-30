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
    NSMutableDictionary *maneuverDic;
    NSURL *_directionsURL;
}

@property (nonatomic,readonly) NSMutableArray *listCustomerKHDM;
@property (nonatomic,readonly) NSMutableArray *listCustomerKH360;
@property (nonatomic,assign) NSInteger currentPageKHDM;
@property (nonatomic,assign) NSInteger currentPageKH360;

- (void)requestDirectionsQuery:(NSDictionary *)query success:(void (^)(id result))success
                       failure:(void (^)(NSError *error))failure;

-(void)getFirstPageCustomerKHDMWithKey:(NSString*)key;
-(void)getNextPageCustomerKHDMWithKey:(NSString*)key;

-(void)getFirstPageCustomerKH360WithKey:(NSString*)key;
-(void)getNextPageCustomerKH360WithKey:(NSString*)key;

@end
