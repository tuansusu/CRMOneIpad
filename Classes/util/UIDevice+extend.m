//
//  UIDevice+extend.m
//  Voffice2.1
//
//  Created by VTIT on 10/4/13.
//
//

#import "UIDevice+extend.h"
#import <sys/utsname.h>
#include <net/if_dl.h>
#include <netinet/in.h>
#include <ifaddrs.h>
#import <CommonCrypto/CommonDigest.h>

@implementation UIDevice (extend)

static NSString* modelName;
static CGSize screenSize;
static float currSysVerInt;

+(float) getCurrentSysVer{
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        currSysVerInt = [currSysVer floatValue];
    });
    return currSysVerInt;
}

+ (CGSize) getScreenSize
{
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        screenSize = [[UIScreen mainScreen] bounds].size;
    });
    return screenSize;
    
}
+ (NSString*) getModel
{
    static dispatch_once_t onceToken = 0;
    //Luôn chỉ gọi một lần và chỉ một lần !
    dispatch_once(&onceToken, ^{
        
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *temp = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
        
        
        NSDictionary *commonNamesDictionary =
        @{
          @"i386":     @"ipad",
          @"x86_64":   @"ipad",
          @"iPhone1,1":    @"iPhone",
          @"iPhone1,2":    @"iPhone 3G",
          @"iPhone2,1":    @"iPhone 3GS",
          @"iPhone3,1":    @"iPhone 4",
          @"iPhone3,2":    @"iPhone 4(Rev A)",
          @"iPhone3,3":    @"iPhone 4(CDMA)",
          @"iPhone4,1":    @"iPhone 4S",
          @"iPhone5,1":    @"iPhone 5(GSM)",
          @"iPhone5,2":    @"iPhone 5(GSM+CDMA)",
          
          @"iPad1,1":  @"iPad",
          @"iPad2,1":  @"iPad 2(WiFi)",
          @"iPad2,2":  @"iPad 2(GSM)",
          @"iPad2,3":  @"iPad 2(CDMA)",
          @"iPad2,4":  @"iPad 2(WiFi Rev A)",
          @"iPad2,5":  @"iPad Mini(WiFi)",
          @"iPad2,6":  @"iPad Mini(GSM)",
          @"iPad2,7":  @"iPad Mini(GSM+CDMA)",
          @"iPad3,1":  @"iPad 3(WiFi)",
          @"iPad3,2":  @"iPad 3(GSM+CDMA)",
          @"iPad3,3":  @"iPad 3(GSM)",
          @"iPad3,4":  @"iPad 4(WiFi)",
          @"iPad3,5":  @"iPad 4(GSM)",
          @"iPad3,6":  @"iPad 4(GSM+CDMA)",
          @"iPad4,1":  @"iPad Air(Wifi)",
          @"iPad4,2":  @"iPad Air(GSM+CDMA)",
          @"iPad4,4":  @"iPad Mini 2(Wifi)",
          @"iPad4,5":  @"iPad Mini 2(GSM+CDMA)",
          
          @"iPod1,1":  @"iPod 1st Gen",
          @"iPod2,1":  @"iPod 2nd Gen",
          @"iPod3,1":  @"iPod 3rd Gen",
          @"iPod4,1":  @"iPod 4th Gen",
          @"iPod5,1":  @"iPod 5th Gen"};
        
        modelName =  commonNamesDictionary[temp];
        
    });
    return modelName;
}

+(void) updateLayoutInIOs7OrAfter : (UIViewController *)viewController{
    CGRect tempRect;
    for(UIView *sub in [[viewController view] subviews])
    {
        tempRect = [sub frame];
        tempRect.origin.y += 20.0f; //Height of status bar
        [sub setFrame:tempRect];
    }
}

+ (NSString *) macAddress:(NSString *)delimiter {
    
    int	result;
	struct ifaddrs	*ifbase, *ifiterator;
	
	result = getifaddrs(&ifbase);
	ifiterator = ifbase;
    NSString *macAddress;
    
    while (!result && (ifiterator != NULL))
	{
        NSString* interface_name = [NSString stringWithFormat:@"%s", ifiterator->ifa_name];
        
        if ([interface_name isEqualToString:@"en0"] && ifiterator->ifa_addr->sa_family == AF_LINK)
        {
            struct sockaddr_dl* dlAddr;
			dlAddr = (struct sockaddr_dl *)(ifiterator->ifa_addr);
            unsigned char mac_address[6];
            memcpy(mac_address, &dlAddr->sdl_data[dlAddr->sdl_nlen], 6);
            
            macAddress =
            [NSString stringWithFormat:@"%02X%@%02X%@%02X%@%02X%@%02X%@%02X"
             , mac_address[0], delimiter, mac_address[1], delimiter, mac_address[2], delimiter
             , mac_address[3], delimiter, mac_address[4], delimiter, mac_address[5]];
            
            break;
            
        }
        
        ifiterator = ifiterator->ifa_next;
    }
    
    return macAddress;
}

+ (NSString *)uniqueDeviceIdentifier {
    
    // Create pointer to the string as UTF8
    const char *ptr = [[self macAddress:@""] UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char hashedChars[CC_SHA256_DIGEST_LENGTH];
    
    // Hash pointer to hashedChars array
    CC_SHA256(ptr, CC_SHA256_DIGEST_LENGTH, hashedChars);
    
    // Convert SHA256 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString string];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        
        [output appendFormat:@"%02x",hashedChars[i]];
        
    }
    
    // add dashes
    [output insertString:@"-" atIndex:8];
    [output insertString:@"-" atIndex:13];
    [output insertString:@"-" atIndex:18];
    [output insertString:@"-" atIndex:23];
    [output insertString:@"-" atIndex:36];
    [output insertString:@"-" atIndex:49];
    [output insertString:@"-" atIndex:54];
    [output insertString:@"-" atIndex:59];
    [output insertString:@"-" atIndex:64];
    
    return [output uppercaseString];
    
}

@end
