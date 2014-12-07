//
//  MainViewController.m
//  VofficeIpad2
//
//  Created by Tran Van Bang on 6/19/13.
//
//

#import "MainViewController.h"
#import "UIView+AUISelectiveBorder.h"

@interface MainViewController ()
{
    NSString *interfaceOption;
    NSUserDefaults *defaults;
    int smgSelect ; //option layout
    
    NSArray *arrayData;
    
    ///////CHART///////
    /////////////////////////////
    MIMLineGraph *mLineGraph;
    NSMutableArray *dataArrayFromCSV;
    NSMutableArray *xDataArrayFromCSV;
    NSArray *anchorPropertiesArray;
    NSDictionary *horizontalLinesProperties;
    NSDictionary *verticalLinesProperties;
    
    NSArray *yValuesArray;
    NSArray *xValuesArray;
    NSArray *xTitlesArray;
    
}
@end

@implementation MainViewController

NSString* emptyText = @"";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
    }
    return self;
}


#pragma mark Appear
//Ham nay chay lan dau khi view duoc hien thi
- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[SVProgressHUD show];
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
        [self.tbData setSeparatorInset:UIEdgeInsetsZero];
    }
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    
    //[self.tbData registerNib:[UINib nibWithNibName:@"OpportunityCell" bundle:nil] forCellReuseIdentifier:@"opportunityCell"];
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    arrayData  = [NSArray new];
    //load data from db
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    interfaceOption = [defaults objectForKey:INTERFACE_OPTION];
    
    if (!interfaceOption || [interfaceOption isEqualToString:@"(null)"]) {
        [defaults setObject:@"1" forKey:INTERFACE_OPTION];
    }
    [self updateInterFaceWithOption:[interfaceOption intValue]];
}


- (void) updateInterFaceWithOption : (int) option
{
    self.fullNameLB.text = TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    
    [self.headerViewBar setBackGroundHeaderView:option];
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
    
    
    for (UIView *viewTemp in self.view.subviews) {
        if ([viewTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
        
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            ((UIButton*) viewTemp).backgroundColor = BUTTON_IN_ACTIVE_COLOR_1;
            [((UIButton*) viewTemp) setTitleColor:TEXT_BUTTON_COLOR1 forState:UIControlStateNormal];
        }
        if ([viewTemp isKindOfClass:[UITextView class]]) {
            ((UITextView*) viewTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextView*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextView*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextView*) viewTemp).layer.borderWidth = BORDER_WITH;
        }
        if ([viewTemp isKindOfClass:[UITextField class]]) {
            ((UITextField*) viewTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextField*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextField*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextField*) viewTemp).layer.borderWidth = BORDER_WITH;
        }
    }
    
    
    
}



-(void) viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}



#pragma mark Event
- (void)didFinish {
   
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    verticalLinesProperties=nil;
    
    switch (indexPath.row)
    {
        case 0:
        {
            
            horizontalLinesProperties=nil;
            verticalLinesProperties=nil;
            anchorPropertiesArray=nil;
            
            
            yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
            xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                          @"Feb",
                          @"Mar",
                          @"Apr",
                          @"May",
                          @"Jun",
                          @"Jul",
                          @"Aug",
                          @"Sep",
                          @"Oct",
                          @"Nov",
                          @"Dec", nil];
            
            xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
                          @"Feb",
                          @"Mar",
                          @"Apr",
                          @"May",
                          @"Jun",
                          @"Jul",
                          @"Aug",
                          @"Sep",
                          @"Oct",
                          @"Nov",
                          @"Dec", nil];
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 30, _tbData.frame.size.width-50, _tbData.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            
            //Set initial Y-Label as 0..
            mLineGraph.minimumLabelOnYIsZero=TRUE;
            
            
            //Set color for line graph
            MIMColorClass *c1=[MIMColorClass colorWithComponent:@"0,169,249"];
            mLineGraph.lineColorArray=[NSArray arrayWithObjects:c1, nil];
            
            
            mLineGraph.titleLabel.text=@"Huy động vốn";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, _tbData.frame.size.width, 30);
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
        }
            break;
            
        case 1:
        {
            
            horizontalLinesProperties=[[NSDictionary alloc] initWithObjectsAndKeys:@"2,1",@"dotted", nil];
            verticalLinesProperties=[[NSDictionary alloc]initWithObjectsAndKeys:@"1,2",@"dotted", nil];
            
            
            
            yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
            
            xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                          @"Feb",
                          @"Mar",
                          @"Apr",
                          @"May",
                          @"Jun",
                          @"Jul",
                          @"Aug",
                          @"Sep",
                          @"Oct",
                          @"Nov",
                          @"Dec", nil];
            
            xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
                          @"Feb",
                          @"Mar",
                          @"Apr",
                          @"May",
                          @"Jun",
                          @"Jul",
                          @"Aug",
                          @"Sep",
                          @"Oct",
                          @"Nov",
                          @"Dec", nil];
            
            
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 30, _tbData.frame.size.width-50, _tbData.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            
            
            mLineGraph.titleLabel.text=@"Doanh thu";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, _tbData.frame.size.width, 30);
            
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
            
        }
            break;
            
            
    }
    return cell;
    
    
}



#pragma mark - DELEGATE METHODS
-(NSArray *)valuesForGraph:(id)graph
{
    return yValuesArray;
}

-(NSArray *)valuesForXAxis:(id)graph
{
    return xValuesArray;
}

-(NSArray *)titlesForXAxis:(id)graph
{
    
    return xTitlesArray;
    
}

-(NSArray *)AnchorProperties:(id)graph
{
    return anchorPropertiesArray;
}

-(NSDictionary *)horizontalLinesProperties:(id)graph
{
    return horizontalLinesProperties;
    
}

-(NSDictionary*)verticalLinesProperties:(id)graph
{
    return verticalLinesProperties;
}


-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(5, _tbData.frame.size.width * 0.5 + 20, 310, 20)];
    [a setBackgroundColor:[UIColor clearColor]];
    [a setText:text];
    a.numberOfLines=5;
    [a setTextAlignment:UITextAlignmentCenter];
    [a setTextColor:[UIColor blackColor]];
    [a setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [a setMinimumFontSize:8];
    return a;
    
}


#pragma mark Action

- (IBAction)logOut:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Đồng chí có muốn đăng xuất không ?" delegate:self cancelButtonTitle:@"Không" otherButtonTitles:@"Có", nil];
    alert.tag = 3;
    [alert show];
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex ==1 && alertView.tag==3)
    {
        FrameworkAppDelegate *appDel = (FrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
        RootViewController *rootView = [[RootViewController alloc] init];
        [appDel.window setRootViewController:rootView];
    }
    
}

#pragma mark end

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




- (void)viewDidUnload {
    
    [super viewDidUnload];
}

#pragma mark Button action

- (IBAction)actionDashBoard:(id)sender {
}
//Khach hang dau moi = khach hang tiem nang
- (IBAction)actionPotentialCustomer:(id)sender {
    ListAccountLeadViewController *viewController = [[ListAccountLeadViewController alloc]initWithNibName:@"ListAccountLeadViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (IBAction)actionAccount360:(id)sender {
    ListAccountViewController *viewController = [[ListAccountViewController alloc]initWithNibName:@"ListAccountViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)actionOpportunity:(UIButton *)sender {
    
    ListOpportunityViewController *viewController = [[ListOpportunityViewController alloc]initWithNibName:@"ListOpportunityViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];
    
    
}
- (IBAction)actionMapView:(id)sender {
    
    TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];
    
}
@end
