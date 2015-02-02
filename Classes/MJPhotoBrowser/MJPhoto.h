
#import <Foundation/Foundation.h>

@interface MJPhoto : NSObject
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIImageView *srcImageView;
@property (nonatomic, strong, readonly) UIImage *placeholder;
@property (nonatomic, strong, readonly) UIImage *capture;

@property (nonatomic, assign) BOOL firstShow;

@property (nonatomic, assign) BOOL save;
@property (nonatomic, assign) int index; 
@end