//
//  JOYDonationSummaryCancelPickUp.m
//  Joy
//
//  Created by Pritesh Nandgaonkar on 17/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYDonationSummaryCancelPickUp.h"

@interface JOYDonationSummaryCancelPickUp ()
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *pickUpTime;
@property (weak, nonatomic) IBOutlet UILabel *NGOName;
@property (weak, nonatomic) IBOutlet UILabel *contactNo;

@end

@implementation JOYDonationSummaryCancelPickUp

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelButtonPressed:(id)sender {
}

@end
