//
//  JobCardThumb.h
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 17-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobCardMetadata : NSObject

@property NSInteger id;
@property NSString *focus;
@property NSString *department;
@property NSString *installation;
@property NSString *machine;

- (id)initWithId:(NSInteger)id Focus:(NSString *)focus Department:(NSString *)department Installation:(NSString *)installation Machine:(NSString *)machine;

@end
