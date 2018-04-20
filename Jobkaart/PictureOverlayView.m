//
//  PictureOverlayView.m
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 29-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "PictureOverlayView.h"

@implementation PictureOverlayView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return self.subviews[0];
    }
    return nil;
}

@end
