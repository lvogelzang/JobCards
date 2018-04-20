//
//  JobView.m
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 15-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "JobView.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageFunctions.h"

@implementation JobView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    UIFont *defaultFont = [UIFont systemFontOfSize:14];
    
    if (self) {
        
        // Create what label.
        self.whatLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        [self.whatLabel setText:@"Wat:"];
        [self.whatLabel setFont:defaultFont];
        [self addSubview:self.whatLabel];
        
        // Create what text view.
        self.whatView = [[UITextView alloc] initWithFrame:CGRectMake(120, 0, 190, 60)];
        [self setTextViewStyle:self.whatView];
        [self addSubview:self.whatView];
        [self.whatView setFont:defaultFont];
        
        // Create with label.
        self.withLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 100, 30)];
        [self.withLabel setText:@"Met wat:"];
        [self.withLabel setFont:defaultFont];
        [self addSubview:self.withLabel];
        
        // Create with field.
        self.withField = [[UITextField alloc] initWithFrame:CGRectMake(120, 80, 190, 30)];
        [self.withField setBorderStyle:UITextBorderStyleRoundedRect];
        [self.withField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self addSubview:self.withField];
        [self.withField setFont:defaultFont];
        
        // Create basicCondition label.
        self.basicConditionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 120, 30)];
        [self.basicConditionLabel setText:@"Basisconditie:"];
        [self.basicConditionLabel setFont:defaultFont];
        [self addSubview:self.basicConditionLabel];
        
        // Create basicCondition view.
        self.basicConditionView = [[UITextView alloc] initWithFrame:CGRectMake(120, 130, 190, 60)];
        [self setTextViewStyle:self.basicConditionView];
        [self addSubview:self.basicConditionView];
        [self.basicConditionView setFont:defaultFont];
        
        // Create action label.
        self.actionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, 120, 30)];
        [self.actionLabel setText:@"Actie:"];
        [self.actionLabel setFont:defaultFont];
        [self addSubview:self.actionLabel];
        
        // Create action view.
        self.actionView = [[UITextView alloc] initWithFrame:CGRectMake(120, 210, 190, 60)];
        [self setTextViewStyle:self.actionView];
        [self addSubview:self.actionView];
        [self.actionView setFont:defaultFont];
        
        // Create image label.
        self.imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 290, 120, 30)];
        [self.imageLabel setText:@"Foto:"];
        [self.imageLabel setFont:defaultFont];
        [self addSubview:self.imageLabel];
        
        // Create take picture button.
        self.takePictureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.takePictureButton setFrame:CGRectMake(120, 292, 84, 30)];
        [self.takePictureButton setTitle:@"Maak foto" forState:UIControlStateNormal];
        [self.takePictureButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [self addSubview:self.takePictureButton];
        
        // Create take picture button.
        self.choosePictureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.choosePictureButton setFrame:CGRectMake(120, 328, 78, 30)];
        [self.choosePictureButton setTitle:@"Kies foto" forState:UIControlStateNormal];
        [self.choosePictureButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [self addSubview:self.choosePictureButton];
        
        // Create image button.
        self.imageButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 290, 100, 70)];
        [self.imageButton setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:self.imageButton];
        
    }
    
    return self;
    
}

- (void)setTextViewStyle:(UITextView *)textView {
    
    [textView setBackgroundColor:[UIColor whiteColor]];
    [textView setFont:[UIFont systemFontOfSize:17]];
    [textView setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textView.layer setBorderColor:[UIColor colorWithWhite:0.8 alpha:1.0].CGColor];
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
        [textView.layer setBorderWidth:0.5];
        [textView.layer setCornerRadius:5.0];
    } else {
        [textView.layer setBorderWidth:1.0];
        [textView.layer setCornerRadius:9.0];
    }
    
}

- (void)updateJobView:(Job *)job {
    
    [self.whatView setText:job.what];
    [self.withField setText:job.with];
    [self.basicConditionView setText:job.basicCondition];
    [self.actionView setText:job.action];
    
    NSString *title = [NSString stringWithFormat:@"image%ld%ld", (long)job.jobCardid, (long)job.id];
    NSString *thumbTitle = [NSString stringWithFormat:@"%@%@", title, @"t"];
    
    UIImage *image = [ImageFunctions loadImageWithTitle:title];
    UIImage *thumb = [ImageFunctions loadImageWithTitle:thumbTitle];
    
    [job setImage:image];
    [job setThumb:thumb];
    
    [self updateImageForJob:job];
    
}

- (void)updateImageForJob:(Job *)job {
    
    if ((long)job.thumb) {
        
        [self.imageButton setHidden:false];
        
        float width = job.thumb.size.width;
        float height = job.thumb.size.height;
        float ratio = width/height;
        
        if (ratio > (100/70)) {
            width = 100;
            height = width / ratio;
        } else {
            height = 70;
            width = height * ratio;
        }
        
        CGSize destinationSize = CGSizeMake(2*width, 2*height);
        UIGraphicsBeginImageContext(destinationSize);
        [job.thumb drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.imageButton setBackgroundImage:newImage forState:UIControlStateNormal];
        [self.imageButton setFrame:CGRectMake(self.imageButton.frame.origin.x, self.imageButton.frame.origin.y, width, height)];
        
        NSInteger buttonX = self.imageButton.frame.origin.x + self.imageButton.frame.size.width + 10;
        
        [self.takePictureButton setFrame:CGRectMake(buttonX, 290, 84, 30)];
        [self.choosePictureButton setFrame:CGRectMake(buttonX, 330, 78, 30)];
        
    } else {
        
        [self.imageButton setBackgroundImage:nil forState:UIControlStateNormal];
        [self.imageButton setFrame:CGRectMake(120, 290, 100, 70)];
        [self.imageButton setHidden:true];
        [self.takePictureButton setFrame:CGRectMake(120, 290, 84, 30)];
        [self.choosePictureButton setFrame:CGRectMake(120, 330, 78, 30)];
        
    }
    
}

@end
