//
//  Language.m
//  OfficeOneIpad
//
//  Created by Đỗ Dũng on 8/22/14.
//
//

#import "Language.h"

@implementation Language
@synthesize str;
static Language *instance = nil;
+(Language *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [Language new];
        }
    }
    return instance;
}
@end
