//
//  ContentChartViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 1/11/15.
//
//

#import <UIKit/UIKit.h>

#import "Globals.h"
@class DTOWidgetObject;

@interface ContentChartViewCell : UIView<UIWebViewDelegate>
{
    IBOutlet UIWebView *wvChart;
    DTOWidgetObject *_widgetOB;
}

-(void)initChartViewWithType:(TypeGraphs)typeGraph;

-(void)loadChartViewWithWidgetObject:(DTOWidgetObject*)widgetOB;

@end
