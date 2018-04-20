//
//  ViewController.h
//  Jobkaart
//
//  Created by Lodewijck on 02/04/2018.
//  Copyright © 2018 Lodewijck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobCard.h"

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *activityIndicatorItem;
@property UIActivityIndicatorView *activityIndicator;
@property JobCard *jobCard;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *focusControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *numberOfJobsControl;
@property (weak, nonatomic) IBOutlet UITextField *departmentField;
@property (weak, nonatomic) IBOutlet UITextField *installationField;
@property (weak, nonatomic) IBOutlet UITextField *machineField;
@property (weak, nonatomic) IBOutlet UITextField *partField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sisControl;
@property (weak, nonatomic) IBOutlet UITextField *frequencyField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *whenControl;

@property (weak, nonatomic) IBOutlet UILabel *whatLabel1;
@property (weak, nonatomic) IBOutlet UITextView *whatView1;
@property (weak, nonatomic) IBOutlet UILabel *withWhatLabel1;
@property (weak, nonatomic) IBOutlet UITextField *withWhatField1;
@property (weak, nonatomic) IBOutlet UILabel *basicConditionLabel1;
@property (weak, nonatomic) IBOutlet UITextView *basicConditionView1;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel1;
@property (weak, nonatomic) IBOutlet UITextView *actionView1;

@property (weak, nonatomic) IBOutlet UILabel *whatLabel2;
@property (weak, nonatomic) IBOutlet UITextView *whatView2;
@property (weak, nonatomic) IBOutlet UILabel *withWhatLabel2;
@property (weak, nonatomic) IBOutlet UITextField *withWhatField2;
@property (weak, nonatomic) IBOutlet UILabel *basicConditionLabel2;
@property (weak, nonatomic) IBOutlet UITextView *basicConditionView2;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel2;
@property (weak, nonatomic) IBOutlet UITextView *actionView2;

@property (weak, nonatomic) IBOutlet UILabel *whatLabel3;
@property (weak, nonatomic) IBOutlet UITextView *whatView3;
@property (weak, nonatomic) IBOutlet UILabel *withWhatLabel3;
@property (weak, nonatomic) IBOutlet UITextField *withWhatField3;
@property (weak, nonatomic) IBOutlet UILabel *basicConditionLabel3;
@property (weak, nonatomic) IBOutlet UITextView *basicConditionView3;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel3;
@property (weak, nonatomic) IBOutlet UITextView *actionView3;

- (IBAction)valueChanged:(id)sender;

@end
