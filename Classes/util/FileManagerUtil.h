//
//  FileManagerUtil.h
//  Voffice2.1
//
//  Created by Tran Van Bang on 8/7/13.
//
//

#import <Foundation/Foundation.h>
#import "EncryptBase64.h"
#import "NSData-AES.h"
#import "NSFileManager-AES.h"
#import "Base64.h"
#import "ReaderViewController.h"

@interface FileManagerUtil : NSObject

+ (BOOL) checkExitFileWithName : (NSString *) fileName;
+ (void) removeFileWithName : (NSString *) fileName;
+ (void) removeFilesFromDocuments ;

+ (NSString *) encryptFileWithPath :(NSString *) path andPassword : (NSString *) password;
+ (NSString *) decryptFileWithPathEncrypt:(NSString *) filePath andPassword:(NSString *)password;

+(void) openDocumentWithFileName :(NSString *) fileName withPassword : (NSString*) password withSender : (id) sender;

@end
