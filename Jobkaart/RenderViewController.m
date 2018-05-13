//
//  PDFViewController.m
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 20-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "RenderViewController.h"
#import "JobCardRenderer.h"

@implementation RenderViewController

- (void)viewDidLoad {
    [self createPDF:_jobCard];
    [_pdfView.scrollView setClipsToBounds:false];
    [_pdfView.scrollView setShowsHorizontalScrollIndicator:NO];
    [_pdfView.scrollView setShowsVerticalScrollIndicator:NO];
    [_pdfView setBackgroundColor:[UIColor whiteColor]];
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

- (IBAction)usePDF:(id)sender {
    [self createPDF:_jobCard];
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
