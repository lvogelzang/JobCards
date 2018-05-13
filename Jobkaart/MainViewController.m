//
//  ViewController.m
//  Jobkaart
//
//  Created by Lodewijck on 02/04/2018.
//  Copyright © 2018 Lodewijck. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "RenderViewController.h"
#import "DatabaseController.h"
#import "Job.h"

@implementation MainViewController

- (void)viewDidLoad {
    NSArray *textViews = [NSArray arrayWithObjects:_whatView1, _basicConditionView1, _actionView1, _whatView2, _basicConditionView2, _actionView2, _whatView3, _basicConditionView3, _actionView3, nil];
    for (int i=0; i<[textViews count]; i++) {
        [self setTextViewStyle:textViews[i]];
    }
    
    [self updateJobCardView: self.selectedJobCard];
    [super viewDidLoad];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self valueChanged: textView];
}

- (IBAction)valueChanged:(UIView *)sender {
    JobCard *jobCard = self.selectedJobCard;
    
    switch (sender.tag) {
        case Title: [jobCard setTitle:_titleField.text]; break;
        case Focus: [jobCard setFocus:[self selectedTitle:_focusControl]]; break;
        case NumberOfJobs:
            [jobCard setNumberOfJobs:_numberOfJobsControl.selectedSegmentIndex + 1];
            while (jobCard.jobs.count < jobCard.numberOfJobs) {
                [jobCard.jobs addObject:[[Job alloc] initForJobcardId:jobCard.id jobNumber:jobCard.jobs.count+1]];
            }
            while (jobCard.jobs.count > jobCard.numberOfJobs) {
                [DatabaseController deleteJob:jobCard.jobs.count FromCard:jobCard.id];
                [jobCard.jobs removeLastObject];
            }
            break;
        case Department: [jobCard setDepartment:_departmentField.text]; break;
        case Installation: [jobCard setInstallation:_installationField.text]; break;
        case Machine: [jobCard setMachine:_machineField.text]; break;
        case Part: [jobCard setPart:_partField.text]; break;
        case SIS: [jobCard setSis:[self selectedTitle:_sisControl]]; break;
        case Frequency: [jobCard setFrequency:_frequencyField.text]; break;
        case Time: [jobCard setTime:_timeField.text]; break;
        case When:
            [jobCard setWhen:[self selectedTitle:_whenControl]];
            [self updateLototoSwitchAnimated:YES jobCard:jobCard];
            break;
        case LOTOTO: [jobCard setLototo:[_lototoSwitch isOn]]; break;
        case What1: [jobCard.jobs[0] setWhat:_whatView1.text]; break;
        case WithWhat1: [jobCard.jobs[0] setWith:_withWhatField1.text]; break;
        case BasicCondition1: [jobCard.jobs[0] setBasicCondition:_basicConditionView1.text]; break;
        case Action1: [jobCard.jobs[0] setAction:_actionView1.text]; break;
        case What2: [jobCard.jobs[1] setWhat:_whatView2.text]; break;
        case WithWhat2: [jobCard.jobs[1] setWith:_withWhatField2.text]; break;
        case BasicCondition2: [jobCard.jobs[1] setBasicCondition:_basicConditionView2.text]; break;
        case Action2: [jobCard.jobs[1] setAction:_actionView2.text]; break;
        case What3: [jobCard.jobs[2] setWhat:_whatView3.text]; break;
        case WithWhat3: [jobCard.jobs[2] setWith:_withWhatField3.text]; break;
        case BasicCondition3: [jobCard.jobs[2] setBasicCondition:_basicConditionView3.text]; break;
        case Action3: [jobCard.jobs[2] setAction:_actionView3.text]; break;
        default:
            [NSException raise:@"Invalid tag for sender" format:@"Invlid tag: %ld for sender: %@", (long)sender.tag, sender];
    }
    [DatabaseController updateJobCard:jobCard];
}

- (void)updateJobCardView:(JobCard *)jobCard {
    self.selectedJobCard = jobCard;
    [_titleField setText:jobCard.title];
    [self selectSegmentForTitle:jobCard.focus control:_focusControl withDefaultSize:2];
    [_numberOfJobsControl setSelectedSegmentIndex:jobCard.numberOfJobs-1];
    [_departmentField setText:jobCard.department];
    [_installationField setText:jobCard.installation];
    [_machineField setText:jobCard.machine];
    [_partField setText:jobCard.part];
    [self selectSegmentForTitle:jobCard.sis control:_sisControl withDefaultSize:3];
    [_frequencyField setText:jobCard.frequency];
    [_timeField setText:jobCard.time];
    [self selectSegmentForTitle:jobCard.when control:_whenControl withDefaultSize:2];
    [self updateLototoSwitchAnimated:NO jobCard:jobCard];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [(RenderViewController*)[segue destinationViewController] prepareForJobCard: self.selectedJobCard];
}

- (void)updateLototoSwitchAnimated:(bool)animated jobCard:(JobCard *)jobCard {
    bool enabled = [jobCard.when isEqualToString:@"Stilstand"];
    [_lototoSwitch setEnabled:enabled];
    [_lototoSwitch setOn:enabled && jobCard.lototo];
    [_lototoSwitch setOn:enabled && jobCard.lototo animated:animated];
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
