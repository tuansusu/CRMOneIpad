//
//  EditWidgetViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/20/15.
//
//

#import "EditWidgetViewController.h"

#import "SelectIndexViewController.h"
#import "CMPopTipView.h"

#import "MJDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"

#import "DTOWidgetObject.h"
#import "DTOWidgetProcess.h"
#import "DTOWidgetTypeObject.h"
#import "DTOWidgetTypeProcess.h"

#import "NSDictionary+QS.h"
#import "Globals.h"
#import "Items.h"

@interface EditWidgetViewController ()<UITextFieldDelegate, SelectIndexDelegate, CMPopTipViewDelegate>
{
    int smgSelect;
    IBOutlet UIButton *btnChooseWidget;
    IBOutlet UITextField *txtWidgetType;
    IBOutlet UIView *widgetTypeView;
    IBOutlet UIButton *btnLine;
    IBOutlet UIButton *btnColumnVertical;
    IBOutlet UIButton *btnColumnHorizontal;

    DTOWidgetProcess *dtoWidgetProcess;
    DTOWidgetTypeProcess *dtoWidgetTypeProcess;

    NSMutableArray *listWidgetTypeNotUse;
    NSMutableArray *listWidgetTypeNotUseStr;
    NSMutableArray *listWidgetTypeUsed;
    DTOWidgetTypeObject *widgetTypeSelected;
    TypeGraphs typeGraph;
}

@property (nonatomic, retain) UIPopoverController *listPopover;

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;



@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *headerMainView;
@property (weak, nonatomic) IBOutlet UILabel *lbTextHeaderMainView;


@property (weak, nonatomic) IBOutlet UIScrollView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewMainBodyInfo;
@property (weak, nonatomic) IBOutlet UIView *viewExpandInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)actionSave:(id)sender;

@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)actionClose:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnPersonalPosition;
- (IBAction)actionChoicePersonalPosition:(id)sender;

//danh sách nhưng tooltip
@property (nonatomic, retain) NSMutableArray *visiblePopTipViews;
@property (nonatomic, strong) id currentPopTipViewTarget;

@end

@implementation EditWidgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    smgSelect = [[[NSUserDefaults standardUserDefaults] objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];

    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
    }

    dtoWidgetProcess = [DTOWidgetProcess new];
    dtoWidgetTypeProcess = [DTOWidgetTypeProcess new];
    listWidgetTypeNotUse = [[NSMutableArray alloc] init];
    listWidgetTypeNotUseStr = [[NSMutableArray alloc] init];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)initData{
    [listWidgetTypeNotUse removeAllObjects];
    [listWidgetTypeNotUseStr removeAllObjects];
    listWidgetTypeUsed = [[NSMutableArray alloc] init];

    NSMutableArray *listWidgetUsedDic = [dtoWidgetProcess filterWithKey:DTOWIDGET_accountName withValue:@"demo"];
    for (NSDictionary *widgetDic in listWidgetUsedDic) {
        DTOWidgetTypeObject *widgetTypeOB =[widgetDic dtoWidgetTypeObject];
        [listWidgetTypeUsed addObject:widgetTypeOB.widgetId];
    }

    NSMutableArray *listWidgetTypeDic = [dtoWidgetTypeProcess filter];
    for (NSDictionary *widgetTypeDic in listWidgetTypeDic) {
        DTOWidgetTypeObject *widgetTypeOB =[widgetTypeDic dtoWidgetTypeObject];
        if (![listWidgetTypeUsed containsObject:widgetTypeOB.widgetId]) {
            [listWidgetTypeNotUse addObject:widgetTypeOB];
            [listWidgetTypeNotUseStr addObject:widgetTypeOB.widgetName];
        }
    }
}

