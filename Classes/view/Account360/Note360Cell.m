//
//  Note360Cell.m
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/22/14.
//
//

#import "Note360Cell.h"
#import "DTOATTACHMENTProcess.h"


DTOATTACHMENTProcess *dtoAttachProcess ;
NSMutableArray *arrayData;

@implementation Note360Cell

- (void)awakeFromNib
{
    // Initialization code
}

+(Note360Cell*) initNibCell{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Note360Cell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[Note360Cell class]])
        {
            return (Note360Cell *) curentObject;
            
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
    
    dtoAttachProcess = [DTOATTACHMENTProcess new];
    arrayData=[NSMutableArray new];
    
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
    
    arrayData = [dtoAttachProcess filterWithKey:DTOATTACHMENT_clientObjectId withValue:[dicData objectForKey:DTONOTE_clientNoteId]];
    NSLog(@"count: %i",arrayData.count);
    if(arrayData.count >0){
        NSLog(@"Có file đính kèm");
        UIImage *image=[UIImage imageNamed:@"attach_icon.png"];
        [self.imgFile setImage:image];
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
