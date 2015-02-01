//
//  SubListMainView.m
//  OfficeOneMB
//
//  Created by macpro on 12/27/14.
//
//

#import "SubListMainView.h"
#import "SubListViewCell.h"
#import "Globals.h"
#import "DTOWidgetObject.h"


@implementation SubListMainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)initDataWithWidgetObject:(DTOWidgetObject*)widgetOB{
    arrData = [[NSMutableArray alloc] init];
    _widgetOB = widgetOB;

    if ([widgetOB.widgetId intValue]==WIDGET_TYPE_TONG_HOP)
    {
        dtoNoteProcess = [DTONOTEProcess new];
        arrData = [dtoNoteProcess filterWithLimitRecord:MAX_ROW_A_PAGE_IN_DASHBOARD];

    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_GHI_CHU)
    {
        dtoNoteProcess = [DTONOTEProcess new];
        arrData = [dtoNoteProcess filterWithLimitRecord:MAX_ROW_A_PAGE_IN_DASHBOARD];

    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_TKH_TIEN_GUI)
    {
         dtoProductDetailProcess = [DTOPRODUCTDETAILProcess new];
        arrData = [dtoProductDetailProcess filterTopKHWithType:[NSString stringWithFormat:@"type=%d or type=%d",PRODUCT_TYPE_THANH_TOAN,PRODUCT_TYPE_TIET_KIEM] WithLimitRecord:MAX_ROW_A_PAGE_IN_DASHBOARD];

    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_TKH_TIN_DUNG)
    {
        dtoProductDetailProcess = [DTOPRODUCTDETAILProcess new];
        arrData = [dtoProductDetailProcess filterTopKHWithType:[NSString stringWithFormat:@"type=%d",PRODUCT_TYPE_TIN_DUNG] WithLimitRecord:MAX_ROW_A_PAGE_IN_DASHBOARD];

    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_Y_KIEN_KH)
    {
        dtoComplainProcess = [DTOComplainProcess new];
        arrData = [dtoComplainProcess filterWithLimitRecord:MAX_ROW_A_PAGE_IN_DASHBOARD];

    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_THEO_DOI)
    {
        dtoNoteProcess = [DTONOTEProcess new];
        arrData = [dtoNoteProcess filterWithLimitRecord:MAX_ROW_A_PAGE_IN_DASHBOARD];

    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_SU_KIEN_SAP_DIEN_RA)
    {
        dtoNoteProcess = [DTONOTEProcess new];
        arrData = [dtoNoteProcess filterWithLimitRecord:MAX_ROW_A_PAGE_IN_DASHBOARD];
    }
    [tbvListNotes reloadData];

}

-(IBAction)btnSelected:(id)sender{
    
}



#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"SubListViewCell";
    SubListViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];

    if (!cell) {
        cell = [SubListViewCell initNibCell];
        [cell loadDataToCellWithData:[arrData objectAtIndex:indexPath.row] WithWidgetObject:_widgetOB];
    }
    return cell;
}


@end
