//
//  JOYConfirmAddressViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 17/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYConfirmAddressViewController.h"
#import "JOYDonationSummaryCancelPickUp.h"
#import "JOYDonation.h"

@interface JOYConfirmAddressViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *addOneTF;
@property (weak, nonatomic) IBOutlet UITextField *addTwoTF;
@property (weak, nonatomic) IBOutlet UITextField *addThreeTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonBottomConstrint;
@property (strong, nonatomic) JOYDonation *donation;

@property (nonatomic) BOOL showingKeyboard;

@end

@implementation JOYConfirmAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showingKeyboard = NO;
    self.donation = [[JOYDonation alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppers:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappers:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)keyboardWillAppers:(NSNotification *)notif
{
    if (self.showingKeyboard)
        return;
    
    NSDictionary* info = [notif userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.buttonBottomConstrint.constant = kbSize.height - 45;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, kbSize.height - 200, 0);
    self.showingKeyboard = YES;
}

- (void)keyboardWillDisappers:(NSNotification *)notif
{
    self.buttonBottomConstrint.constant = 0;
    self.scrollView.contentInset = UIEdgeInsetsZero;
}


- (IBAction)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonClicked:(id)sender
{
    self.donation.donatee = self.donateeNGO;
    self.donation.numBoxes = self.boxCount;
    self.donation.category = [self stringToCategory];
    self.donation.slotId = self.slotID;
    self.donation.slot = self.slot;
    [self performSegueWithIdentifier:@"donationSummary" sender:self];
    [self sendPostRequest];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    JOYDonationSummaryCancelPickUp *pickVC = segue.destinationViewController;
    pickVC.donation = self.donation;
    
}

- (void)sendPostRequest{
    
}

- (JOYAcceptedDonationCategories)stringToCategory{
    if([self.donationType isEqualToString:@"BOOKS"]){
        return JOYAcceptedDonationCategoriesBooks;
    }
    else if([self.donationType isEqualToString:@"CLOTHES"]){
        return JOYAcceptedDonationCategoriesClothes;

    }
    else if([self.donationType isEqualToString:@"TOYS"]) {
        return JOYAcceptedDonationCategoriesToys;

    }
    else {
        return JOYAcceptedDonationCategoriesUnknown;
    }
}

@end