- (void) updateInterFaceWithOption : (int) option
{
    self.fullNameLB.text = TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;

    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;

    [self.headerMainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    [self.headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    for (UIView *viewSubTemp in self.headerMainView.subviews) {


        if ([viewSubTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }

    [self.mainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];

    self.bodyMainView.backgroundColor = BACKGROUND_NORMAL_COLOR1;

    self.bodyMainView.layer.borderWidth = BORDER_WITH;
    self.bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];

    for (UIView *viewTemp in self.bodyMainView.subviews) {

        for (UIView *viewSubTemp in viewTemp.subviews) {


            if ([viewSubTemp isKindOfClass:[UILabel class]]) {
                ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
            }

            if ([viewSubTemp isKindOfClass:[UITextView class]]) {
                ((UITextView*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextView*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextView*) viewSubTemp).layer.borderWidth = BORDER_WITH;
            }
            if ([viewSubTemp isKindOfClass:[UITextField class]]) {
                ((UITextField*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextField*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
            }

        }

        if ([viewTemp isKindOfClass:[UIButton class]]) {
            if(viewTemp.tag!=10){
                [((UIButton*) viewTemp) setStyleNormalWithOption:smgSelect];
            }
        }

    }

}

#pragma mark tooltip

-(void) showTooltip : (UIView*) inputTooltipView withText : (NSString*) inputMessage {

    [self dismissAllPopTipViews];


    NSString *contentMessage = inputMessage;
    //UIView *contentView = inputTooltipView;

    UIColor *backgroundColor = [UIColor lightGrayColor];

    UIColor *textColor = [UIColor darkTextColor];

    //NSString *title = inputMessage;

    CMPopTipView *popTipView;


    popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];

    popTipView.delegate = self;

    /* Some options to try.
     */
    //popTipView.disableTapToDismiss = YES;
    //popTipView.preferredPointDirection = PointDirectionUp;
    //popTipView.hasGradientBackground = NO;
    //popTipView.cornerRadius = 2.0;
    //popTipView.sidePadding = 30.0f;
    //popTipView.topMargin = 20.0f;
    //popTipView.pointerSize = 50.0f;
    //popTipView.hasShadow = NO;

    popTipView.preferredPointDirection = PointDirectionDown;
    popTipView.hasShadow = NO;

    if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
        popTipView.backgroundColor = backgroundColor;
    }
    if (textColor && ![textColor isEqual:[NSNull null]]) {
        popTipView.textColor = textColor;
    }

    popTipView.animation = arc4random() % 2;
    popTipView.has3DStyle = (BOOL)(arc4random() % 2);

    popTipView.dismissTapAnywhere = YES;
    [popTipView autoDismissAnimated:YES atTimeInterval:3.0];


    [popTipView presentPointingAtView:inputTooltipView inView:self.viewMainBodyInfo animated:YES];


    [self.visiblePopTipViews addObject:popTipView];
    self.currentPopTipViewTarget = inputTooltipView;



}

- (void)dismissAllPopTipViews
{
    while ([self.visiblePopTipViews count] > 0) {
        CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObjectAtIndex:0];
    }
}

#pragma mark check
-(BOOL) checkValidToSave {
    if ([StringUtil trimString: txtWidgetType.text].length==0) {
        [self showTooltip:txtWidgetType withText:@"Bạn chưa nhập chọn loại Widget"];
        return NO;
    }
    return YES;
}

#pragma mark btn action

-(void) actionSave:(id)sender{
    //check valid to save

    if ([self checkValidToSave]) {
        DTOWidgetObject *widgetOB = [[DTOWidgetObject alloc] init];
        widgetOB.accountName = @"demo";
        widgetOB.typeGraphically = [NSString stringWithFormat:@"%d",typeGraph];
        widgetOB.colorDisplay1 = @"0, 105, 178";
        widgetOB.createDate= [[NSDate date] description];
        widgetOB.isShowData = @"0";
        widgetOB.colorDisplay2 = @"0, 105, 178";

        widgetOB.widgetId = widgetTypeSelected.widgetId;
        widgetOB.widgetName = widgetTypeSelected.widgetName;
        widgetOB.widgetType = widgetTypeSelected.widgetType;
        Items *items = [widgetOB itemObject];
        NSMutableDictionary * widgetDic = [items itemDictionary];

        if ([dtoWidgetProcess insertToDBWithEntity:widgetDic]) {
            //Thong bao cap nhat thanh cong va thoat
             NSMutableArray *listWidgetUsedDic = [dtoWidgetProcess filterWithKey:DTOWIDGET_accountName withValue:@"demo"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Cập nhật thành công, tiếp tục nhập?" delegate:self cancelButtonTitle:@"Không" otherButtonTitles:@"Có", nil];
            alert.tag = 5;
            [alert show];

        }else{
            //khong bao nhap loi - lien he quan tri
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Sảy ra lỗi, vui lòng thử lại hoặc gửi log đến quản trị" delegate:self cancelButtonTitle:@"Thoát" otherButtonTitles:nil];
            alert.tag = 6;
            [alert show];
        }
    }

}

-(void)showPopoverAtButton:(UIButton*)button{
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];

    detail.selectIndex = -1;
    //
    detail.listData = listWidgetTypeNotUseStr;

    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = button.frame;
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(IBAction)actionChooseWidgetType:(id)sender
{
    [self showPopoverAtButton:btnChooseWidget];
}

- (IBAction)actionWidgetLineSelected:(id)sender {
    typeGraph = typeGraphLine;
    [btnLine setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];

    [btnColumnVertical setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
    [btnColumnHorizontal setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
}
- (IBAction)actionWidgetColumnVerticalSelected:(id)sender {
    typeGraph = typeGraphColumnVertical;
    [btnColumnVertical setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];

    [btnLine setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
    [btnColumnHorizontal setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
}
- (IBAction)actionWidgetColumnHorizontalSelected:(id)sender {
    typeGraph = typeGraphColumnHorizontal;
    [btnColumnHorizontal setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];

    [btnColumnVertical setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
    [btnLine setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
}

#pragma mark SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{

    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    [txtWidgetType setText:[listWidgetTypeNotUseStr objectAtIndex:index]];
    widgetTypeSelected = [listWidgetTypeNotUse objectAtIndex:index];
    if ([widgetTypeSelected.widgetType intValue]==0) {
        [widgetTypeView setHidden:NO];
    }else{
        [widgetTypeView setHidden:YES];
    }
    typeGraph = typeGraphLine;
    [btnLine setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];

    [btnColumnVertical setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
    [btnColumnHorizontal setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
}


-(void) homeBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
