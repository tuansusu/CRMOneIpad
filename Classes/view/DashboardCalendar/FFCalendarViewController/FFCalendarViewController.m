

#import "FFCalendarViewController.h"
#import "DTOTASKProcess.h"
#import "DTOTaskObject.h"
#import "NSDictionary+QS.h"
#import "EditCalendarLeadViewController.h"

#import "Globals.h"

#define BUTTON_WIDTH 60
#define BUTTON_MOUNT_WIDTH 80
#define APP_SCREEN_WIDTH 1024

#import "FFCalendar.h"

@interface FFCalendarViewController () <FFButtonAddEventWithPopoverProtocol, FFYearCalendarViewProtocol, FFMonthCalendarViewProtocol, FFWeekCalendarViewProtocol, FFDayCalendarViewProtocol,EditCalendarLeadViewControllerDelegate>
{
    UIView *_topMenuView;

    DTOTASKProcess *dtoTaskProcess;
}
@property (nonatomic) BOOL boolDidLoad;
@property (nonatomic) BOOL boolYearViewIsShowing;
@property (nonatomic, strong) NSMutableDictionary *dictEvents;
@property (nonatomic, strong) UILabel *labelWithMonthAndYear;
@property (nonatomic, strong) NSArray *arrayButtons;
@property (nonatomic, strong) NSArray *arrayCalendars;
@property (nonatomic, strong) FFEditEventPopoverController *popoverControllerEditar;
@property (nonatomic, strong) FFYearCalendarView *viewCalendarYear;
@property (nonatomic, strong) FFMonthCalendarView *viewCalendarMonth;
@property (nonatomic, strong) FFWeekCalendarView *viewCalendarWeek;
@property (nonatomic, strong) FFDayCalendarView *viewCalendarDay;
@end

@implementation FFCalendarViewController

#pragma mark - Synthesize

@synthesize boolDidLoad;
@synthesize boolYearViewIsShowing;
@synthesize protocol;
@synthesize arrayWithEvents;
@synthesize dictEvents;
@synthesize labelWithMonthAndYear;
@synthesize arrayButtons;
@synthesize arrayCalendars;
@synthesize popoverControllerEditar;
@synthesize viewCalendarYear;
@synthesize viewCalendarMonth;
@synthesize viewCalendarWeek;
@synthesize viewCalendarDay;

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView{
    [super loadView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editEventSelected:) name:CALENDAR_SELECTE_EVENT_NOTIFICATION object:nil];

    dtoTaskProcess= [DTOTASKProcess new];

    self.arrayWithEvents = [self arrayWithEvents];
    [self.navigationController setNavigationBarHidden:YES];
    [self.view setBackgroundColor:[UIColor blackColor]];
}

