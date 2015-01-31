//
//  SubListViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/26/14.
//
//

#import "SubListViewCell.h"
#import "DTOWidgetObject.h"
#import "Globals.h"
#import "DTOACCOUNTProcess.h"
#import "DTOACCOUNTLEADProcess.h"

@implementation SubListViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:Nil] objectAtIndex:0];
    }
    return self;
}

+(SubListViewCell*) initNibCell{

    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SubListViewCell" owner:nil options:nil];

    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[SubListViewCell class]])
        {
            return (SubListViewCell *) curentObject;

        }
    }
    
    return nil;
}

-(void) loadDataToCellWithData:(NSDictionary *)dicData WithWidgetObject:(DTOWidgetObject*)widgetOB{

    NSString *title = @"";
    NSString *description=@"";
    NSString *time;

    if ([widgetOB.widgetId intValue]==WIDGET_TYPE_TONG_HOP)
    {
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_title]]) {
            title = @"";

        }else{
            title = [dicData objectForKey:DTONOTE_title];
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_content]]) {
            description = @"";

        }else{
            description = [dicData objectForKey:DTONOTE_content];
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_updatedDate]]) {
            time = @"";
        }else{
            time = [dicData objectForKey:DTONOTE_updatedDate ] ;
        }

    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_GHI_CHU)
    {
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_title]]) {
            title = @"";

        }else{
            title = [dicData objectForKey:DTONOTE_title];
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_content]]) {
            description = @"";

        }else{
            description = [dicData objectForKey:DTONOTE_content];
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_updatedDate]]) {
            time = @"";
        }else{
            time = [dicData objectForKey:DTONOTE_updatedDate ] ;
        }

    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_TKH_TIEN_GUI)
    {
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOPRODUCTDETAIL_clientId]]) {
            title = @"";

        }else{
            title = [dicData objectForKey:DTOPRODUCTDETAIL_clientId];
        }

        DTOACCOUNTProcess *dtoAccoutProcess = [DTOACCOUNTProcess new];
        NSDictionary *dicDataAccount= [dtoAccoutProcess getDataWithKey:DTOACCOUNT_clientAccountId withValue:[dicData objectForKey:DTOPRODUCTDETAIL_clientId]];
        if (dicDataAccount) {
            if ([StringUtil stringIsEmpty:[dicDataAccount objectForKey:DTOACCOUNT_name]]) {
                description = @"";

            }else{
                description = [dicDataAccount objectForKey:DTOACCOUNT_name];
            }
        }else
        {
            DTOACCOUNTLEADProcess *dtoAccoutLeadProcess = [DTOACCOUNTLEADProcess new];
            dicDataAccount= [dtoAccoutLeadProcess getDataWithKey:DTOLEAD_clientLeadId withValue:[dicData objectForKey:DTOPRODUCTDETAIL_clientId]];
            if (dicDataAccount) {
                if ([StringUtil stringIsEmpty:[dicDataAccount objectForKey:DTOLEAD_name]]) {
                    description = @"";

                }else{
                    description = [dicDataAccount objectForKey:DTOLEAD_name];
                }
            }
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOPRODUCTDETAIL_BalanceSum]]) {
            time = @"";
        }else{
            time = [dicData objectForKey:DTOPRODUCTDETAIL_BalanceSum];
        }

    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_TKH_TIN_DUNG)
    {
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOPRODUCTDETAIL_clientId]]) {
            title = @"";

        }else{
            title = [dicData objectForKey:DTOPRODUCTDETAIL_clientId];
        }
        DTOACCOUNTProcess *dtoAccoutProcess = [DTOACCOUNTProcess new];
        NSDictionary *dicDataAccount= [dtoAccoutProcess getDataWithKey:DTOACCOUNT_clientAccountId withValue:[dicData objectForKey:DTOPRODUCTDETAIL_clientId]];
        if (dicDataAccount) {
            if ([StringUtil stringIsEmpty:[dicDataAccount objectForKey:DTOACCOUNT_name]]) {
                description = @"";

            }else{
                description = [dicDataAccount objectForKey:DTOACCOUNT_name];
            }
        }else
        {
            DTOACCOUNTLEADProcess *dtoAccoutLeadProcess = [DTOACCOUNTLEADProcess new];
            dicDataAccount= [dtoAccoutLeadProcess getDataWithKey:DTOLEAD_clientLeadId withValue:[dicData objectForKey:DTOPRODUCTDETAIL_clientId]];
            if (dicDataAccount) {
                if ([StringUtil stringIsEmpty:[dicDataAccount objectForKey:DTOLEAD_name]]) {
                    description = @"";

                }else{
                    description = [dicDataAccount objectForKey:DTOLEAD_name];
                }
            }
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOPRODUCTDETAIL_BalanceSum]]) {
            time = @"";
        }else{
            time = [dicData objectForKey:DTOPRODUCTDETAIL_BalanceSum];
        }

    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_Y_KIEN_KH)
    {
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCOMPLAIN_content]]) {
            title = @"";

        }else{
            title = [dicData objectForKey:DTOCOMPLAIN_content];
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCOMPLAIN_receivedDate]]) {
            description = @"";

        }else{
            description = [dicData objectForKey:DTOCOMPLAIN_receivedDate];
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOCOMPLAIN_status]]) {
            time = @"";
        }else{
            time = [dicData objectForKey:DTOCOMPLAIN_status ];
            if ([time isEqualToString:@"0"]) {
                time = SYS_TITLE_STATUS_COMPLAIN_NOT_PROCESSED;
            }else{
                time = SYS_TITLE_STATUS_COMPLAIN_PROCESSED;
            }
        }
    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_THEO_DOI)
    {
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_title]]) {
            title = @"";

        }else{
            title = [dicData objectForKey:DTONOTE_title];
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_content]]) {
            description = @"";

        }else{
            description = [dicData objectForKey:DTONOTE_content];
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_updatedDate]]) {
            time = @"";
        }else{
            time = [dicData objectForKey:DTONOTE_updatedDate ] ;
        }
        
    }else if ([widgetOB.widgetId intValue]==WIDGET_TYPE_SU_KIEN_SAP_DIEN_RA)
    {
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_title]]) {
            title = @"";

        }else{
            title = [dicData objectForKey:DTONOTE_title];
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_content]]) {
            description = @"";

        }else{
            description = [dicData objectForKey:DTONOTE_content];
        }

        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_updatedDate]]) {
            time = @"";
        }else{
            time = [dicData objectForKey:DTONOTE_updatedDate ] ;
        }

    }

    lblTitle.text = title;
    lblDescription.text = description;
    lblTime.text = time;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
