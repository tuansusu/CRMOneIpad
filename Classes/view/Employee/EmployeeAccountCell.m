//
//  EmployeeAccountCell.m
//  OfficeOneStudy
//
//  Created by viettel on 10/31/14.
//
//

#import "EmployeeAccountCell.h"

@implementation EmployeeAccountCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) loadDataToCell : (NSDictionary *) data{
    self.lbAccountID.text = [data objectForKey:DTOEMPLOYEEACCOUNT_id];
    self.lbLeaderID.text = [data objectForKey:DTOEMPLOYEEACCOUNT_leadId];
}

@end