- (void)viewDidLoad {

    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];

    [self customNavigationBarLayout];
    [self addTopMenuView];
    [self addCalendars];

    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:0]];


}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    if (!boolDidLoad) {
        boolDidLoad = YES;
        [self buttonTodayAction:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark list events

- (NSMutableArray *)arrayWithEvents {

    NSMutableArray *eventArr = [[NSMutableArray alloc] init];

    NSMutableArray *resultArr = [dtoTaskProcess filter];
    for (NSDictionary *taskDic in resultArr) {
        DTOTaskObject *taskOB = [taskDic dtoTaskObject];


        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];

        NSDate *startDate = [DateFormatter dateFromString:taskOB.startDate];

        NSDate *endDate = [DateFormatter dateFromString:taskOB.endDate];

        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *startDateComponents = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:startDate];

        NSDateComponents *endDateComponents = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:endDate];

        if ([startDateComponents year]==[endDateComponents year] && [startDateComponents month]==[endDateComponents month] && [startDateComponents day]==[endDateComponents day]) {
            FFEvent *event = [FFEvent new];
            [event setStringCustomerName: taskOB.title];
            [event setNumCustomerID: [NSNumber numberWithInt:[taskOB.id intValue]]];
            [event setDateDay:[NSDate dateWithYear:[startDateComponents year] month:[startDateComponents month] day:[startDateComponents day]]];
            [event setDateTimeBegin:[NSDate dateWithHour:[startDateComponents hour] min:[startDateComponents minute]]];
            [event setDateTimeEnd:[NSDate dateWithHour:[endDateComponents hour] min:[endDateComponents minute]]];
            [eventArr addObject:event];
        }else if ([startDate compare:endDate] == NSOrderedAscending) {

            NSDate *nextDate;
            for ( nextDate = startDate ; [nextDate compare:endDate] < 0 ; nextDate = [nextDate dateByAddingTimeInterval:24*60*61] ) {
                FFEvent *eventAppending = [FFEvent new];
                [eventAppending setStringCustomerName: taskOB.title];
                [eventAppending setNumCustomerID: [NSNumber numberWithInt:[taskOB.id intValue]]];
                NSCalendar *cal = [NSCalendar currentCalendar];
                NSDateComponents *nextDateComponents = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:nextDate];
                if ([startDateComponents year]==[nextDateComponents year] && [startDateComponents month]==[nextDateComponents month] && [startDateComponents day]==[nextDateComponents day])
                {
                    [eventAppending setDateDay:nextDate];
                    [eventAppending setDateTimeBegin:[NSDate dateWithHour:[startDateComponents hour] min:[startDateComponents minute]]];
                    [eventAppending setDateTimeEnd:[NSDate dateWithHour:23 min:59]];
                }
                else if ([endDateComponents year]==[nextDateComponents year] && [endDateComponents month]==[nextDateComponents month] && [endDateComponents day]==[nextDateComponents day])
                {
                    [eventAppending setDateDay:[NSDate dateWithYear:[endDateComponents year] month:[endDateComponents month] day:[endDateComponents day]]];
                    [eventAppending setDateTimeBegin:[NSDate dateWithHour:0 min:1]];
                    [eventAppending setDateTimeEnd:[NSDate dateWithHour:[endDateComponents hour] min:[endDateComponents minute]]];
                    [eventArr addObject:eventAppending];
                    break;
                }
                else
                {
                    [eventAppending setDateDay:nextDate];
                    [eventAppending setDateTimeBegin:[NSDate dateWithHour:0 min:1]];
                    [eventAppending setDateTimeEnd:[NSDate dateWithHour:23 min:59]];
                }
                [eventArr addObject:eventAppending];
            }
        }

    }

    return eventArr;
}

#pragma mark - FFDateManager Notification

- (void)dateChanged:(NSNotification *)notification {

    [self updateLabelWithMonthAndYear];
}

- (void)updateLabelWithMonthAndYear {

    NSDateComponents *comp = [NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]];
    NSString *string = boolYearViewIsShowing ? [NSString stringWithFormat:@"%li", (long)comp.year] : [NSString stringWithFormat:@"%@ %li", [arrayMonthName objectAtIndex:comp.month-1], (long)comp.year];
    [labelWithMonthAndYear setText:string];
}

#pragma mark - Init dictEvents

- (void)setArrayWithEvents:(NSMutableArray *)_arrayWithEvents {

    arrayWithEvents = _arrayWithEvents;

    dictEvents = [NSMutableDictionary new];

    for (FFEvent *event in _arrayWithEvents) {
        NSDateComponents *comp = [NSDate componentsOfDate:event.dateDay];
        NSDate *newDate = [NSDate dateWithYear:comp.year month:comp.month day:comp.day];
        NSMutableArray *array = [dictEvents objectForKey:newDate];
        if (!array) {
            array = [NSMutableArray new];
            [dictEvents setObject:array forKey:newDate];
        }
        [array addObject:event];
    }
}

#pragma mark - Custom NavigationBar

- (void)customNavigationBarLayout {

    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor lighterGrayCustom]];

    [self addRightBarButtonItems];
    [self addLeftBarButtonItems];
}

