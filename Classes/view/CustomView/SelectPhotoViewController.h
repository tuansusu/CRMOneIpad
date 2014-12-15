//
//  SelectPhotoViewController.h
//  OfficeOneMB
//
//  Created by viettel on 12/12/14.
//
//

#import <UIKit/UIKit.h>

@protocol SelectPhotoDelegate <NSObject>

-(void) selectPhoto : (NSString*) fileName;

@end

@interface SelectPhotoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak,nonatomic) id <SelectPhotoDelegate> delegate;
/*
 * khi tao moi hay sua 1 ban ghi co chon lai anh 
 * se luu anh lay ten bang _ id local cua anh _ time yyyyMMdd_HHmmss
 * (typeImage) luu ten thu muc anh luon - neu chua co thi se tao moi
 */
@property (nonatomic, retain) NSString *typeImage;


@property (nonatomic) NSInteger index;

/*
 * Cho phep chon nhieu anh 1 luc hay khong?
 */
@property (nonatomic) BOOL isMulti;


//control

@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@property (nonatomic, retain) IBOutlet UIButton * choosePhotoBtn;
@property (nonatomic, retain) IBOutlet UIButton * takePhotoBtn;

-(IBAction) getPhoto:(id) sender;

@end
