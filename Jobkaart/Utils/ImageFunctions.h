//
//  ImageFunctions.h
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 24-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ImageFunctions : NSObject

+ (void)saveImage: (UIImage*)image withTitle: (NSString *)title;
+ (UIImage*)loadImageWithTitle: (NSString *)title;
+ (NSString *)pathForImageWithTitle: (NSString *)title;
+ (void)removeImageNamed:(NSString *)title;

@end
