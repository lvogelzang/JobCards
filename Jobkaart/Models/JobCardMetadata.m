//
//  JobCardThumb.m
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 17-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "JobCardMetadata.h"

@implementation JobCardMetadata

- (id)initWithId:(NSInteger)id Focus:(NSString *)focus Department:(NSString *)department Installation:(NSString *)installation Machine:(NSString *)machine {
    self = [super init];
    self.id = id;
    self.focus = focus;
    self.department = department;
    self.installation = installation;
    self.machine = machine;
    return self;
}

@end
