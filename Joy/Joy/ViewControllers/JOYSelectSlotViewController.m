//
//  JOYSelectSlotViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 17/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYSelectSlotViewController.h"

@interface JOYSelectSlotViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@end

@implementation JOYSelectSlotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datePickerView.minimumDate = [NSDate date];
    self.datePickerView.maximumDate = [NSDate dateWithTimeInterval:604800 sinceDate:[NSDate date]];//max 5 days ahead
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)dateChanged:(UIDatePicker *)picker
{
    NSData *selectedDate = [NSDate dateWithTimeInterval:86400 sinceDate:picker.date];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
