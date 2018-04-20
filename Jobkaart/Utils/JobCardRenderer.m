//
//  PDFRenderer.m
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 26-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "JobCardRenderer.h"
#import "Job.h"

@implementation JobCardRenderer

- (void)savePDFFile:(NSString*)pdfFileName withJobCard:(JobCard*)jobCard {

    // Create the PDF context using the A5 page size of 298 x 420.
    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectMake(0, 0, 298, 420), nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 298, 420), nil);

    // Set colors for rectangles.
    UIColor *red = [UIColor colorWithRed:256.0 green:54.0/256.0 blue:53.0/256.0 alpha:1];
    UIColor *yellow = [UIColor colorWithRed:255.0/256.0 green:217.0/256.0 blue:100.0/256.0 alpha:1];
    UIColor *green = [UIColor colorWithRed:76.0/256.0 green:217.0/256.0 blue:100.0/256.0 alpha:1];
    UIColor *blue = [UIColor colorWithRed:52.0/256.0 green:170.0/256.0 blue:220.0/256.0 alpha:0.7];
    UIColor *gray = [UIColor colorWithWhite:0.97 alpha:1.0];
    UIColor *purple = [UIColor colorWithRed:228.0/256.0 green:183.0/256.0 blue:240.0/256.0 alpha:1];

    // Draw rectangles.
    [self drawRect:CGRectMake(0, 0, 210, 35) color:red];
    [self drawRect:CGRectMake(0, 35, 298, 28) color:gray];
    [self drawRect:CGRectMake(0, 385, 298, 35) color:green];

    // Draw header text.
    [self drawText:[NSString stringWithFormat:@"%ld", (long)jobCard.id] inRect:CGRectMake(7, 10, 30, 30) type:1];
    [self drawText:jobCard.focus inRect:CGRectMake(37, 13, 40, 12) type:2];
    [self drawText:jobCard.department inRect:CGRectMake(67, 13, 113, 12) type:2];
    [self drawText:jobCard.frequency inRect:CGRectMake(150, 13, 80, 22) type:2];

    if ([jobCard.when isEqualToString:@"Productie"]) {
        [self drawRect:CGRectMake(210, 0, 88, 35) color:yellow];
        [self drawText:@"Productie" inRect:CGRectMake(232, 13, 90, 22) type:3];
    } else if ([jobCard.when isEqualToString:@"Stilstand"]) {
        [self drawRect:CGRectMake(210, 0, 88, 35) color:blue];
        if (jobCard.lototo) {
            [self drawImage:[UIImage imageNamed:@"lock"] inFrame:CGRectMake(222, 12, 12, 12)];
            [self drawText:@"Stilstand" inRect:CGRectMake(240, 13, 90, 22) type:3];
        } else {
            [self drawText:@"Stilstand" inRect:CGRectMake(234, 13, 90, 22) type:3];
        }
    } else {
        [self drawRect:CGRectMake(210, 0, 88, 35) color:purple];
        [self drawText:jobCard.when inRect:CGRectMake(224, 13, 90, 22) type:3];
    }

    // Draw first column.
    [self drawText:@"Installatie/gebied:" inRect:CGRectMake(7, 38, 100, 12) type:4];
    [self drawText:jobCard.installation inRect:CGRectMake(61, 38, 152, 12) type:0];
    [self drawText:@"Machine/plaats:" inRect:(CGRectMake(7, 46, 100, 12)) type:4];
    [self drawText:jobCard.machine inRect:(CGRectMake(56, 46, 156, 12)) type:0];
    [self drawText:@"Onderdeel:" inRect:CGRectMake(7, 54, 40, 12) type:4];
    [self drawText:jobCard.part inRect:CGRectMake(41, 54, 150, 12) type:0];

    // Draw second column.
    [self drawText:@"SIS:" inRect:CGRectMake(210, 42, 16, 12) type:4];
    [self drawText:jobCard.sis inRect:CGRectMake(225, 42, 134, 22) type:0];
    [self drawText:@"Tijd:" inRect:CGRectMake(210, 50, 17, 12) type:4];
    [self drawText:jobCard.time inRect:CGRectMake(226, 50, 133, 22) type:0];

    // Draw jobs.
    switch (jobCard.numberOfJobs) {
        case 1:
            [self drawJob:jobCard.jobs[0] numberOfJobs:1 atPoint:CGPointMake(0, 63)];
            break;
        case 2:
            [self drawJob:jobCard.jobs[0] numberOfJobs:2 atPoint:CGPointMake(0, 63)];
            [self drawRect:CGRectMake(0, 63+161, 420, 1) color:gray];
            [self drawJob:jobCard.jobs[1] numberOfJobs:2 atPoint:CGPointMake(0, 63+161)];
            break;
        case 3:
            [self drawJob:jobCard.jobs[0] numberOfJobs:3 atPoint:CGPointMake(0, 63)];
            [self drawRect:CGRectMake(0, 63+107, 420, 1) color:gray];
            [self drawJob:jobCard.jobs[1] numberOfJobs:3 atPoint:CGPointMake(0, 63+107)];
            [self drawRect:CGRectMake(0, 63+107+107, 420, 1) color:gray];
            [self drawJob:jobCard.jobs[2] numberOfJobs:3 atPoint:CGPointMake(0, 63+107+107)];
            break;
        default:
            break;
    }

    // Draw footer content.
    [self drawImage:[UIImage imageNamed:@"thumb"] inFrame:CGRectMake(7, 393, 20, 20)];
    [self drawText:@"Indien er iets niet klopt of aangepast moet worden, plak een post-it op de jobkaart met de opmerking." inRect:CGRectMake(150, 395, 148, 30) type:6];

    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
    
}

