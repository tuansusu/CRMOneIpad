//
//  ContentChartViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 1/11/15.
//
//

#import "ContentChartViewCell.h"
#import "DTOWidgetObject.h"
#import "Globals.h"
#import "WidgetModel.h"
@implementation ContentChartViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:nil options:nil] objectAtIndex:0];
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


-(void)initChartViewWithType:(TypeGraphs)typeGraph{
    [self releaseDataWebview];
    CGRect webFrame = self.frame;
    webFrame.origin.x = 0;
    webFrame.origin.y =  0;
    // load Line Chart Total Sale
    //    webViewForSelectDate = [[UIWebView alloc] initWithFrame:webFrame];
    wvChart.delegate = self;
    wvChart.scalesPageToFit = NO;
    [wvChart.scrollView setScrollEnabled:NO];
    wvChart.opaque = NO;
    wvChart.backgroundColor = [UIColor clearColor];
    wvChart.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

    if (typeGraph == typeGraphLine) {
        [self loadLineChart];
    }else if (typeGraph == typeGraphColumnVertical) {
        [self loadColumnVerticalChartView];
    }else if (typeGraph == typeGraphColumnHorizontal) {
        [self loadColumnHorizontalChartView];
    }else if (typeGraph == typeGraphFunnel) {
        [self loadFunnelChart];
    }
}

-(void)loadChartViewWithWidgetObject:(DTOWidgetObject*)widgetOB{
    _widgetOB = widgetOB;

    widgetModel = [[WidgetModel alloc] init];

    [self releaseDataWebview];

    if ([widgetOB.typeGraphically intValue] == typeGraphLine) {
        [self loadLineChart];
    }else if ([widgetOB.typeGraphically intValue] == typeGraphColumnVertical) {
        [self loadColumnVerticalChartView];
    }else if ([widgetOB.typeGraphically intValue] == typeGraphColumnHorizontal) {
        [self loadColumnHorizontalChartView];
    }else if ([widgetOB.typeGraphically intValue] == typeGraphFunnel) {
        [self loadFunnelChart];
    }
}

-(void)releaseDataWebview{

    NSURLCredentialStorage *credentialsStorage = [NSURLCredentialStorage sharedCredentialStorage];
    NSDictionary *allCredentials = [credentialsStorage allCredentials];
    for (NSURLProtectionSpace *protectionSpace in allCredentials) {
        NSDictionary *credentials = [credentialsStorage credentialsForProtectionSpace:protectionSpace];
        for (NSString *credentialKey in credentials) {
            [credentialsStorage removeCredential:[credentials objectForKey:credentialKey] forProtectionSpace:protectionSpace];
        }
    }
}

-(void)loadFunnelChart{
    [wvChart.scrollView setScrollEnabled:NO];
    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/examples/funnel/index.htm"];

    NSURL* url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];

    [wvChart loadRequest:request];

}

-(void)loadLineChart{
    [wvChart.scrollView setScrollEnabled:NO];
    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/examples/line-time-series/lineChart.htm"];

    NSURL* url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [wvChart loadRequest:request];

}


-(void)loadColumnVerticalChartView{
    [wvChart.scrollView setScrollEnabled:NO];
    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/examples/column-parsed/columnVertical.htm"];
    NSURL* url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [wvChart loadRequest:request];

}

-(void)loadColumnHorizontalChartView{
    [wvChart.scrollView setScrollEnabled:NO];
    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/examples/column-parsed/columnHorizontal.htm"];
    NSURL* url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [wvChart loadRequest:request];

}



#pragma mark - delegate of webview
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    [self updateData];

}
-(void)updateData
{

    NSString *data = @"";
    NSString *types =@"";

    // init data widget
    [self initData];

    if ([_widgetOB.widgetId intValue]==WIDGET_TYPE_HUY_DONG_VON) {


        data =[NSString stringWithFormat:@"[ {"
               @"name: 'HĐV Thời Điểm',"
               @"data: [%@],"
               @"color:'rgb(%@)',"
               @"stack: '1'"
               @"},{"
               @"name: 'HĐV Bình Quân',"
               @"data: [%@],"
               @"color:'rgb(%@)',"
               @"stack: '2'"
               @"}]",dataHDVThoiDiemStr, _widgetOB.colorDisplay2, dataHDVBinhQuanStr,_widgetOB.colorDisplay1];

        types = [NSString stringWithFormat:@"[%@]",monthHDVBinhQuanStr];

        NSMutableString* jsStr = [[NSMutableString alloc] initWithCapacity:0];
        [jsStr appendFormat:@"updateData(%@,%@)",data,types];
        [wvChart stringByEvaluatingJavaScriptFromString:jsStr];
    }
    else if ([_widgetOB.widgetId intValue]==WIDGET_TYPE_TIN_DUNG)
    {
        data =[NSString stringWithFormat:@"[ {"
               @"name: 'Dư nợ thời điểm',"
               @"data: [%@],"
               @"color:'rgb(%@)',"
               @"stack: '1'"
               @"},{"
               @"name: 'Dư nợ bình quân',"
               @"data: [%@],"
               @"color:'rgb(%@)',"
               @"stack: '2'"
               @"}]",dataTinDungDuNoThoiDiemStr,_widgetOB.colorDisplay2,dataTinDungDuNoBinhQuanStr,_widgetOB.colorDisplay1];
        types = [NSString stringWithFormat:@"[%@]",monthTinDungNoThoiDiemStr];

        NSMutableString* jsStr = [[NSMutableString alloc] initWithCapacity:0];
        [jsStr appendFormat:@"updateData(%@,%@)",data,types];
        [wvChart stringByEvaluatingJavaScriptFromString:jsStr];
    }

}


