//
//  ContentChartViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 1/11/15.
//
//

#import "ContentChartViewCell.h"

@implementation ContentChartViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)loadChartView{

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

//    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/examples/funnel/index.htm"];
    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/examples/funnel/index.htm"];

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



@end
