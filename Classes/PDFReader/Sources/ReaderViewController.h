//
//	ReaderViewController.h
//	Reader v2.7.1
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011-2013 Julius Oklamcak. All rights reserved.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//	of the Software, and to permit persons to whom the Software is furnished to
//	do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>

#import "ReaderDocument.h"
#import <MessageUI/MessageUI.h>
#import "ReaderDocument.h"
#import "ReaderContentView.h"
#import "ReaderMainToolbar.h"
#import "ReaderMainPagebar.h"
#import "ThumbsViewController.h"
#import "FileManagerUtil.h"
#import "ReaderViewControllerDelegate.h"

@class ReaderViewController;

//@protocol ReaderViewControllerDelegate <NSObject>
//
//@optional // Delegate protocols
//
//- (void)dismissReaderViewController:(ReaderViewController *)viewController;
//- (void)dismissBackReaderViewController:(UIViewController *)viewController;
//- (void) dismissWhenSuccess;
//
//@end

@interface ReaderViewController : UIViewController

@property (nonatomic, weak, readwrite) id <ReaderViewControllerDelegate> delegate;

@property (nonatomic, weak, readwrite) id <ReaderViewControllerDelegate> delegateBack;


//cai chi tinh cho cai document
@property (nonatomic, retain) NSString *documentId;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, assign) NSInteger pagingFile;
@property (nonatomic, retain) NSString *fileName;
@property (strong, nonatomic) ReaderContentView *rcv;
@property (nonatomic, retain) NSString *signerStr;
@property (nonatomic, retain) NSString *contentStr;
@property (nonatomic, retain) NSString *dateStr;
@property (nonatomic, retain) NSString *titleStr;
@property (nonatomic, retain) NSString *textId;
@property (nonatomic, retain) NSString *documentDrafId;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *signatureType;
@property (nonatomic, retain) NSString *mainStatus;
@property (nonatomic, retain) NSString *statusSign;
@property (nonatomic, retain) NSString *timeProcessing;
@property (nonatomic, assign) BOOL checkSignAlert;
@property (nonatomic, assign) BOOL checkLoadFile;

@property (nonatomic, retain) NSString *documentSendId;
@property (nonatomic, assign) BOOL isCommentEnable;
@property (nonatomic, assign) BOOL isViewComment;

@property (nonatomic, assign) BOOL signEnable;
@property (nonatomic, assign) BOOL isReadFromPoperview;
- (id)initWithReaderDocument:(ReaderDocument *)object;
- (id)initWithReaderDocument:(ReaderDocument *)object withReadFromPoperView : (BOOL) inputIsPoper;


@end
