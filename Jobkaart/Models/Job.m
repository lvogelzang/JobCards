//
//  Job.m
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 17-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "Job.h"

@implementation Job

- (Job *)initForJobcardId: (long)jobCardId jobNumber:(long)jobNumber {
    self = [super init];
    _jobCardid = jobCardId;
    _id = jobNumber;
    _what = @"";
    _with = @"";
    _basicCondition = @"";
    _action = @"";
    return self;
}

@end
