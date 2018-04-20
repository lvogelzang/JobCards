//
//  PDFViewController.h
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 20-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "JobCard.h"

@interface PDFViewController : UIViewController <WKNavigationDelegate>

//@property UIPopoverController *tpmPopoverController;
//@property UIDocumentInteractionController *docController;
@property JobCard *jobCard;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet WKWebView *pdfView;

- (void)prepareForJobCard:(JobCard *)jobCard;

@end
