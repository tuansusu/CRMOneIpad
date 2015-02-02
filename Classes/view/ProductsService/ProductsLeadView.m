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
#import "Globals.h"


@implementation ProductsLeadView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)initDataWithLeaderId:(NSString*)leadId{

    dtoProductMaster = [DTOPRODUCTMASTERProcess new];
    dtoProductType = [DTOPRODUCTTYPEProcess new];
    dtoProductDetail = [DTOPRODUCTDETAILProcess new];

    _leadId = leadId;
    _listTypeProduct = [[NSMutableArray alloc] init];
    [_listTypeProduct removeAllObjects];

    NSMutableArray *listProductType = [dtoProductType filter];
    if (listProductType.count>0) {
        for (NSDictionary *dic in listProductType) {
            [_listTypeProduct addObject:[dic dtoProductLeadTypeObject]];
        }
    }

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
    NSMutableArray *resultArr = [dtoProductDetail filterProductWithLeadId:_leadId WithTypeId:typeOB.productTypeId];
    double totalBalanceQD =0;
    for (NSDictionary *productDetailDic in resultArr) {
        DTOProductDetailObject *productDetailOB = [productDetailDic dtoProductDetailObject];
        totalBalanceQD += [productDetailOB.balanceQD doubleValue];
    }
    [header loadViewWithTittle:typeOB.name WithTotalBalanceQD:totalBalanceQD];

    return header;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DTOProductLeadTypeObject *typeOB = [_listTypeProduct objectAtIndex:section];
    NSMutableArray *resultArr = [dtoProductDetail filterProductWithLeadId:_leadId WithTypeId:typeOB.productTypeId];
    if (resultArr.count>0) {
        return resultArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTOProductLeadTypeObject *typeOB = [_listTypeProduct objectAtIndex:indexPath.section];
    NSMutableArray *resultArr = [dtoProductDetail filterProductWithLeadId:_leadId WithTypeId:typeOB.productTypeId];
    if (resultArr.count>0) {
        static NSString *cellId = @"ProductLeadViewCell";
        ProductLeadViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[ProductLeadViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];

            NSDictionary *productDetailDic =[resultArr objectAtIndex:indexPath.row];
            DTOProductDetailObject *productDetailOB = [productDetailDic dtoProductDetailObject];
            [cell loadDataCellWithProductDetail:productDetailOB];
        }
        return cell;
    }

    static NSString *cellId = @"ProductLeadViewCell";
    ProductLeadViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ProductLeadViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}
//thêm cái line đến tận left margin
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark Table view Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTOProductLeadTypeObject *typeOB = [_listTypeProduct objectAtIndex:indexPath.section];
    NSMutableArray *resultArr = [dtoProductDetail filterProductWithLeadId:_leadId WithTypeId:typeOB.productTypeId];
     if (resultArr.count>0) {
         NSDictionary *productDetailDic =[resultArr objectAtIndex:indexPath.row];
         DTOProductDetailObject *productDetailOB = [productDetailDic dtoProductDetailObject];
         NSLog(@"section : %@ , index : %d",typeOB.productTypeId,indexPath.row);
         if (_delegate && [_delegate respondsToSelector:@selector(selectedProductDetailWithProductDetailObject:)]) {
             [_delegate selectedProductDetailWithProductDetailObject:productDetailOB];
         }
     }

}


@end
