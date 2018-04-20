//
//  ImageFunctions.m
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 24-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "ImageFunctions.h"
#import <QuartzCore/QuartzCore.h>

@implementation ImageFunctions

+ (void)saveImage:(UIImage*)image withTitle:(NSString *)title {
    
    if (image != nil) {
        
        NSString *path = [self pathForImageWithTitle:title];
        NSData *data = UIImageJPEGRepresentation(image, 0.4);
        [data writeToFile:path atomically:YES];
        
    }
    
}

+ (UIImage*)loadImageWithTitle:(NSString *)title {
    
    NSString *path = [self pathForImageWithTitle:title];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]) {
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        return image;
    } else {
        return nil;
    }
    
}

+ (NSString *)pathForImageWithTitle:(NSString *)title {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", title];
    NSString *path = [documentsDirectory stringByAppendingPathComponent: fileName];
    return path;
    
}

+ (void)removeImageNamed:(NSString *)title {
    
    NSString *path = [self pathForImageWithTitle:title];
    [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
    
}

@end
