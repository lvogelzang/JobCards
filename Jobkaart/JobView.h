//
//  JobView.h
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 15-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"

@interface JobView : UIView

@property UILabel *whatLabel;
@property UITextView *whatView;

@property UILabel *withLabel;
@property UITextField *withField;

@property UILabel *basicConditionLabel;
@property UITextView *basicConditionView;

@property UILabel *actionLabel;
@property UITextView *actionView;

@property UILabel *imageLabel;
@property UIButton *imageButton;
@property UIButton *takePictureButton;
@property UIButton *choosePictureButton;

- (void)updateJobView:(Job *)job;

@end
