//
//  ContentChartViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 1/11/15.
//
//

#import <UIKit/UIKit.h>

#import "Globals.h"

@class WidgetModel;

@class DTOWidgetObject;

@interface ContentChartViewCell : UIView<UIWebViewDelegate>
{
    IBOutlet UIWebView *wvChart;
    DTOWidgetObject *_widgetOB;
    WidgetModel *widgetModel;
    NSString *dataHDVThoiDiemStr;
    NSString *monthHDVThoiDiemStr;

    NSString *dataHDVBinhQuanStr;
    NSString *monthHDVBinhQuanStr;

    NSString *dataTinDungDuNoThoiDiemStr;
    NSString *monthTinDungNoThoiDiemStr;

    NSString *dataTinDungDuNoBinhQuanStr;
    NSString *monthTinDungNoBinhQuanStr;
}

-(void)initChartViewWithType:(TypeGraphs)typeGraph;

-(void)loadChartViewWithWidgetObject:(DTOWidgetObject*)widgetOB;

@end
