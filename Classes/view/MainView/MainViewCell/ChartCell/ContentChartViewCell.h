//
//  ContentChartViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 1/11/15.
//
//

#import <UIKit/UIKit.h>

@interface ContentChartViewCell : UIView<UIWebViewDelegate>
{
    IBOutlet UIWebView *wvChart;
}

-(void)loadChartView;

@end