- (void)addRightBarButtonItems {

    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 30.;

    FFRedAndWhiteButton *buttonYear = [self calendarButtonWithTitle:@"year"];
    FFRedAndWhiteButton *buttonMonth = [self calendarButtonWithTitle:@"month"];
    FFRedAndWhiteButton *buttonWeek = [self calendarButtonWithTitle:@"week"];
    FFRedAndWhiteButton *buttonDay = [self calendarButtonWithTitle:@"day"];

    UIBarButtonItem *barButtonYear = [[UIBarButtonItem alloc] initWithCustomView:buttonYear];
    UIBarButtonItem *barButtonMonth = [[UIBarButtonItem alloc] initWithCustomView:buttonMonth];
    UIBarButtonItem *barButtonWeek = [[UIBarButtonItem alloc] initWithCustomView:buttonWeek];
    UIBarButtonItem *barButtonDay = [[UIBarButtonItem alloc] initWithCustomView:buttonDay];

    FFButtonAddEventWithPopover *buttonAdd = [[FFButtonAddEventWithPopover alloc] initWithFrame:CGRectMake(0., 0., 30., 44)];
    [buttonAdd setProtocol:self];
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithCustomView:buttonAdd];

    arrayButtons = @[buttonYear, buttonMonth, buttonWeek, buttonDay];
    
    [self.navigationItem setRightBarButtonItems:@[barButtonAdd, fixedItem, barButtonYear, barButtonMonth, barButtonWeek, barButtonDay]];
}

- (void)addLeftBarButtonItems {

    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 30.;

    FFRedAndWhiteButton *buttonToday = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30)];
    [buttonToday addTarget:self action:@selector(buttonTodayAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonToday setTitle:@"today" forState:UIControlStateNormal];
    UIBarButtonItem *barButtonToday = [[UIBarButtonItem alloc] initWithCustomView:buttonToday];

    labelWithMonthAndYear = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., 170., 30)];
    [labelWithMonthAndYear setTextColor:HEADER_VIEW_COLOR1];
    [labelWithMonthAndYear setFont:buttonToday.titleLabel.font];
    UIBarButtonItem *barButtonLabel = [[UIBarButtonItem alloc] initWithCustomView:labelWithMonthAndYear];

    [self.navigationItem setLeftBarButtonItems:@[barButtonLabel, fixedItem, barButtonToday]];
}

