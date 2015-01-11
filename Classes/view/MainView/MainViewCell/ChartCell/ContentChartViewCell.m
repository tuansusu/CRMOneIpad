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
    @"name: 'Unique users',"
    @"data: ["
           @"['Website visits',   15654],"
           @"['Downloads',       4064],"
           @"['Requested price list', 1987],"
           @"['Invoice sent',    976],"
           @"['Finalized',    846]"
           @"]"
    @"}]";
//    NSString *data =[NSString stringWithFormat:@"[ {"
//                     @"name: 'Total Expense',"
//                     @"data: [100, 70,],"
//                     @"stack: '1'"
//                     @"},{"
//                     @"name: 'Total Income',"
//                     @"data: [200, 30,],"
//                     @"stack: '2'"
//                     @"}]"];
//    NSString *types =[NSString stringWithFormat:@"['Nov/13','Jan/14',]"];


    NSLog(@"data : %@ ",dataStr);
    NSString *title = @"Cash Flow Chart";
    NSMutableString* jsStr = [[NSMutableString alloc] initWithCapacity:0];
    [jsStr appendFormat:@"updateData(\"%@\")",title];


    [wvChart stringByEvaluatingJavaScriptFromString:jsStr];
}



@end
