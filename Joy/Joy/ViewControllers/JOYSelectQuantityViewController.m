//
//  JOYSelectQuantityViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 17/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYSelectQuantityViewController.h"
#import "JOYSelectNGOViewController.h"

@interface JOYSelectQuantityViewController ()

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@end

@implementation JOYSelectQuantityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.quantityLabel.text = @"1";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonClicked:(id)sender
{
    [self performSegueWithIdentifier:@"showNGO" sender:self];
}

- (IBAction)boxValueChanged:(UIStepper *)stepper
{
    self.quantityLabel.text = [NSString stringWithFormat:@"%.f", stepper.value];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JOYSelectNGOViewController *vc = segue.destinationViewController;
    NSString *str = self.quantityLabel.text;
    vc.boxCount = [str integerValue];
    vc.donationType = self.donationType;
}

@end
