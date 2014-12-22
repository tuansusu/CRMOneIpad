//
//  FlowLeadViewController.h
//  OfficeOneMB
//
//  Created by ADMIN on 12/3/14.
//
//

#import "BaseViewController.h"
#import "SelectIndexViewController.h"

@interface FlowLeadViewController : BaseViewController


//DATA
/*
 * chuyen tu form danh sahc lien he(co ca clientLeaderId)
 */
@property (nonatomic, retain) NSDictionary *dataSend;

/*
 * chuyen tu form KHDM
 */
@property (nonatomic, retain) NSDictionary *dataRoot;

@property (weak, nonatomic) IBOutlet UIView *viewheader;

@property (weak, nonatomic) IBOutlet UILabel *lbTitel;

@property (weak, nonatomic) IBOutlet UIView *viewinfo;

@property (weak, nonatomic) IBOutlet UIView *viewmaininfo;


@property (weak, nonatomic) IBOutlet UITextField *txtMucDich;

@property (weak, nonatomic) IBOutlet UITextField *txtNgaybatdau;

@property (weak, nonatomic) IBOutlet UITextField *txtNgayhoanthanh;

@property (weak, nonatomic) IBOutlet UITextField *txtThoigiannhacnho;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)actionSave:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

- (IBAction)actionCancel:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnRemind;

- (IBAction)actionRemind:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnEmail;

- (IBAction)actionEmail:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSMS;

- (IBAction)actionSMS:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnHome;

- (IBAction)actionHome:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnChoseMucDich;

@property (weak, nonatomic) IBOutlet UIButton *btnCheckRemind;

- (IBAction)actionChoseTimeRemind:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnDateEnd;

- (IBAction)actionChoseDateEnd:(id)sender;

- (IBAction)actionChoseMucDic:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnDateStart;

- (IBAction)actionChoseDateStart:(id)sender;

////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;

@end
