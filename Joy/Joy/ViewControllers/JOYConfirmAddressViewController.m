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
#import "JOYSuccessViewController.h"

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
    BOOL isValid = [self validateForm];
    if (!isValid)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"JOY"
                                                        message:@"Addressfield Can't be left empty"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert show];
        });
   
        return;
    }
    
    self.donation.donatee = self.donateeNGO;
    self.donation.numBoxes = self.boxCount;
    self.donation.category = [self stringToCategory];
    self.donation.slotId = self.slotID;
    self.donation.slot = self.slot;
    [self performSegueWithIdentifier:@"successController" sender:self];
    [self sendPostRequest];
}

- (BOOL)validateForm
{
    BOOL isValid = YES;
    if (self.addOneTF.text.length == 0)
        isValid = NO;
    
    if (self.addTwoTF.text.length == 0)
        isValid = NO;
    
    return isValid;
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

//    JOYDonationSummaryCancelPickUp *pickVC = segue.destinationViewController;
//    pickVC.donation = self.donation;
//    
    JOYSuccessViewController *pickVC = segue.destinationViewController;
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
