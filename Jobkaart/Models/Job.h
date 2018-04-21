//
//  Job.h
//  Jobkaarten
//
//  Created by Lodewijck Vogelzang on 17-11-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Job : NSObject

@property NSInteger jobCardid;
@property NSInteger id;

@property NSString *what;
@property NSString *with;
@property NSString *basicCondition;
@property NSString *action;
@property UIImage *image;
@property UIImage *thumb;

- (Job *)initForJobcardId: (long)jobCardId jobNumber:(long)jobNumber;

@end
