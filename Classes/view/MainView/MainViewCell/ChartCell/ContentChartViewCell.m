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

    }else if (typeGraph == typeGraphFunnel) {
        [self loadFunnelChart];
    }
}

-(void)loadChartViewWithWidgetObject:(DTOWidgetObject*)widgetOB{
    _widgetOB = widgetOB;
    if ([widgetOB.typeGraphically intValue] == typeGraphLine) {
        [self loadLineChart];
    }else if ([widgetOB.typeGraphically intValue] == typeGraphColumnVertical) {
        [self loadColumnVerticalChartView];
    }else if ([widgetOB.typeGraphically intValue] == typeGraphColumnHorizontal) {

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
    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/examples/column-parsed/CashFlowChart.htm"];
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
    if([_widgetOB.typeGraphically intValue]==typeGraphLine)
    {
        NSString *data = @"";
        NSString *types =@"";

        data = [NSString stringWithFormat:@"[{name: 'TMT01',data: [10, 30, 20, 30, 40, 50, 60, 80, 70, 100, 90, 80, ],color:'rgb(%@)' }]",_widgetOB.colorDisplay1];
        types = @"['Jan 15', 'Feb 15', 'Mar 15', 'Apr 15', 'May 15', 'Jun 15', 'Jul 15', 'Aug 15', 'Sep 15', 'Oct 15', 'Nov 15', 'Dec 15', ]";
           NSMutableString* jsStr = [[NSMutableString alloc] initWithCapacity:0];

        [jsStr appendFormat:@"updateData(%@,%@)",data,types];

        [wvChart stringByEvaluatingJavaScriptFromString:jsStr];
    }else if([_widgetOB.typeGraphically intValue]==typeGraphColumnVertical)
    {
        NSString *data =[NSString stringWithFormat:@"[ {"
                         @"name: 'Total Expense',"
                         @"data: [10, 30, 20, 30, 40, 50, 60, 80, 70, 100, 90, 80],"
                         @"color:'rgb(%@)',"
                         @"stack: '1'"
                         @"},{"
                         @"name: 'Total Income',"
                         @"data: [10, 30, 20, 30, 40, 50, 60, 80, 70, 100, 90, 80],"
                         @"color:'rgb(%@)',"
                         @"stack: '2'"
                         @"}]",_widgetOB.colorDisplay1,_widgetOB.colorDisplay2];

        NSString *types =[NSString stringWithFormat:@"['Jan 15', 'Feb 15', 'Mar 15', 'Apr 15', 'May 15', 'Jun 15', 'Jul 15', 'Aug 15', 'Sep 15', 'Oct 15', 'Nov 15', 'Dec 15', ]"];

        NSLog(@"data : %@ \n types : %@",data,types);
        NSMutableString* jsStr = [[NSMutableString alloc] initWithCapacity:0];
        [jsStr appendFormat:@"updateData(%@,%@)",data,types];

        [wvChart stringByEvaluatingJavaScriptFromString:jsStr];
    }else if([_widgetOB.typeGraphically intValue]==typeGraphColumnHorizontal)
    {

    }
    else if([_widgetOB.typeGraphically intValue]==typeGraphFunnel)
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
}



@end
