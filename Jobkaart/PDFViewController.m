//
//  PDFViewController.m
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 20-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "PDFViewController.h"
#import "JobCardRenderer.h"

@interface PDFViewController ()
@end

@implementation PDFViewController

- (void)viewDidLoad {
    [self createPDF:_jobCard];
    [_container setBackgroundColor:_pdfView.scrollView.backgroundColor];
    [_pdfView setNavigationDelegate:self];
    [super viewDidLoad];
}

- (void)prepareForJobCard:(JobCard *)jobCard {
    _jobCard = jobCard;
}

- (void)createPDF:(JobCard*)jobCard {
    NSString* fileName = [self getPDFFileName];
    JobCardRenderer *renderer = [[JobCardRenderer alloc] init];
    [renderer savePDFFile:fileName withJobCard:jobCard];
    [self showPDFFile];
}

-(void)showPDFFile {
    NSString* fileName = [self getPDFFileName];
    NSURL *url = [NSURL fileURLWithPath:fileName];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_pdfView loadRequest:request];
}

- (NSString*)getPDFFileName {
    NSString* fileName = @"Jobkaart.pdf";
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    return pdfFileName;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"test");
    [self.view setBackgroundColor:_pdfView.scrollView.backgroundColor];
    [_container setBackgroundColor:_pdfView.scrollView.backgroundColor];
}

- (IBAction)usePDF:(id)sender {

}
//
//- (void)savePDF:(UIBarButtonItem *)sender {
//
//    NSString* fileName = @"Jobkaart.pdf";
//
//    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [arrayPaths objectAtIndex:0];
//    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
//
//    NSURL *pdfURL = [NSURL fileURLWithPath:pdfFileName];
//    self.docController = [UIDocumentInteractionController interactionControllerWithURL:pdfURL];
//
//    [self.docController presentOptionsMenuFromBarButtonItem:sender animated:true];
//
//}

@end