-(void)initData
{
    dataHDVThoiDiemStr  = @"";
    monthHDVThoiDiemStr = @"";

    dataHDVBinhQuanStr  = @"";
    monthHDVBinhQuanStr = @"";

    dataTinDungDuNoThoiDiemStr  = @"";
    monthTinDungNoThoiDiemStr = @"";

    dataTinDungDuNoBinhQuanStr  = @"";
    monthTinDungNoBinhQuanStr = @"";
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *currentDateCom = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];

    NSString *startDateLastMonthOfPreviousYear = [NSString stringWithFormat:@"%ld-12-01",(long)[currentDateCom year]-1];

    NSString *endDateLastMonthOfPreviousYear = [NSString stringWithFormat:@"%ld-12-31",(long)[currentDateCom year]-1];
    if ([_widgetOB.widgetId intValue]==WIDGET_TYPE_HUY_DONG_VON) {

        // lấy dữ liệu HDVTD thời điểm cuối năm trước (tháng cuối)
        [self getDataOfHDVTDFromDate:startDateLastMonthOfPreviousYear ToDate:endDateLastMonthOfPreviousYear];
        monthHDVThoiDiemStr = [monthHDVThoiDiemStr stringByAppendingString:[NSString stringWithFormat:@"'%@',",[NSString stringWithFormat:@"12-%ld",(long)[currentDateCom year]-1]]];

        // lấy dữ liệu HDVTD bình quân cuối năm trước (tháng cuối)
        [self getDataOfHDVBinhQuanFromDate:startDateLastMonthOfPreviousYear ToDate:endDateLastMonthOfPreviousYear];
        monthHDVBinhQuanStr = [monthHDVBinhQuanStr stringByAppendingString:[NSString stringWithFormat:@"'%@',",[NSString stringWithFormat:@"12-%ld",(long)[currentDateCom year]-1]]];
    }
    else if ([_widgetOB.widgetId intValue]==WIDGET_TYPE_TIN_DUNG)
    {
        // lấy dữ liệu tín dụng dư nợ thời điểm cuối năm trước (tháng cuối)
        [self getDataOfTinDungDNTDFromDate:startDateLastMonthOfPreviousYear ToDate:endDateLastMonthOfPreviousYear];
        monthTinDungNoThoiDiemStr = [monthTinDungNoThoiDiemStr stringByAppendingString:[NSString stringWithFormat:@"'%@',",[NSString stringWithFormat:@"12-%ld",(long)[currentDateCom year]-1]]];

        // lấy dữ liệu tín dụng dư nợ bình quân cuối năm trước (tháng cuối)
        [self getDataOfTinDungDNBinhQuanFromDate:startDateLastMonthOfPreviousYear ToDate:endDateLastMonthOfPreviousYear];
        monthTinDungNoBinhQuanStr = [monthTinDungNoBinhQuanStr stringByAppendingString:[NSString stringWithFormat:@"'%@',",[NSString stringWithFormat:@"12-%ld",(long)[currentDateCom year]-1]]];
    }


    for (int month = 1; month <= [currentDateCom month]; month++)
    {
        NSString *monthStr ;
        if (month<10) {
            monthStr = [NSString stringWithFormat:@"0%d",month];
        }else{
            monthStr = [NSString stringWithFormat:@"%d",month];
        }

        NSString *startDateOfMonth = [NSString stringWithFormat:@"%ld-%@-01",(long)[currentDateCom year],monthStr];

        NSString *endDateOfMonth = [NSString stringWithFormat:@"%ld-%@-31",(long)[currentDateCom year],monthStr];

        NSLog(@"start Date : %@ - End Date : %@", startDateOfMonth,endDateOfMonth);

        if ([_widgetOB.widgetId intValue]==WIDGET_TYPE_HUY_DONG_VON) {

            // lấy dữ liệu HDVTD từ đầu năm đến tháng hiện tại
            [self getDataOfHDVTDFromDate:startDateOfMonth ToDate:endDateOfMonth];
            monthHDVThoiDiemStr = [monthHDVThoiDiemStr stringByAppendingString:[NSString stringWithFormat:@"'%@',",[NSString stringWithFormat:@"%@-%ld",monthStr,(long)[currentDateCom year]]]];

            // lấy dữ liệu HDV Binh Quan từ đầu năm đến tháng hiện tại
            [self getDataOfHDVBinhQuanFromDate:startDateOfMonth ToDate:endDateOfMonth];
            monthHDVBinhQuanStr = [monthHDVBinhQuanStr stringByAppendingString:[NSString stringWithFormat:@"'%@',",[NSString stringWithFormat:@"%@-%ld",monthStr,(long)[currentDateCom year]]]];
        }
        else if ([_widgetOB.widgetId intValue]==WIDGET_TYPE_TIN_DUNG) {

            // lấy dữ liệu tín dụng dư nợ thời điểm từ đầu năm đến tháng hiện tại
            [self getDataOfTinDungDNTDFromDate:startDateOfMonth ToDate:endDateOfMonth];
            monthTinDungNoThoiDiemStr = [monthTinDungNoThoiDiemStr stringByAppendingString:[NSString stringWithFormat:@"'%@',",[NSString stringWithFormat:@"%@-%ld",monthStr,(long)[currentDateCom year]]]];

            // lấy dữ liệu tín dụng dư nợ Binh Quan từ đầu năm đến tháng hiện tại
            [self getDataOfTinDungDNBinhQuanFromDate:startDateOfMonth ToDate:endDateOfMonth];
            monthTinDungNoBinhQuanStr = [monthTinDungNoBinhQuanStr stringByAppendingString:[NSString stringWithFormat:@"'%@',",[NSString stringWithFormat:@"%@-%ld",monthStr,(long)[currentDateCom year]]]];
        }
    }

}

