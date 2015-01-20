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
    return 1;
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

#pragma mark Table view Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    DTOProductLeadTypeObject *typeOB = [_listTypeProduct objectAtIndex:indexPath.section];
    NSLog(@"section : %@ , index : %d",typeOB.productTypeId,indexPath.row);
    if (_delegate && [_delegate respondsToSelector:@selector(selectedProductDetailAtIndex:)]) {
        [_delegate selectedProductDetailAtIndex:[typeOB.productTypeId integerValue]];
    }
}



#pragma mark ProTindungDetailViewController Delegate
- (void)closeProTindungDetailView:(ProTindungDetailViewController*)tinDungDetailVC{
    [tinDungDetailVC.view removeFromSuperview];
}

#pragma mark ProTheDetailViewController Delegate
- (void)closeProTheDetailView:(ProTheDetailViewController*)theDetailVC{
    [theDetailVC.view removeFromSuperview];
}

#pragma mark ProThanhToanQuocTeDetailViewController Delegate
- (void)closeThanhToanQuocTeDetailView:(ProThanhToanQuocTeDetailViewController*)ThanhToanQuocTeDetailVC{
    [ThanhToanQuocTeDetailVC.view removeFromSuperview];
}

#pragma mark ProTaiKhoanTietKiemDetailViewController Delegate
- (void)closeTaiKhoanTietKiemDetailView:(ProTaiKhoanTietKiemDetailViewController*)taiKhoanTietKiemDetailVC{
    [taiKhoanTietKiemDetailVC.view removeFromSuperview];
}

#pragma mark ProEMBDetailViewController Delegate
- (void)closeEMBDetailView:(ProEMBDetailViewController*)eMBDetailVC{
    [eMBDetailVC.view removeFromSuperview];
}

#pragma mark ProBankPlusDetailViewController Delegate
- (void)closeBankPlusDetailView:(ProBankPlusDetailViewController*)bankPlusDetailViewController{
    [bankPlusDetailViewController.view removeFromSuperview];
}

#pragma mark ProTaiKhoanThanhToanDetailViewController Delegate
- (void)closeProTaiKhoanThanhToanDetailView:(ProTaiKhoanThanhToanDetailViewController*)taiKhoanThanhToanDetailViewController{
    [taiKhoanThanhToanDetailViewController.view removeFromSuperview];
}

#pragma mark ProBaoLanhDetailViewController Delegate
- (void)closeProBaoLanhDetailView:(ProBaoLanhDetailViewController*)baoLanhDetailViewController{
    [baoLanhDetailViewController.view removeFromSuperview];
}

@end
