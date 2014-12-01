//
//  CompetitorsViewController.h
//  OfficeOneStudy
//
//  Created by viettel on 11/7/14.
//
//

#import "BaseViewController.h"
#import "CompetionorCell.h"
#import "ProposeProductCell.h"
#import "ClueContactCell.h"


enum TypeActionEvent{
    type_ClueContact, //clue contact(Đầu mối liên hệ)
    type_ProposeProduct, //propose product (sản phẩm đề xuất)
    type_ActionSale, //action sale
    type_Competionor, // Competionor(Đối thủ cạnh tranh)
    type_Support // Support
};


@interface CompetitorsViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic) enum TypeActionEvent typeActionEvent;


//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;

@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *leftInMainView;

@property (weak, nonatomic) IBOutlet UIView *leftViewHeader;

@property (weak, nonatomic) IBOutlet UILabel *leftLabelHeader;


@property (weak, nonatomic) IBOutlet UIView *rightInMainView;
@property (weak, nonatomic) IBOutlet UIView *rightViewHeader;

#pragma  mark righview button

@property (weak, nonatomic) IBOutlet UIButton *btnClueContact;

@property (weak, nonatomic) IBOutlet UIButton *btnProposeProduct;

@property (weak, nonatomic) IBOutlet UIButton *btnActionSale;

@property (weak, nonatomic) IBOutlet UIButton *btnCompetionor;

@property (weak, nonatomic) IBOutlet UIButton *btnSupport;


- (IBAction)actionClueContact:(UIButton *)sender;

- (IBAction)actionProposeProduct:(UIButton *)sender;

- (IBAction)actionActionSale:(id)sender;

- (IBAction)actionCompetionor:(id)sender;

- (IBAction)actionSupport:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tbData;



@end