- (FFRedAndWhiteButton *)calendarButtonWithTitle:(NSString *)title {

    FFRedAndWhiteButton *button = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30.)];
    [button addTarget:self action:@selector(buttonYearMonthWeekDayAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

#pragma mark add menu top view

-(void)addTopMenuView{


    FFRedAndWhiteButton *buttonYear = [self calendarButtonWithTitle:@"year"];

    UIImageView *imgBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20,APP_SCREEN_WIDTH, buttonYear.frame.size.height*2)];
    //tuannv36
    [imgBackground setBackgroundColor:HEADER_VIEW_COLOR1];
    [self.view addSubview:imgBackground];

    [buttonYear setFrame:CGRectMake(self.view.frame.size.width-BUTTON_WIDTH*4, 0, BUTTON_WIDTH, buttonYear.frame.size.height)];

    UIButton *btnCloseCalendar = [[UIButton alloc] initWithFrame:CGRectMake(20., 0, 32, 32)];

    [btnCloseCalendar setBackgroundImage:[UIImage imageNamed:@"icon_menu-1.png"] forState:UIControlStateNormal];
    //    [btnCloseCalendar setImage:[UIImage imageNamed:@"iconMenu"] forState:UIControlStateNormal];
    [btnCloseCalendar addTarget:self action:@selector(closeCalendar:) forControlEvents:UIControlEventTouchUpInside];

    FFRedAndWhiteButton *buttonMonth = [self calendarButtonWithTitle:@"month"];
    [buttonMonth setFrame:CGRectMake(self.view.frame.size.width-BUTTON_WIDTH*4-BUTTON_MOUNT_WIDTH, 0, BUTTON_MOUNT_WIDTH, buttonMonth.frame.size.height)];

    FFRedAndWhiteButton *buttonWeek = [self calendarButtonWithTitle:@"week"];
    [buttonWeek setFrame:CGRectMake(self.view.frame.size.width-BUTTON_WIDTH*5-BUTTON_MOUNT_WIDTH, 0, BUTTON_WIDTH, buttonWeek.frame.size.height)];

    FFRedAndWhiteButton *buttonDay = [self calendarButtonWithTitle:@"day"];
    [buttonDay setFrame:CGRectMake(self.view.frame.size.width-BUTTON_WIDTH*6-BUTTON_MOUNT_WIDTH, 0, BUTTON_WIDTH, buttonDay.frame.size.height)];


    FFRedAndWhiteButton *buttonToday = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30)];
    [buttonToday addTarget:self action:@selector(buttonTodayAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonToday setTitle:@"today" forState:UIControlStateNormal];

    [buttonToday setFrame:CGRectMake(self.view.frame.size.width-BUTTON_WIDTH*7-BUTTON_MOUNT_WIDTH, 0, BUTTON_WIDTH, buttonToday.frame.size.height)];


    FFRedAndWhiteButton *buttonAdd = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30)];
    [buttonAdd addTarget:self action:@selector(buttonAddEventAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonAdd setTitle:@"Add" forState:UIControlStateNormal];

    [buttonAdd setFrame:CGRectMake(self.view.frame.size.width-BUTTON_WIDTH*8-10-BUTTON_MOUNT_WIDTH, 0, BUTTON_WIDTH, buttonAdd.frame.size.height)];

    labelWithMonthAndYear = [[UILabel alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH-BUTTON_WIDTH*2.5, 0., 140., 30)];
    [labelWithMonthAndYear setTextColor:TEXT_COLOR_WHITE_1];
    [labelWithMonthAndYear setFont:[UIFont boldSystemFontOfSize:17]];
    [labelWithMonthAndYear setFont:buttonToday.titleLabel.font];
    labelWithMonthAndYear.textAlignment = NSTextAlignmentRight;

    arrayButtons = @[buttonYear, buttonMonth, buttonWeek, buttonDay,buttonAdd];


    _topMenuView  = [[UIView alloc] initWithFrame:CGRectMake(0, 27, self.view.frame.size.width, buttonYear.frame.size.height*2)];
    [_topMenuView setBackgroundColor:[UIColor whiteColor]];
    [_topMenuView addSubview:btnCloseCalendar];
    [_topMenuView addSubview:buttonYear];
    [_topMenuView addSubview:buttonMonth];
    [_topMenuView addSubview:buttonWeek];
    [_topMenuView addSubview:buttonDay];
    [_topMenuView addSubview:buttonToday];
    [_topMenuView addSubview:buttonAdd];
    [_topMenuView addSubview:labelWithMonthAndYear];
    //[_topMenuView setBackgroundColor:[UIColor clearColor]];
    //tuannv36
    [_topMenuView setBackgroundColor:HEADER_VIEW_COLOR1];

    [self.view addSubview:_topMenuView];
}

#pragma mark - Add Calendars

- (void)addCalendars {
    CGRect frame = CGRectMake(0., 64, self.view.frame.size.width, self.view.frame.size.height-64);

    viewCalendarYear = [[FFYearCalendarView alloc] initWithFrame:frame];
    [viewCalendarYear setProtocol:self];
    [self.view addSubview:viewCalendarYear];

    viewCalendarMonth = [[FFMonthCalendarView alloc] initWithFrame:frame];
    [viewCalendarMonth setProtocol:self];
    [viewCalendarMonth setDictEvents:dictEvents];
    [self.view addSubview:viewCalendarMonth];

    viewCalendarWeek = [[FFWeekCalendarView alloc] initWithFrame:frame];
    [viewCalendarWeek setProtocol:self];
    [viewCalendarWeek setDictEvents:dictEvents];
    [self.view addSubview:viewCalendarWeek];

    viewCalendarDay = [[FFDayCalendarView alloc] initWithFrame:frame];
    [viewCalendarDay setProtocol:self];
    [viewCalendarDay setDictEvents:dictEvents];
    [self.view addSubview:viewCalendarDay];

    arrayCalendars = @[viewCalendarYear, viewCalendarMonth, viewCalendarWeek, viewCalendarDay];
}

