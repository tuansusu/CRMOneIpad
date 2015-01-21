//
//  Language.h
//  OfficeOneIpad
//
//  Created by Đỗ Dũng on 8/22/14.
//
//

#import <Foundation/Foundation.h>

@interface Language : NSObject{
    NSString *str;
}
@property(nonatomic,retain)NSString *str;
+(Language*)getInstance;

@end
