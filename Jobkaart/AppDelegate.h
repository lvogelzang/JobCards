//
//  AppDelegate.h
//  Jobkaart
//
//  Created by Lodewijck Vogelzang on 28-12-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)createNewJobCard;
- (void)selectJobCardWithId:(NSInteger)id;
- (void)deleteJobCardWithId:(NSInteger)id;

@end
