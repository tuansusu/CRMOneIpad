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
    data =[NSString stringWithFormat:@"[ {"
           @"name: 'Năm 2014',"
           @"data: [10, 32, 23, 36, 47, 65, 55, 39, 66, 100, 80, 22],"
           @"color:'rgb(%@)',"
           @"stack: '1'"
           @"},{"
           @"name: 'Năm 2015',"
           @"data: [10, 30, 20, 30, 40, 50, 60, 80, 70, 100, 90, 80],"
           @"color:'rgb(%@)',"
           @"stack: '2'"
           @"}]",_widgetOB.colorDisplay2,_widgetOB.colorDisplay1];

    types = @"['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12', ]";

    NSMutableString* jsStr = [[NSMutableString alloc] initWithCapacity:0];
    [jsStr appendFormat:@"updateData(%@,%@)",data,types];
    [wvChart stringByEvaluatingJavaScriptFromString:jsStr];
    /*
     if([_widgetOB.typeGraphically intValue]==typeGraphLine)
     {
     //        data = [NSString stringWithFormat:@"[{name: 'TMT01',data: [10, 30, 20, 30, 40, 50, 60, 80, 70, 100, 90, 80, ],color:'rgb(%@)' }]",_widgetOB.colorDisplay1];
     }else if([_widgetOB.typeGraphically intValue]==typeGraphColumnHorizontal)
     {
     }
     else
     if([_widgetOB.typeGraphically intValue]==typeGraphFunnel)
     {
     NSString *dataStr = @"[{"
     @"name: 'Số tiền',"
     @"data: ["
     @"['Tổng hợp',      40064],"
     @"['Huy động vốn',  15654],"
     @"['Tín dụng',      1987],"
     @"['Bảo lãnh',  976],"
     @"['Phát triển khách hàng',     846]"
     @"]"
     @"}]";

     NSLog(@"data : %@ ",dataStr);
     NSString *title = @"Widget Tổng hợp";
     NSMutableString* jsStr = [[NSMutableString alloc] initWithCapacity:0];
     [jsStr appendFormat:@"updateData(%@,\'%@\')",dataStr,title];

     [wvChart stringByEvaluatingJavaScriptFromString:jsStr];
     }
     */
}



@end
