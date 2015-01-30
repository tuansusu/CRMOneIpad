//
//  SubListMainView.h
//  OfficeOneMB
//
//  Created by macpro on 12/27/14.
//
//

#import <UIKit/UIKit.h>
#import "DTONOTEProcess.h"

@interface SubListMainView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    DTONOTEProcess *dtoNoteProcess;
    NSMutableArray *listNotes;
    IBOutlet UITableView *tbvListNotes;
}

-(void)initData;

@end
