//
//  DashboardTaskModel.h
//  OfficeOneMB
//
//  Created by macpro on 1/29/15.
//
//

#import <Foundation/Foundation.h>

#import "DTOTASKProcess.h"

#import "NSDictionary+QS.h"

@interface DashboardTaskModel : NSObject
{
    DTOTASKProcess *dtoProcess;
}

@property (nonatomic,readonly) NSMutableArray *listData;
@property (nonatomic,assign) NSInteger currentPage;

-(NSMutableArray*)getAllComplain;

-(void)getFirstPageWithKey:(NSString*)key;

-(void)getNextPageWithKey:(NSString*)key;

-(BOOL)updateComplainWithComplainOB:(DTOComplainObject*)complainOB;

-(BOOL) deleteComplainWithCasesId:(NSString *)casesId;

@end
