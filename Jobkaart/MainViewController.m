//
//  ViewController.m
//  Jobkaart
//
//  Created by Lodewijck on 02/04/2018.
//  Copyright © 2018 Lodewijck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "PDFViewController.h"
#import "DatabaseController.h"

@interface MainViewController ()
@end

typedef NS_ENUM(NSInteger, InputSource) {
    Title = 1, Focus, NumberOfJobs, Department, Installation, Machine, Part, SIS, Frequency, Time, When,
    What1, WithWhat1, BasicCondition1, Action1,
    What2, WithWhat2, BasicCondition2, Action2,
    What3, WithWhat3, BasicCondition3, Action3
};

@implementation MainViewController

- (void)viewDidLoad {
    NSArray *textViews = [NSArray arrayWithObjects:_whatView1, _basicConditionView1, _actionView1, _whatView2, _basicConditionView2, _actionView2, _whatView3, _basicConditionView3, _actionView3, nil];
    for (int i=0; i<[textViews count]; i++) {
        [self setTextViewStyle:textViews[i]];
    }
    
    _jobCard = [DatabaseController getJobCard];
    [self updateJobCardView];
    
    [super viewDidLoad];
}

- (IBAction)showPdf:(id)sender {
    [self startActivityAnimation];
    [self performSegueWithIdentifier:@"showPdf" sender:sender];
}

- (void)startActivityAnimation {
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    if (_activityIndicatorItem.customView == nil) {
        [_activityIndicatorItem setCustomView:_activityIndicator];
    }
    [_activityIndicator startAnimating];
}

- (IBAction)valueChanged:(UIView *)sender {
    switch (sender.tag) {
        case Title:
            [_jobCard setTitle:_titleField.text];
            break;
        case Focus:
            [_jobCard setFocus:[self selectedTitle:_focusControl]];
            break;
        case NumberOfJobs:
            [_jobCard setNumberOfJobs:_numberOfJobsControl.selectedSegmentIndex + 1];
            break;
        case Department:
            [_jobCard setDepartment:_departmentField.text];
            break;
        case Installation:
            [_jobCard setInstallation:_installationField.text];
            break;
        case Machine:
            [_jobCard setMachine:_machineField.text];
            break;
        case Part:
            [_jobCard setPart:_partField.text];
            break;
        case SIS:
            [_jobCard setSis:[self selectedTitle:_sisControl]];
            break;
        case Frequency:
            [_jobCard setFrequency:_frequencyField.text];
            break;
        case Time:
            [_jobCard setTime:_timeField.text];
            break;
        case When:
            [_jobCard setWhen:[self selectedTitle:_whenControl]];
            break;
        case What1:
            [_jobCard.jobs[0] setWhat:_whatView1.text];
            break;
        case WithWhat1:
            [_jobCard.jobs[0] setWith:_withWhatField1.text];
            break;
        case BasicCondition1:
            [_jobCard.jobs[0] setBasicCondition:_basicConditionView1.text];
            break;
        case Action1:
            [_jobCard.jobs[0] setAction:_actionView1.text];
            break;
        case What2:
            [_jobCard.jobs[1] setWhat:_whatView2.text];
            break;
        case WithWhat2:
            [_jobCard.jobs[1] setWith:_withWhatField2.text];
            break;
        case BasicCondition2:
            [_jobCard.jobs[1] setBasicCondition:_basicConditionView2.text];
            break;
        case Action2:
            [_jobCard.jobs[1] setAction:_actionView2.text];
            break;
        case What3:
            [_jobCard.jobs[2] setWhat:_whatView3.text];
            break;
        case WithWhat3:
            [_jobCard.jobs[2] setWith:_withWhatField3.text];
            break;
        case BasicCondition3:
            [_jobCard.jobs[2] setBasicCondition:_basicConditionView3.text];
            break;
        case Action3:
            [_jobCard.jobs[2] setAction:_actionView3.text];
            break;
        default:
            [NSException raise:@"Invalid tag for sender" format:@"Invlid tag: %ld for sender: %@", (long)sender.tag, sender];
    }
}

- (void)updateJobCardView {
    [_titleField setText:_jobCard.title];
    [self selectSegmentForTitle:_jobCard.focus control:_focusControl withDefaultSize:2];
    [_numberOfJobsControl setSelectedSegmentIndex:_jobCard.numberOfJobs-1];
    [_departmentField setText:_jobCard.department];
    [_installationField setText:_jobCard.installation];
    [_machineField setText:_jobCard.machine];
    [_partField setText:_jobCard.part];
    [self selectSegmentForTitle:_jobCard.sis control:_sisControl withDefaultSize:3];
    [_frequencyField setText:_jobCard.frequency];
    [_timeField setText:_jobCard.time];
    [self selectSegmentForTitle:_jobCard.when control:_whenControl withDefaultSize:2];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [(PDFViewController*)[segue destinationViewController] prepareForJobCard: _jobCard];
}

- (void)selectSegmentForTitle:(NSString *)title control:(UISegmentedControl *) control withDefaultSize: (int) defaultSize {
    for (int i=0; i<control.numberOfSegments; i++) {
        // Select segment if segment title matches
        if ([[control titleForSegmentAtIndex:i] isEqualToString:title]) {
            [control setSelectedSegmentIndex:i];
            // Remove custom segment if exists but not selected
            if (control.numberOfSegments == defaultSize + 1 && control.selectedSegmentIndex <= defaultSize) {
                [control removeSegmentAtIndex:defaultSize animated:false];
            }
            break;
        }
        // Create and select custom segment if no segment matches title
        if (i == control.numberOfSegments-1) {
            // Reuse custom segment if exists
            if (control.numberOfSegments == defaultSize + 1) {
                [control setTitle:title forSegmentAtIndex:defaultSize + 1];
            } else {
                [control insertSegmentWithTitle:title atIndex:defaultSize animated:false];
            }
            [_focusControl setSelectedSegmentIndex:defaultSize];
        }
    }
}

- (void)setTextViewStyle:(UITextView *)textView {
    [textView.layer setBorderColor:[[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor];
    [textView.layer setBorderWidth:0.5];
    [textView.layer setCornerRadius:5.0];
}

- (NSString *)selectedTitle:(UISegmentedControl *) control {
    return [control titleForSegmentAtIndex:control.selectedSegmentIndex];
}

@end
