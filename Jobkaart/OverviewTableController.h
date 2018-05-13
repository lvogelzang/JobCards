//
//  OverviewTableControllerTableViewController.h
//  Jobkaart
//
//  Created by Lodewijck on 06/05/2018.
//  Copyright © 2018 Lodewijck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobCard.h"

@interface OverviewTableController : UITableViewController

@property JobCard *selectedJobCard;
@property NSMutableArray *jobCards;

- (void)updateTable:(NSMutableArray *)jobCards;
- (void)selectJobCard:(JobCard*)jobCard;

@end
