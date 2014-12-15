//
//  NoteLeadCell.m
//  OfficeOneMB
//
//  Created by viettel on 12/8/14.
//
//

#import "NoteLeadCell.h"

@implementation NoteLeadCell

- (void)awakeFromNib
{
    // Initialization code
}

+(NoteLeadCell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NoteLeadCell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[NoteLeadCell class]])
        {
            return (NoteLeadCell *) curentObject;
            
        }
    }
    
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect{
    
    
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_title]]) {
        self.lbName.text = @"";
        
    }else{
        self.lbName.text = [dicData objectForKey:DTONOTE_title];
    }
    
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_content]]) {
        self.lbDescription.text = @"";
        
    }else{
        self.lbDescription.text = [dicData objectForKey:DTONOTE_content];
    }
    
    
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTONOTE_updatedDate]]) {
        self.lbTime.text = @"";
    }else{
        self.lbTime.text = [dicData objectForKey:DTONOTE_updatedDate ] ;
    }
    
    
    switch (smgSelect) {
        case 1:
        {
            for (UIView *viewTemp in self.contentView.subviews) {
                if ([viewTemp isKindOfClass:[UILabel class]]) {
                    ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
                }
            }
            self.lbName.textColor = TEXT_COLOR_HIGHLIGHT;
        }
            break;
            
        default:
            break;
    }
    
}

@end
