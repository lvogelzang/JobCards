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
#import "JobCardMetadata.h"

@interface DatabaseController : NSObject

extern NSString *const databaseName;

+ (void)checkAndCreateDatabase;
+ (void)resetDatabase;

// Create
+ (JobCard *)createNewJobCard;

// Read
+ (NSInteger)getLastJobCardId;
+ (JobCard *)getLastJobCard;
+ (JobCard *)getJobCardWithId: (NSInteger) id;
+ (NSMutableArray *)getJobCardsMetadata;

// Update
+ (void)updateJobCard:(JobCard *)jobCard;

// Delete
+ (void)deleteJobCardWithId:(NSInteger)id;
+ (void)deleteJob:(NSInteger)id FromCard:(NSInteger)cardId;

@end
