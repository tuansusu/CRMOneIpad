//
//  EditNoteLeadViewController.h
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/11/14.
//
//

#import "BaseViewController.h"

#import "SelectIndexViewController.h"
#import "CMPopTipView.h"

@interface EditNote360ViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate, UIImagePickerControllerDelegate,SelectIndexDelegate, CMPopTipViewDelegate>


//DATA
/*
 * chuyen tu form danh sahc lien he(co ca clientLeaderId)
 */
@property (nonatomic, retain) NSDictionary *dataSend;

/*
 * chuyen tu form KHDM
 */
@property (nonatomic, retain) NSDictionary *dataRoot;

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;

//@property (weak, nonatomic) IBOutlet UILabel *lbTieudeghichu;

@property (strong, nonatomic) IBOutlet UIView *view;

- (IBAction)actionSave:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *mainView;

//@property (weak, nonatomic) IBOutlet UIView *headerMainView;


@property (weak, nonatomic) IBOutlet UIView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewMainBodyInfo;

@property (weak, nonatomic) IBOutlet UITextField *txtTitle;


@property (weak, nonatomic) IBOutlet UITextView *txtContent;



@property (weak, nonatomic) IBOutlet UIView *viewMainBarButton;

@property (nonatomic, retain) IBOutlet UIButton * choosePhotoBtn;
@property (nonatomic, retain) IBOutlet UIButton * takePhotoBtn;

-(IBAction) getPhoto:(id) sender;

@property (weak, nonatomic) IBOutlet UITableView *tbData;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

- (IBAction)actionCancel:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

//danh sách nhưng tooltip
@property (nonatomic, retain) NSMutableArray *visiblePopTipViews;
@property (nonatomic, strong) id currentPopTipViewTarget;
- (IBAction)actionDel:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDel;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbFileAttachment;
@property (weak, nonatomic) IBOutlet UIButton *btnDelNote;

@end
