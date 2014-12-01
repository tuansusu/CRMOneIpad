//
//  FileManagerUtil.m
//  Voffice2.1
//
//  Created by Tran Van Bang on 8/7/13.
//
//

#import "FileManagerUtil.h"

@implementation FileManagerUtil

+ (BOOL) checkExitFileWithName : (NSString *) fileName
{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [documentsPath stringByAppendingPathComponent:fileName];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    
    return fileExists;
}

+ (void) removeFileWithName : (NSString *) fileName
{
    if ([FileManagerUtil checkExitFileWithName:fileName]) {
        NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* deteleFile = [documentsPath stringByAppendingPathComponent:fileName];
        //NSLog(@"deteleFile = %@",deteleFile);
        [[NSFileManager defaultManager] removeItemAtPath: deteleFile error: nil];
    }
   

}


+ (void) removeFilesFromDocuments {
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	NSFileManager* fm = [[NSFileManager alloc] init];
	NSDirectoryEnumerator* en = [fm enumeratorAtPath:path];
	NSError* err = nil;
	BOOL res;
	NSString* file;
	while (file = [en nextObject]) {
        
		if ([file rangeOfString:Introduction_File_Pdf].location == NSNotFound && [file rangeOfString:@".txt"].location == NSNotFound) {
			res = [fm removeItemAtPath:[path stringByAppendingPathComponent:file] error:&err];
			if (!res && err) {
				//NSLog(@"oops: %@", err);
			}
		}
	}
}

+ (NSString *) encryptFileWithPath:(NSString *) filePath andPassword:(NSString *)password
{
    
    //NSLog(@"usernam = %@",userId);
    [EncryptBase64 initialize];
    NSData * pdfData = [NSData dataWithContentsOfFile:filePath];
    NSString* theFileName = [filePath lastPathComponent];
    NSData *encryptedDataPDF = [pdfData AESEncryptWithPassphrase:password];
    NSString *b64EncStrPDF = [EncryptBase64 encode:encryptedDataPDF];
    NSData *pdfDataEncrypt = [b64EncStrPDF dataUsingEncoding: NSUTF8StringEncoding];
    NSString *thePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    thePath = [thePath stringByAppendingPathComponent:[NSString stringWithFormat: @"%@_%@",ENCRYPTED,theFileName]];
    //NSLog(@"time 2 = %@",currentDate);
    [pdfDataEncrypt writeToFile:thePath atomically:YES];
    NSData *pdfDataDeCrypt = [NSData dataWithContentsOfFile:thePath];
    NSString *pdfStrDeCrypt = [[NSString alloc] initWithData:pdfDataDeCrypt encoding:NSUTF8StringEncoding];
    NSData	*b64DecDataPDF = [EncryptBase64 decode:pdfStrDeCrypt];
    NSData *decryptedDataPDF = [b64DecDataPDF AESDecryptWithPassphrase:password];
    NSString *thePathDe = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    thePathDe = [thePathDe stringByAppendingPathComponent:[NSString stringWithFormat: @"%@_%@",DECRYPTED,theFileName]];
    [decryptedDataPDF writeToFile:thePathDe atomically:YES];
    return thePathDe;

}

+ (NSString *) decryptFileWithPathEncrypt:(NSString *) filePath andPassword:(NSString *)password
{
    //[EncryptBase64 initialize];
    //NSLog(@"pass = %@",password);
    NSString* theFileName = [filePath lastPathComponent];
    theFileName = [theFileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@_",ENCRYPTED] withString:@"" ];
    NSData *pdfDataDeCrypt = [NSData dataWithContentsOfFile:filePath];
    NSString *pdfStrDeCrypt = [[NSString alloc] initWithData:pdfDataDeCrypt encoding:NSUTF8StringEncoding];
    NSData	*b64DecDataPDF = [EncryptBase64 decode:pdfStrDeCrypt];
    NSData *decryptedDataPDF = [b64DecDataPDF AESDecryptWithPassphrase:password];
    NSString *thePathDe = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    thePathDe = [thePathDe stringByAppendingPathComponent:[NSString stringWithFormat: @"%@_%@",DECRYPTED,theFileName]];
    [decryptedDataPDF writeToFile:thePathDe atomically:YES];
    return thePathDe;
}


+(void) openDocumentWithFileName :(NSString *) fileName withPassword : (NSString*) password withSender : (id) sender
{
    
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    NSFileManager *man = [NSFileManager defaultManager];
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* filePath = [documentsPath stringByAppendingPathComponent:fileName];
    NSString *filePathDecrypt = [FileManagerUtil decryptFileWithPathEncrypt:filePath andPassword:password];
    NSDictionary *attrs = [man attributesOfItemAtPath: filePathDecrypt error: NULL];
    long long result = [attrs fileSize];
    //NSLog(@"file size = %lld",result);
    
    
    if (result > 0) {
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePathDecrypt password:phrase];
        
        if (document != nil)         {
            ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            
            readerViewController.delegate = (id<ReaderViewControllerDelegate>)self;
            
            
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
            
            [self.navigationController pushViewController:readerViewController animated:YES];
            
#else
            
            readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [sender presentViewController:readerViewController animated:YES completion:nil];
            
//            [self presentViewController:readerViewController animated:YES completion:nil];
            
            
#endif
            
        }
        
    }
    else
    {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:SYS_Notification_Warming message:SYS_Notification_FileNotExist delegate:nil cancelButtonTitle:@"Thoát" otherButtonTitles: nil];
        myAlert.tag =3;
        [myAlert show];
    }
    
}


@end
