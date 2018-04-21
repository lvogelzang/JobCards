//
//  OverlayView.m
//  Jobkaart
//
//  Created by Lodewijck on 21/04/2018.
//  Copyright © 2018 Lodewijck. All rights reserved.
//

#import "OverlayView.h"

// Invisible view to redirect touch events outside of webview to the webview, to enable pinching outside webview bounds.
@implementation OverlayView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        // OverlayView should contain one webview as subview.
        if ([self.subviews count] == 1) {
            // Webview should contain only one scrollview as subview.
            if ([self.subviews[0].subviews count] == 1) {
                // Return scrollview.
                return self.subviews[0].subviews[0];
            } else {
                @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                               reason:[NSString stringWithFormat:@"Web view had %lu subviews instead of 1", (unsigned long)[self.subviews[0].subviews count]]
                                             userInfo:nil];
            }
        } else {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[NSString stringWithFormat:@"Overlay view had %lu subviews instead of 1", (unsigned long)[self.subviews count]]
                                         userInfo:nil];
        }
    } else {
        return nil;
    }
}

@end
