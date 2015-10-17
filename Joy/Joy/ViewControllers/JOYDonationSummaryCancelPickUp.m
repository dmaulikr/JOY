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
- (void)viewWillAppear:(BOOL)animated {
    
    [self refreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDonation:(JOYDonation *)donation {
    _donation = donation;
}

- (IBAction)cancelButtonPressed:(id)sender {
}

- (void)refreshView {
    
    self.NGOName.text = self.donation.donatee.name;
    self.contactNo.text = self.donation.donatee.mobileNum;
    self.itemLabel.text = [NSString stringWithFormat:@"%i Boxes of %@",(int)self.donation.numBoxes, [self.donation categoryToString]];
    self.pickUpTime.text = [NSString stringWithFormat:@"%@,%@",self.donation.slot.slot, self.donation.slot.date];
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