#pragma mark - Button Action
-(void)closeCalendar:(id)sender
{
    [Util backToHome:self];
}


- (IBAction)buttonYearMonthWeekDayAction:(id)sender {

    long index = [arrayButtons indexOfObject:sender];

    [self.view bringSubviewToFront:[arrayCalendars objectAtIndex:index]];

    for (UIButton *button in arrayButtons) {
        button.selected = (button == sender);
    }

    boolYearViewIsShowing = (index == 0);
    [self updateLabelWithMonthAndYear];
}

- (IBAction)buttonTodayAction:(id)sender {

    [[FFDateManager sharedManager] setCurrentDate:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year
                                                                 month:[NSDate componentsOfCurrentDate].month
                                                                   day:[NSDate componentsOfCurrentDate].day]];
}

- (IBAction)buttonAddEventAction:(id)sender {
    EditCalendarLeadViewController *viewController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
    [viewController setDelegate:self];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark EditCalendarLeadViewController delegate
- (void)reloadListCalendarTask{
    self.arrayWithEvents = [self arrayWithEvents];
    [self addCalendars];
}

#pragma mark - Interface Rotation

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {

    [viewCalendarYear invalidateLayout];
    [viewCalendarMonth invalidateLayout];
    [viewCalendarWeek invalidateLayout];
    [viewCalendarDay invalidateLayout];
}

#pragma mark - FFButtonAddEventWithPopover Protocol

- (void)addNewEvent:(FFEvent *)eventNew {

    NSMutableArray *arrayNew = [dictEvents objectForKey:eventNew.dateDay];
    if (!arrayNew) {
        arrayNew = [NSMutableArray new];
        [dictEvents setObject:arrayNew forKey:eventNew.dateDay];
    }
    [arrayNew addObject:eventNew];

    [self setNewDictionary:dictEvents];
}

#pragma mark Edit Event Selected
-(void)editEventSelected:(NSNotification *)noti{
    FFEvent * event = noti.object;
    NSMutableArray *resultArr = [dtoTaskProcess filterWithKey:@"id" withValue:[NSString stringWithFormat:@"%@",event.numCustomerID]];
    if (resultArr.count>0) {
        NSDictionary *dataDic = [resultArr objectAtIndex:0];

        EditCalendarLeadViewController *viewController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
        [viewController setDelegate:self];
        viewController.dataSend = dataDic;
        [self presentViewController:viewController animated:YES completion:nil];
    }


}

#pragma mark - FFMonthCalendarView, FFWeekCalendarView and FFDayCalendarView Protocols

- (void)setNewDictionary:(NSDictionary *)dict {

    dictEvents = (NSMutableDictionary *)dict;

    [viewCalendarMonth setDictEvents:dictEvents];
    [viewCalendarWeek setDictEvents:dictEvents];
    [viewCalendarDay setDictEvents:dictEvents];

    [self arrayUpdatedWithAllEvents];
}

#pragma mark - FFYearCalendarView Protocol

- (void)showMonthCalendar {

    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:1]];
}

#pragma mark - Sending Updated Array to FFCalendarViewController Protocol

- (void)arrayUpdatedWithAllEvents {

    NSMutableArray *arrayNew = [NSMutableArray new];

    NSArray *arrayKeys = dictEvents.allKeys;
    for (NSDate *date in arrayKeys) {
        NSArray *arrayOfDate = [dictEvents objectForKey:date];
        for (FFEvent *event in arrayOfDate) {
            [arrayNew addObject:event];
        }
    }
    
    if (protocol != nil && [protocol respondsToSelector:@selector(arrayUpdatedWithAllEvents:)]) {
        [protocol arrayUpdatedWithAllEvents:arrayNew];
    }
}

@end
