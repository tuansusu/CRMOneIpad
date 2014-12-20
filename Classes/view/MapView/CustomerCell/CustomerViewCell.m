//
//  CustomerViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/17/14.
//
//

#import "CustomerViewCell.h"
#import "DTOAcountLeadProcessObject.h"

@implementation CustomerViewCell

+(CustomerViewCell*) initNibCell{

    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomerViewCell" owner:nil options:nil];

    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[CustomerViewCell class]])
        {
            return (CustomerViewCell *) curentObject;

        }
    }

    return nil;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void) loadDataToCellWithCustomerOB:(DTOAcountLeadProcessObject *)customerOB withStatus:(NSString *)status{
    if ([status isEqual:@"YES"]) {
        [btnDirection setImage:[UIImage imageNamed:@"iconDirectionSelected"] forState:UIControlStateNormal];
        _isCellSelected = YES;
    }else{
        [btnDirection setImage:[UIImage imageNamed:@"iconDirection"] forState:UIControlStateNormal];
        _isCellSelected = NO;
    }
    if (customerOB.name) {
        lblName.text = customerOB.name;
    }
}

-(IBAction)cellSelectedAtIndex:(id)sender{
    NSString *statusSelect;
    if (_isCellSelected) {
        [btnDirection setImage:[UIImage imageNamed:@"iconDirection"] forState:UIControlStateNormal];
        _isCellSelected= NO;
        statusSelect = @"NO";
    }else{
        [btnDirection setImage:[UIImage imageNamed:@"iconDirectionSelected"] forState:UIControlStateNormal];
        _isCellSelected = YES;
        statusSelect = @"YES";
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedAtCell: withStatus:)]) {
        [_delegate didSelectedAtCell:self withStatus:statusSelect];
    }
}

@end
