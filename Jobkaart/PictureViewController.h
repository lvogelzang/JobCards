//
//  PictureViewController.h
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 29-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureOverlayView.h"

@interface PictureViewController : UIViewController <UIScrollViewDelegate>

@property PictureOverlayView *overlay;
@property UIScrollView *scrollView;
@property UIImage *image;
@property CGRect frame;

@end