#pragma mark lấy dữ liệu huy động vốn thời điểm
-(void)getDataOfHDVTDFromDate:(NSString*)fromDate ToDate:(NSString*)toDate
{
    NSMutableArray *resultDic = [widgetModel filterHDVThoiDiemFromDate:fromDate toDate:toDate];
    if (resultDic.count>0) {
        for (NSDictionary *dataDic in resultDic) {
            if ([dataDic valueForKey:BALANCE_QD] && [dataDic valueForKey:BUSSINESS_DATE]) {
                dataHDVThoiDiemStr = [dataHDVThoiDiemStr stringByAppendingString:[NSString stringWithFormat:@"%@,",[dataDic valueForKey:BALANCE_QD]]];
            }
        }
    }else{
        dataHDVThoiDiemStr = [dataHDVThoiDiemStr stringByAppendingString:[NSString stringWithFormat:@"0,"]];
    }
}


#pragma mark lấy dữ liệu huy động vốn bình quân

-(void)getDataOfHDVBinhQuanFromDate:(NSString*)fromDate ToDate:(NSString*)toDate
{
    NSMutableArray *resultDic = [widgetModel filterHDVBinhQuanFromDate:fromDate toDate:toDate];
    if (resultDic.count>0) {
        for (NSDictionary *dataDic in resultDic) {
            if ([dataDic valueForKey:BALANCE_QD] && [dataDic valueForKey:BUSSINESS_DATE]) {
                dataHDVBinhQuanStr = [dataHDVBinhQuanStr stringByAppendingString:[NSString stringWithFormat:@"%@,",[dataDic valueForKey:BALANCE_QD]]];
            }
        }
    }else{
        dataHDVBinhQuanStr = [dataHDVBinhQuanStr stringByAppendingString:[NSString stringWithFormat:@"0,"]];
    }
}

#pragma mark lấy dữ liệu tín dụng Dư nợ thời điểm
-(void)getDataOfTinDungDNTDFromDate:(NSString*)fromDate ToDate:(NSString*)toDate
{
    NSMutableArray *resultDic = [widgetModel filterDataTinDungDNTDFromDate:fromDate toDate:toDate];
    if (resultDic.count>0) {
        for (NSDictionary *dataDic in resultDic) {
            if ([dataDic valueForKey:BALANCE_QD] && [dataDic valueForKey:BUSSINESS_DATE]) {
                dataTinDungDuNoThoiDiemStr = [dataTinDungDuNoThoiDiemStr stringByAppendingString:[NSString stringWithFormat:@"%@,",[dataDic valueForKey:BALANCE_QD]]];
            }
        }
    }else{
        dataTinDungDuNoThoiDiemStr = [dataTinDungDuNoThoiDiemStr stringByAppendingString:[NSString stringWithFormat:@"0,"]];
    }
}


#pragma mark lấy dữ liệu tín dụng Dư nợ bình quân

-(void)getDataOfTinDungDNBinhQuanFromDate:(NSString*)fromDate ToDate:(NSString*)toDate
{
    NSMutableArray *resultDic = [widgetModel filterDataTinDungDNBQFromDate:fromDate toDate:toDate];
    if (resultDic.count>0) {
        for (NSDictionary *dataDic in resultDic) {
            if ([dataDic valueForKey:BALANCE_QD] && [dataDic valueForKey:BUSSINESS_DATE]) {
                dataTinDungDuNoBinhQuanStr = [dataTinDungDuNoBinhQuanStr stringByAppendingString:[NSString stringWithFormat:@"%@,",[dataDic valueForKey:BALANCE_QD]]];
            }
        }
    }else{
        dataTinDungDuNoBinhQuanStr = [dataTinDungDuNoBinhQuanStr stringByAppendingString:[NSString stringWithFormat:@"0,"]];
    }
}



@end
