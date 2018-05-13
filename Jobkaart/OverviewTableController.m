//
//  OverviewTableControllerTableViewController.m
//  Jobkaart
//
//  Created by Lodewijck on 06/05/2018.
//  Copyright © 2018 Lodewijck. All rights reserved.
//

#import "OverviewTableController.h"
#import "JobCardMetadata.h"
#import "AppDelegate.h"

@interface OverviewTableController ()

@end

@implementation OverviewTableController

static NSString *showDetailSegueIdentifier = @"showDetail";
static NSString *cellIdentifier = @"jobCardCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellIdentifier];
     self.clearsSelectionOnViewWillAppear = NO;
    
    [self.editButtonItem setTitle:@"Wijzig"];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self.tableView setAllowsMultipleSelection:false];
    [self.tableView setAllowsSelectionDuringEditing:true];
}

- (void)selectJobCard:(JobCard*)jobCard {
    self.selectedJobCard = jobCard;
    JobCardMetadata *current;
    for (int i=0; i<self.jobCards.count; i++) {
        current = self.jobCards[i];
        if (current.id == jobCard.id) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:true scrollPosition:UITableViewScrollPositionMiddle];
            break;
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jobCards.count;
}

- (void)updateTable:(NSMutableArray *)jobCards {
    self.jobCards = jobCards;
    [self.tableView reloadData];
    
    if (!self.isEditing) {
        [self updateSelection];
    }
}

- (void)updateSelection {
    JobCardMetadata *jobCard;
    for (int i=0; i<self.jobCards.count; i++) {
        jobCard = self.jobCards[i];
        if (jobCard.id == self.selectedJobCard.id) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:false scrollPosition:UITableViewScrollPositionNone];
        }
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    self.editButtonItem.title = editing ? @"Gereed" : @"Wijzig";
    
    if (!editing) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
        self.navigationItem.rightBarButtonItem = addButton;
        [self updateSelection];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
}

- (void)insertNewObject:(id)sender {
    [self.tableView setEditing:false animated:false];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate createNewJobCard];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    JobCardMetadata *jobCard = self.jobCards[indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld. %@: %@, %@, %@", (long)jobCard.id, jobCard.focus, jobCard.department, jobCard.installation, jobCard.machine]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    JobCardMetadata *jobCard = self.jobCards[indexPath.row];
    Boolean selected = jobCard.id == self.selectedJobCard.id && !self.isEditing;
    [cell setSelected:selected animated:false];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView beginUpdates];
        JobCardMetadata *jobCard = self.jobCards[indexPath.row];
        if (self.jobCards.count > 1) {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate deleteJobCardWithId:jobCard.id];
        [self.tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.tableView.isEditing) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        JobCardMetadata *jobCard = self.jobCards[indexPath.row];
        [appDelegate selectJobCardWithId:jobCard.id];
        [self performSegueWithIdentifier:showDetailSegueIdentifier sender:self];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.isEditing) {
        [self.tableView selectRowAtIndexPath:nil animated:true scrollPosition:UITableViewScrollPositionBottom];
    }
    return !self.tableView.isEditing;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIButton *sendCardListButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendCardListButton setFrame:CGRectMake(0, 0, 320, 44)];
    [sendCardListButton setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [sendCardListButton setTitle:@"Deel jobkaarten overzicht" forState:UIControlStateNormal];
    
    return sendCardListButton;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        MainViewController *controller = (MainViewController *)[[segue destinationViewController] topViewController];
        [controller updateJobCardView:self.selectedJobCard];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

@end