- (void)drawText:(NSString *)text inRect:(CGRect)frame type:(NSInteger)type {
    
    UIFont *font = [UIFont systemFontOfSize:6];
    UIColor *color = [UIColor blackColor];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setLineBreakMode:NSLineBreakByClipping];
    
    switch (type) {
        case 1: color = [UIColor whiteColor]; font = [UIFont boldSystemFontOfSize:15]; break;
        case 2: color = [UIColor whiteColor]; font = [UIFont boldSystemFontOfSize:9]; break;
        case 3: font = [UIFont boldSystemFontOfSize:9]; break;
        case 4: font = [UIFont boldSystemFontOfSize:6]; break;
        case 5: font = [UIFont systemFontOfSize:10]; [style setLineBreakMode:NSLineBreakByWordWrapping]; break;
        case 6: font = [UIFont systemFontOfSize:6]; [style setLineBreakMode:NSLineBreakByWordWrapping]; break;
        case 7: font = [UIFont boldSystemFontOfSize:6]; [style setLineBreakMode:NSLineBreakByWordWrapping]; break;
        default: break;
    }
    
    NSArray *objects = [NSArray arrayWithObjects:color, font, style, nil];
    NSArray *keys = [NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, NSParagraphStyleAttributeName, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [text drawInRect:frame withAttributes:dictionary];
    [[UIColor blackColor] set];
    
}

