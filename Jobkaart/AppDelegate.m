//
//  AppDelegate.m
//  Jobkaart
//
//  Created by Lodewijck Vogelzang on 28-12-13.
//  Copyright (c) 2013 Lodewijck Vogelzang. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseController.h"
#import "MainViewController.h"
#import "OverviewTableController.h"
#import "RenderViewController.h"
#import "ImageFunctions.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [DatabaseController checkAndCreateDatabase];
    
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    
    [[self getTableView] updateTable:[DatabaseController getJobCardsMetadata]];
    [self selectJobCardWithId:[DatabaseController getLastJobCardId]];
    
    return YES;
}

- (void)createNewJobCard {
    JobCard *jobCard = [DatabaseController createNewJobCard];
    [[self getTableView] updateTable:[DatabaseController getJobCardsMetadata]];
    [self selectJobCardWithId:jobCard.id];
}

- (void)selectJobCardWithId:(NSInteger)id {
    JobCard *jobCard = [DatabaseController getJobCardWithId:id];
    
    OverviewTableController *tableView = [self getTableView];
    [tableView selectJobCard:jobCard];
    MainViewController *detailView = [self getDetailViewIfAvailable];
    if (detailView) {
        [detailView updateJobCardView:jobCard];
    }
    RenderViewController *renderViewController = [self getRenderViewIfVisible];
    if (renderViewController) {
        [renderViewController prepareForJobCard:jobCard];
    }
}

- (void)updateJobCard:(JobCard *)jobCard {
    [DatabaseController updateJobCard:jobCard];
    [[self getTableView] updateTable:[DatabaseController getJobCardsMetadata]];
}

- (void)deleteJobCardWithId:(NSInteger)id {
    OverviewTableController *tableView = [self getTableView];
    
    // Delete saved images for job card.
    for (int i=0; i<3; i++) {
        [ImageFunctions removeImageNamed:[NSString stringWithFormat:@"image%ld%d", (long)id, i+1]];
        [ImageFunctions removeImageNamed:[NSString stringWithFormat:@"image%ld%dt", (long)id, i+1]];
    }
    
    NSInteger numberOfJobCards = [DatabaseController getJobCardsMetadata].count;
    if (numberOfJobCards == 1) {
        [DatabaseController resetDatabase];
    } else {
        [DatabaseController deleteJobCardWithId:id];
    }
    
    [tableView updateTable:[DatabaseController getJobCardsMetadata]];
    if (tableView.selectedJobCard.id == id) {
        [self selectJobCardWithId:[DatabaseController getLastJobCardId]];
    }
}

- (void)deleteJob:(NSInteger)id fromJobCard:(NSInteger)cardId {
    [ImageFunctions removeImageNamed:[NSString stringWithFormat:@"image%ld%ld", (long)cardId, (long)id]];
    [ImageFunctions removeImageNamed:[NSString stringWithFormat:@"image%ld%ldt", (long)cardId, (long)id]];
    [DatabaseController deleteJob:id FromCard:cardId];
}

- (OverviewTableController *) getTableView {
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    return (OverviewTableController *)[[splitViewController.viewControllers firstObject] viewControllers][0];
}

- (MainViewController *) getDetailViewIfAvailable {
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    if (splitViewController.viewControllers.count > 1) {
        return (MainViewController *) [[splitViewController.viewControllers lastObject] viewControllers][0];
    } else {
        return nil;
    }
}

- (RenderViewController *) getRenderViewIfVisible {
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    if (splitViewController.viewControllers.count > 1) {
        UINavigationController *navigationController = (UINavigationController *)[splitViewController.viewControllers lastObject];
        if (navigationController.visibleViewController.class == RenderViewController.class) {
            return (RenderViewController *)navigationController.visibleViewController;
        }
    }
    return nil;
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return YES;
}
@end
