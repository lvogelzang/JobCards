//
//  AppDelegate.m
//  Jobkaart
//
//  Created by Lodewijck Vogelzang on 28-12-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [DatabaseController checkAndCreateDatabase];
    return YES;
}

@end
