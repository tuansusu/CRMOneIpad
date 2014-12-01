//
//  WCGridViewCell.h
//  StandingHere
//
//  Created by Wess Cope on 5/3/12.
//  Copyright (c) 2012 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "BACommon.h"
#import "BALabel.h"

@protocol UIWCGridViewCellDelegate <NSObject>
@optional
-(void) showTaoVaGiaoViec : (NSMutableDictionary *) dataDic;
-(void) showGiaoViecTuCV : (NSMutableDictionary *) dataDic;
-(void) showChuyenCVchoDV : (NSMutableDictionary *) dataDic;
-(void) showChuyenCVcanhan : (NSMutableDictionary *) dataDic;
-(void) openDocumentWithFileName : (NSString *) fileName andFilePath :(NSString *) filePath andDic :(NSMutableDictionary *) dataDic;
-(void) tapToCell : (NSMutableDictionary *) dataDic atCell : (UIView *) cell;
-(void) showMoreInfor : (NSMutableDictionary *) dataDic atCell : (UIView *) cell;
@end

@interface WCGridViewCell : UIView
//@property (strong, nonatomic) IBOutlet UILabel       *titleLabel;
@property (readonly, nonatomic) NSString    *reuseIdentifier;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackBround;
@property (weak, nonatomic) IBOutlet UITableView *tableListFileDoc;

@property(weak, nonatomic) id <UIWCGridViewCellDelegate> delegateGridCell;

@property (weak, nonatomic) IBOutlet UILabel *lblLabelNguoiKy;


@property (weak, nonatomic) IBOutlet UIView *viewBorderCenter;

@property (weak, nonatomic) IBOutlet BALabel *lbTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet BALabel *lbSigner;

@property (nonatomic, retain) NSArray *fileNameArr;
@property (nonatomic, retain) NSArray *filePathArr;
@property (nonatomic, retain) NSMutableDictionary *dataSend;

@property (weak, nonatomic) IBOutlet UIImageView *imgIsRead;
@property (weak, nonatomic) IBOutlet UIButton *btnTapToCell;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (strong, nonatomic) IBOutlet UILabel *lbSign;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;



- (IBAction)actionTapToCell:(id)sender;
- (IBAction)action_infor:(id)sender;


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
