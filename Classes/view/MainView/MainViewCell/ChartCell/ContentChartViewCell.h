//
//  ContentChartViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 1/11/15.
//
//

#import <UIKit/UIKit.h>

#import "Globals.h"

#define TEXT_HDVTD @"HĐV Thời Điểm"
#define TEXT_HDVBQ @"HĐV Bình Quân"

#define TEXT_DNTD @"Dư nợ thời điểm"
#define TEXT_DNBQ @"Dư nợ bình quân"

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
