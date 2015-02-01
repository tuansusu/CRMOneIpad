//
//  SubListMainView.h
//  OfficeOneMB
//
//  Created by macpro on 12/27/14.
//
//

#import <UIKit/UIKit.h>
#import "DTONOTEProcess.h"
#import "DTOComplainProcess.h"
#import "DTOPRODUCTDETAILProcess.h"

@class DTOWidgetObject;

@interface SubListMainView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    DTONOTEProcess *dtoNoteProcess;
    DTOComplainProcess *dtoComplainProcess;
    DTOPRODUCTDETAILProcess *dtoProductDetailProcess;

    NSMutableArray *arrData;
    IBOutlet UITableView *tbvListNotes;
    DTOWidgetObject *_widgetOB;
}

-(void)initDataWithWidgetObject:(DTOWidgetObject*)widgetOB;

@end
