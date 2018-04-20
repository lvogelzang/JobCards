//
//  PDFRenderer.h
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 26-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JobCard.h"

@interface JobCardRenderer : NSObject

- (void)savePDFFile:(NSString*)pdfFileName withJobCard:(JobCard*)jobCard;

@end
