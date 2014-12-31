//
//  ProductsView.m
//  OfficeOneMB
//
//  Created by macpro on 12/31/14.
//
//

#import "ProductsLeadView.h"
#import "NSDictionary+QS.h"
#import "ProductLeadCellHeader.h"
#import "ProductLeadViewCell.h"
#import "DTOProductLeadTypeObject.h"

@implementation ProductsLeadView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)initDataWithLeaderId:(NSString*)leadId{
    _leadId = leadId;
    _listTypeProduct = [[NSMutableArray alloc] init];
    [_listTypeProduct removeAllObjects];
    dtoProductType = [DTOPRODUCTTYPEProcess new];
    NSMutableArray *listProductType = [dtoProductType filter];
    if (listProductType.count>0) {
        for (NSDictionary *dic in listProductType) {
            [_listTypeProduct addObject:[dic dtoProductLeadTypeObject]];
        }
    }

    dtoProductMaster = [DTOPRODUCTMASTERProcess new];
    [tbvProductsLead reloadData];
}

#pragma mark - Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return _listTypeProduct.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ProductLeadCellHeader *header = [[ProductLeadCellHeader alloc] init];
    DTOProductLeadTypeObject *typeOB = [_listTypeProduct objectAtIndex:section];
    [header loadViewWithTittle:typeOB.name];

    return header;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    DTOProductLeadTypeObject *typeOB = [_listTypeProduct objectAtIndex:section];
//    NSMutableArray *resultArr = [dtoProductMaster filter];
//    if (resultArr.count>0) {
//        for (NSDictionary *dic in resultArr) {
//            //            [arrayData addObject:[dic dtoAcountLeadProcessOb]];
//
//        }
//    }
//    [tbvProductsLead reloadData];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"ProductLeadViewCell";
    ProductLeadViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ProductLeadViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];

        //        UICGRoute *routesOB = [_listRoutes objectAtIndex:indexPath.section];
        //        UICGStep *stepOB = [routesOB.steps objectAtIndex:indexPath.row];
        //        [cell loadDataCellWithStepOB:stepOB];
    }
    return cell;
}

@end
