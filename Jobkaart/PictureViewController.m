//
//  PictureViewController.m
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 29-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "PictureViewController.h"

@interface PictureViewController ()
@end

@implementation PictureViewController
@synthesize image;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.97 alpha:1]];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Terug"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(undoPush)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 75, 700, 700)];
    
    int y = 65;
    int width = 320;
    int height = [[UIScreen mainScreen] bounds].size.height;
    self.overlay = [[PictureOverlayView alloc] initWithFrame:CGRectMake(0, y, width, height-y)];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.scrollView setContentSize:CGSizeMake(100, 100)];
    [self.scrollView setContentInset:UIEdgeInsetsZero];
    [self.scrollView setMinimumZoomScale:1.0];
    [self.scrollView setMaximumZoomScale:2.0];
    [self.scrollView setDelegate:self];
    [self.scrollView setScrollEnabled:true];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    [imageView setFrame:CGRectMake(0, 0, self.image.size.width, self.image.size.height)];
    
    [self.scrollView addSubview:imageView];
    [self.overlay addSubview:self.scrollView];
    
    [self.view addSubview:self.overlay];
    
    [self updateScrollViewInOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
}

- (void)undoPush {
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)viewWillLayoutSubviews {
    
    [self updateScrollViewInOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return scrollView.subviews[0];
    
}

- (void)updateScrollViewInOrientation:(UIInterfaceOrientation)orientation {
    
    [self.scrollView setContentInset:UIEdgeInsetsZero];
    
    if (self.scrollView.subviews.count == 0) {
        return;
    }
    
    float scrollWidth = 320;
    float scrollHeight = [[UIScreen mainScreen] bounds].size.height-65;
    
    [self.overlay setFrame:CGRectMake(0, 65, scrollWidth, scrollHeight)];
    [self.scrollView setFrame:CGRectMake(0, 65, scrollWidth, scrollHeight)];
    
    if (self.scrollView.subviews[0]) {
        
        UIImageView *imageView = self.scrollView.subviews[0];
        
        NSInteger x;
        NSInteger y;
        
        float width = self.image.size.width;
        float height = self.image.size.height;
        
        if (self.image.size.width > scrollWidth || self.image.size.height > scrollHeight) {
            
            float ratio = width/height;
            
            if (ratio > (scrollWidth / scrollHeight)) {
                width = scrollWidth;
                height = width / ratio;
            } else {
                height = scrollHeight;
                width = height * ratio;
            }
            
        } else {
            
            width = self.image.size.width;
            height = self.image.size.height;
            
        }
        
        x = (scrollWidth - width) / 2;
        y = (scrollHeight - height) / 2;
        
        [imageView setFrame:CGRectMake(0, 0, width, height)];
        [self.scrollView setClipsToBounds:false];
        [self.scrollView setFrame:CGRectMake(x, y, width, height)];
        [self.scrollView setContentSize:CGSizeMake(width, height)];
        [self.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(-y, x, -y, -x)];
        
    }
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    [self updateScrollViewInOrientation:toInterfaceOrientation];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

@end
