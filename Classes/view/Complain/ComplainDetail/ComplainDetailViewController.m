//
//  ComplainDetailViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import "ComplainDetailViewController.h"
#import "Globals.h"
#import "DTOComplainObject.h"
#import "CMPopTipView.h"


@interface ComplainDetailViewController ()<CMPopTipViewDelegate>
{
    IBOutlet UIView *mainView;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnCancel;
    DTOComplainObject *_complainOB;

    IBOutlet UITextField *txtMaKhieuNai;
    IBOutlet UITextField *txtNoiDungKhieuNai;
    IBOutlet UITextField *txtLiDo;
    IBOutlet UITextField *txtNoiDungXuLy;
    IBOutlet UITextField *txtNguoiNhan;
    IBOutlet UITextField *txtNgayNhan;
    IBOutlet UITextField *txtNguoiXuLy;
    IBOutlet UITextField *txtNgayXuLy;

    IBOutlet UILabel     *_titleLabel;
    int smgSelect;
}

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;


@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *headerMainView;


@property (weak, nonatomic) IBOutlet UIView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewMainBodyInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)actionSave:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;


//footer
@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@end

@implementation ComplainDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mainView.layer.cornerRadius = CORNER_RADIUS_VIEW;
    mainView.layer.masksToBounds = YES;
    btnSave.layer.cornerRadius = CORNER_RADIUS_BUTTON;
    btnSave.layer.masksToBounds = YES;
    btnCancel.layer.cornerRadius = CORNER_RADIUS_BUTTON;
    btnCancel.layer.masksToBounds = YES;
    smgSelect = [[[NSUserDefaults standardUserDefaults] objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataWithComplainOB:(DTOComplainObject*)complainOB{
    _complainOB = complainOB;

    if (_complainOB) {
        [_titleLabel setText:COMPLAIN_TITLE_UPDATE_COMPLAIN];
        [txtNoiDungKhieuNai setText:_complainOB.content];
        [txtLiDo setText:_complainOB.reason];
        [txtNoiDungXuLy setText:_complainOB.result];
        [txtNguoiNhan setText:_complainOB.accountId];
        [txtNgayNhan setText:_complainOB.receivedDate];
        [txtNguoiXuLy setText:_complainOB.processerId];
        [txtNgayXuLy setText:_complainOB.processedDate];
    }else{
         [_titleLabel setText:COMPLAIN_TITLE_ADD_COMPLAIN];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) updateInterFaceWithOption : (int) option
{
    _fullNameLB.text                = TITLE_APPLICATION;
    _headerViewBar.backgroundColor  = HEADER_VIEW_COLOR1;
    _fullNameLB.textColor           = TEXT_COLOR_HEADER_APP;

    _footerView.backgroundColor     = TOOLBAR_VIEW_COLOR;
    _barLabel.textColor             = TEXT_TOOLBAR_COLOR1;

    _headerMainView.backgroundColor = HEADER_SUB_VIEW_COLOR1;
    [_headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    for (UIView *viewSubTemp in _headerMainView.subviews)
    {
        if ([viewSubTemp isKindOfClass:[UILabel class]])
        {
            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }

    _mainView.backgroundColor       = HEADER_SUB_VIEW_COLOR1;

    _bodyMainView.backgroundColor   = BACKGROUND_NORMAL_COLOR1;
    _bodyMainView.layer.borderWidth = BORDER_WITH;
    _bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];

    for (UIView *viewTemp in _bodyMainView.subviews)
    {
        for (UIView *viewSubTemp in viewTemp.subviews)
        {
            if ([viewSubTemp isKindOfClass:[UILabel class]])
            {
                ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
            }
            else if ([viewSubTemp isKindOfClass:[UITextView class]])
            {
                ((UITextView*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextView*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextView*) viewSubTemp).layer.borderWidth = BORDER_WITH;
            }
            else if ([viewSubTemp isKindOfClass:[UITextField class]])
            {
                ((UITextField*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextField*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
            }
        }

        if ([viewTemp isKindOfClass:[UIButton class]])
        {
            [((UIButton*) viewTemp) setStyleNormalWithOption:smgSelect];
        }
    }
}

-(IBAction)btnCancelTapped:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(closeComplainDetailView:)]) {
        [_delegate closeComplainDetailView:self];
    }
}

-(IBAction)btnSaveTapped:(id)sender{
    DTOComplainObject *complainOB = [[DTOComplainObject alloc] init];
    if (_complainOB) {
        _complainOB.content = txtNoiDungKhieuNai.text;
        _complainOB.reason = txtLiDo.text;
        _complainOB.result = txtNoiDungXuLy.text;
        _complainOB.receiverId = txtNguoiNhan.text;
        _complainOB.receivedDate = txtNgayNhan.text;
        _complainOB.processerId = txtNguoiXuLy.text;
        _complainOB.processedDate = txtNgayXuLy.text;
        complainOB = _complainOB;
    }else{

        complainOB.content = txtNoiDungKhieuNai.text;
        complainOB.reason = txtLiDo.text;
        complainOB.result = txtNoiDungXuLy.text;
        complainOB.receiverId = txtNguoiNhan.text;
        complainOB.receivedDate = txtNgayNhan.text;
        complainOB.processerId = txtNguoiXuLy.text;
        complainOB.processedDate = txtNgayXuLy.text;
    }
    if (_leadId) {

        complainOB.accountId = _leadId;
    }
    complainOB.status = @"1";
   
    if ([self checkValid]) {
        if (_delegate && [_delegate respondsToSelector:@selector(updateComplainDetailViewWithComplainOB:)]) {
            [_delegate updateComplainDetailViewWithComplainOB:complainOB];
        }
    }

}

-(BOOL)checkValid{
    if ([[StringUtil trimString:txtNoiDungKhieuNai.text] isEqualToString:@""]) {
        [self showTooltip:txtNoiDungKhieuNai withText:SYS_Notification_CheckValid_NoiDungKhieuNai];
        [txtNoiDungKhieuNai becomeFirstResponder];
        return NO;
    }
    if ([[StringUtil trimString:txtLiDo.text] isEqualToString:@""]) {
        [self showTooltip:txtNoiDungKhieuNai withText:SYS_Notification_CheckValid_LiDo];
        [txtLiDo becomeFirstResponder];
        return NO;
    }
    if ([[StringUtil trimString:txtNoiDungXuLy.text] isEqualToString:@""]) {
        [self showTooltip:txtNoiDungKhieuNai withText:SYS_Notification_CheckValid_NoiDungXuLy];
        [txtNoiDungXuLy becomeFirstResponder];
        return NO;
    }
    return YES;
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
#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
}
@end
