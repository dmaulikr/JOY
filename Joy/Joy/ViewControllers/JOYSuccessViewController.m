//
//  JOYSuccessViewController.m
//  Joy
//
//  Created by Pritesh Nandgaonkar on 17/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYSuccessViewController.h"
#import "JOYDonationSummaryCancelPickUp.h"

@interface JOYSuccessViewController ()

@end

@implementation JOYSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)donationSummaryPressed:(id)sender {
    [self performSegueWithIdentifier:@"donationSummary" sender:self];
    
}
- (IBAction)backToHomePressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    JOYDonationSummaryCancelPickUp *pickVC = segue.destinationViewController;
        pickVC.donation = self.donation;
}

@end
