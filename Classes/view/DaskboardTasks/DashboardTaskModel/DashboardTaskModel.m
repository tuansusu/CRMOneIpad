//
//  DashboardTaskModel.m
//  OfficeOneMB
//
//  Created by macpro on 1/29/15.
//
//

#import "DashboardTaskModel.h"
#import "Globals.h"

@implementation DashboardTaskModel
-(id)init{
    self = [super init];

    if(self){
        _listData= [[NSMutableArray alloc] init];
        dtoProcess = [DTOTASKProcess new];
    }
    return self;
}

-(NSMutableArray*)getAllComplain{
    NSString *accountID=@"";//lấy account ID lúc login
    return  [dtoProcess filterTaskWithAccountId:accountID WithKey:DTOTASK_title withValue:@""];
}

-(void)getFirstPageWithKey:(NSString*)key{
    NSString *accountID=@"";//lấy account ID lúc login
    [_listData removeAllObjects];
    _currentPage =1;
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];

    if ([key isEqualToString:@""]) {
        resultArr = [dtoProcess filterTaskWithAccountId:accountID WithKey:DTOTASK_title withValue:@""];
    }else{
        resultArr = [dtoProcess filterTaskWithAccountId:accountID WithKey:DTOTASK_title withValue:key];
    }

    if (resultArr.count>MAX_ROW_A_PAGE) {
        for (int i=0;i<MAX_ROW_A_PAGE;i++) {
            NSDictionary *dic = [resultArr objectAtIndex:i];
            [_listData addObject:dic];
        }
    }else{
        for (NSDictionary *dic in resultArr) {
            [_listData addObject:dic];
        }
    }

}
-(void)getNextPageWithKey:(NSString*)key{
    {
        NSString *accountID=@"";//lấy account ID lúc login
        int currentPage = _currentPage;
        int nextPage = ++_currentPage;

        NSMutableArray *resultArr = [[NSMutableArray alloc] init];

        if ([key isEqualToString:@""]) {
            resultArr = [dtoProcess filterTaskWithAccountId:accountID WithKey:DTOTASK_title withValue:@""];
        }else{
            resultArr = [dtoProcess filterTaskWithAccountId:accountID WithKey:DTOTASK_title withValue:key];
        }

        NSInteger totalPage =resultArr.count/MAX_ROW_A_PAGE;
        if (totalPage>currentPage) {
            for (int i=MAX_ROW_A_PAGE*currentPage;i<MAX_ROW_A_PAGE*nextPage;i++) {
                NSDictionary *dic = [resultArr objectAtIndex:i];
                [_listData addObject:dic];
            }
        }else {
            if((resultArr.count - currentPage*MAX_ROW_A_PAGE)>0){
                for (int i=MAX_ROW_A_PAGE*currentPage;i<resultArr.count;i++) {
                    NSDictionary *dic = [resultArr objectAtIndex:i];
                    [_listData addObject:dic];
                }
            }else{
                return;
            }
        }
    }
}
@end