- (void)drawJob:(Job *)job numberOfJobs:(NSInteger)numberOfJobs atPoint:(CGPoint)point {
    
    if (numberOfJobs == 1) { // Height: 322.
        
        [self drawText:@"Wat:" inRect:CGRectMake(point.x+7, point.y+7, 100, 12) type:4];
        [self drawText:job.what inRect:CGRectMake(point.x+7, point.y+16, 298-point.x-7, 30) type:5];
        
        [self drawText:@"Met wat:" inRect:CGRectMake(point.x+7, point.y+45, 100, 22) type:4];
        [self drawText:job.with inRect:CGRectMake(point.x+7, point.y+54, 298-point.x-7, 30) type:5];
        
        [self drawText:@"Basisconditie:" inRect:CGRectMake(point.x+7, point.y+83, 100, 12) type:4];
        [self drawText:job.basicCondition inRect:CGRectMake(point.x+7, point.y+92, 298-point.x-7, 30) type:5];
        
        [self drawText:@"Te nemen actie:" inRect:CGRectMake(point.x+7, point.y+121, 100, 12) type:4];
        [self drawText:job.action inRect:CGRectMake(point.x+7, point.y+130, 298-point.x-7, 30) type:5];
        
        [self drawImage:job.image inFrame:CGRectMake(point.x, point.y+160, 298, 322-160)];
        
    } else if (numberOfJobs == 2) { // Height: 161.
        
        [self drawText:@"Wat:" inRect:CGRectMake(point.x+7, point.y+13, 60, 22) type:4];
        [self drawText:job.what inRect:CGRectMake(point.x+7, point.y+22, 133, 34) type:6];
        
        [self drawText:@"Met wat:" inRect:CGRectMake(point.x+7, point.y+48, 60, 22) type:4];
        [self drawText:job.with inRect:CGRectMake(point.x+7, point.y+57, 133, 34) type:6];
        
        [self drawText:@"Basisconditie:" inRect:CGRectMake(point.x+7, point.y+83, 60, 22) type:4];
        [self drawText:job.basicCondition inRect:CGRectMake(point.x+7, point.y+92, 133, 34) type:6];
        
        [self drawText:@"Actie:" inRect:CGRectMake(point.x+7, point.y+118, 60, 22) type:4];
        [self drawText:job.action inRect:CGRectMake(point.x+7, point.y+127, 133, 34) type:6];
        
        [self drawImage:job.image inFrame:CGRectMake(point.x+140, point.y, 298-140, 161)];
        
    } else if (numberOfJobs == 3) { // Height: 107.
        
        [self drawText:@"Wat:" inRect:CGRectMake(point.x+2, point.y+7, 60, 12) type:4];
        [self drawText:job.what inRect:CGRectMake(point.x+2, point.y+14, 158, 16) type:6];
        
        [self drawText:@"Met wat:" inRect:CGRectMake(point.x+2, point.y+33, 60, 12) type:4];
        [self drawText:job.with inRect:CGRectMake(point.x+2, point.y+40, 158, 12) type:6];
        
        [self drawText:@"Basisconditie:" inRect:CGRectMake(point.x+2, point.y+52, 60, 12) type:4];
        [self drawText:job.basicCondition inRect:CGRectMake(point.x+2, point.y+59, 158, 16) type:6];
        
        [self drawText:@"Actie:" inRect:CGRectMake(point.x+2, point.y+78, 60, 12) type:4];
        [self drawText:job.action inRect:CGRectMake(point.x+2, point.y+85, 158, 16) type:6];
        
        [self drawImage:job.image inFrame:CGRectMake(point.x+160, point.y, 138, 107)];
        
    }
    
}

- (void)drawRect:(CGRect)rect color:(UIColor *)color {
    
    [color setFill];
    UIRectFill(rect);
    
}

- (void)drawImage:(UIImage *)image inFrame:(CGRect)frame {
    
    if (image) {
        float width = image.size.width;
        float height = image.size.height;
        float ratio = width/height;
        
        if (ratio > (frame.size.width/frame.size.height)) {
            width = frame.size.width;
            height = width / ratio;
        } else {
            height = frame.size.height;
            width = height * ratio;
        }
        
        NSInteger x = frame.origin.x + ((frame.size.width-width)/2);
        NSInteger y = frame.origin.y + ((frame.size.height-height)/2);
        
        CGSize destinationSize = CGSizeMake(width, height);
        [image drawInRect:CGRectMake(x, y, destinationSize.width, destinationSize.height)];
    }
    
}

@end
