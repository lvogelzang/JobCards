//
//  DatabaseController.h
//  Jobkaart
//
//  Created by Lodewijck Vogelzang on 28-12-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JobCard.h"
#import "Job.h"

@interface DatabaseController : NSObject

extern NSString *const databaseName;

+ (void)checkAndCreateDatabase;
+ (JobCard *)getJobCard;
+ (void)updateJobCard:(JobCard *)jobCard;
+ (void)deleteJob:(NSInteger)id FromCard:(NSInteger)cardId;

@end
