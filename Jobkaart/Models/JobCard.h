//
//  JobCard.h
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 17-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobCard : NSObject

@property NSInteger id;
@property NSString *title;
@property NSString *focus;
@property NSString *frequency;
@property NSString *when;
@property BOOL lototo;
@property NSString *department;
@property NSString *installation;
@property NSString *machine;
@property NSString *part;
@property NSString *time;
@property NSString *sis;
@property NSInteger numberOfJobs;
@property NSMutableArray *jobs;

- (id)initWithId:(NSInteger)id;

@end
