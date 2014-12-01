//
//  CompetitorsViewController.m
//  OfficeOneStudy
//
//  Created by viettel on 11/7/14.
//
//

#import "CompetitorsViewController.h"
#import "DTOOPPORTUNITYProcess.h"
#import "DTOCOMPETITORProcess.h"
#import "DTOPRODUCTMASTERProcess.h"
#import "DTOACCOUNTProcess.h"

@interface CompetitorsViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    
    
    DTOOPPORTUNITYProcess *dtoOpportunityProcess;
    DTOCOMPETITORProcess *dtoCompetitorProcess;
    DTOPRODUCTMASTERProcess *dtoProductMasterProcess;
    DTOACCOUNTProcess *dtoAccountProcess;
    
    UIColor *textColorButtonNormal; //mau chu button binh thuong
    UIColor *textColorButtonSelected; //mau chu button select
    UIColor *backgrondButtonSelected; //mau nen button select
    UIColor *backgroundButtonNormal; //Mau nen button binh thuong
    
}
@end

@implementation CompetitorsViewController
@synthesize typeActionEvent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
        
        [self.tbData setSeparatorInset:UIEdgeInsetsZero];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self actionClueContact:self.btnClueContact];
    
//    [self.tbData registerNib:[UINib nibWithNibName:@"OpportunityCell" bundle:nil] forCellReuseIdentifier:@"opportunityCell"];
    
}
-(void) viewWillAppear:(BOOL)animated{
    
}

-(void) viewDidAppear:(BOOL)animated{
    
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    [self actionClueContact:self.btnClueContact];
    
    dtoOpportunityProcess = [DTOOPPORTUNITYProcess new];
    dtoCompetitorProcess = [DTOCOMPETITORProcess new];
    dtoProductMasterProcess = [DTOPRODUCTMASTERProcess new];
    dtoAccountProcess  = [DTOACCOUNTProcess new];
    arrayData  = [NSArray new];
}


-(void) loadDataWithTypeAction : (enum TypeActionEvent) inputTypeActionEvent{
    typeActionEvent = inputTypeActionEvent;
    switch (typeActionEvent) {
        case type_ActionSale:
        {
            
        }
            break;
            case type_ClueContact:
        {
            arrayData = [dtoAccountProcess filter];
        }break;
            case type_Competionor:
        {
            arrayData = [dtoCompetitorProcess filterCompetitor];
        }break;
        case type_ProposeProduct:{
            arrayData = [dtoProductMasterProcess filter];
        }break;
        case type_Support:{
            
        }break;
            
        default:
            break;
    }
    
    [self.tbData reloadData];
}


- (void) updateInterFaceWithOption : (int) option
{
    self.fullNameLB.text = TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    //[self.btnSearch setStyleNormalWithOption:smgSelect];
    [self.leftViewHeader setBackgroundColor:BACKGROUND_COLOR_TOP_LEFT_HEADER];
    self.leftLabelHeader.textColor = TEXT_COLOR_HEADER_APP;
    
    backgrondButtonSelected = BUTTON_ACTIVE_COLOR_1;
    backgroundButtonNormal = BUTTON_REPORT_MAIN_IN_ACTIVE_COLOR_1;
    
    for (UIView *viewTemp in self.leftInMainView.subviews) {
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark action button
- (IBAction)homeBack:(id)sender {
    [Util backToHome:self];
}


- (IBAction)actionClueContact:(UIButton *)sender {
    [self loadDataWithTypeAction:type_ClueContact];
    [self displayNormalButtonState:sender];
    
}

- (IBAction)actionProposeProduct:(UIButton *)sender {
    [self loadDataWithTypeAction:type_ProposeProduct];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionActionSale:(id)sender {
    [self loadDataWithTypeAction:type_ActionSale];
    [self displayNormalButtonState:((UIButton*) sender)];
}

- (IBAction)actionCompetionor:(id)sender {
    [self loadDataWithTypeAction:type_Competionor];
    [self displayNormalButtonState:((UIButton*) sender)];
}

- (IBAction)actionSupport:(id)sender {
    [self loadDataWithTypeAction:type_Support];
    [self displayNormalButtonState:((UIButton*) sender)];
}


#pragma mark display color button
-(void) displayNormalButtonState : (UIButton*) btnSelect {
    
    for (UIView *viewTemp in self.rightViewHeader.subviews) {
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            [((UIButton*) viewTemp) setBackgroundColor:backgroundButtonNormal];
            [((UIButton*) viewTemp) setTitleColor:textColorButtonNormal forState:UIControlStateNormal];
        }
    }
    
    [btnSelect setBackgroundColor:backgrondButtonSelected];
    [btnSelect setTitleColor:textColorButtonSelected forState:UIControlStateNormal];
    
    
}


#pragma mark table view

#pragma mark - Table View


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (typeActionEvent) {
        case type_ProposeProduct:{
            return 50.0f;
        }break;
        
        case type_ClueContact:{
            return 50.0f;
        }
            break;
        default:
            break;
    }
    return 100.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberofrows = %d", arrayData.count);
    
    return  arrayData.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (typeActionEvent) {
        case type_ActionSale:
        {
            static NSString *cellId = @"proposeProductCell";
            ProposeProductCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [ProposeProductCell getNewCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
        case type_ClueContact:{
            static NSString *cellId = @"ClueContactCell";
            ClueContactCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                
                cell = [ClueContactCell getNewCell ];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
            case type_Competionor:
        {
            static NSString *cellId = @"competionorCell";
            CompetionorCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [CompetionorCell getNewCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
            case type_ProposeProduct:
        {
            static NSString *cellId = @"proposeProductCell";
            ProposeProductCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [ProposeProductCell getNewCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
            case type_Support:
        {
            static NSString *cellId = @"proposeProductCell";
            ProposeProductCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [ProposeProductCell getNewCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
        default:
            break;
    }
    
    UITableViewCell *cellNull = [[UITableViewCell alloc] init];
    return cellNull;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection){
        
        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
    
    switch (typeActionEvent) {
        case type_ActionSale:
            
            break;
            case type_ClueContact:
            break;
            case type_Competionor:
            break;
            case type_ProposeProduct:
            break;
            case type_Support:
            break;
        default:
            break;
    }
}

//Thêm phần sửa, xoá hiển thị trên row của table

@end
