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
#import "JOYUser.h"

@interface JOYConfirmAddressViewController ()<UITextFieldDelegate>

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.addOneTF) {
       [self.addTwoTF becomeFirstResponder];
    }
    else if(textField == self.addTwoTF) {
        [self.addThreeTF becomeFirstResponder];
    }
    else {
        [self submitButtonClicked:nil];
    }
    return YES;
}

- (void)keyboardWillAppers:(NSNotification *)notif
{
    NSDictionary *info1 = [notif userInfo];
    NSTimeInterval animationDuration = [[info1 objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGSize kbSize1 = [[info1 objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    if (!self.showingKeyboard) {
        self.buttonBottomConstrint.constant =  kbSize1.height;
    } else {
//        self.buttonBottomConstrint.constant =  0;
    }
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
    self.showingKeyboard = !self.showingKeyboard;
    if(!self.showingKeyboard){
        [self.view resignFirstResponder];
    }
}

- (void)keyboardWillDisappers:(NSNotification *)notif
{
    self.showingKeyboard = NO;
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
    

    
    NSString *urlString = @"http://bhargavs-macbook-pro.local/hackathon/api/v1/donation";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
//    NSDictionary *mapData = [NSDictionary dictionaryWithObject:@(isLoggedIn) forKey:@"logged"];
    NSDictionary *mapData = [NSDictionary dictionaryWithObjects:@[@([self mapCategory]),[JOYUser sharedUser].userID,self.donateeNGO.donateeID, @(self.slotID), @(self.boxCount),@"blabla",self.addOneTF.text, self.addTwoTF.text,self.addThreeTF.text] forKeys:@[@"category_id",@"user_id",@"ngo_id",@"slot_id",@"number_of_boxes",@"notes",@"address_1",@"address_2",@"address_3"]];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:nil];
    [request setHTTPBody:postData];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error){
            NSLog(@"got error while fetching cards data %@", error);
        }
        if(data && !error){
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.donation.donationID = dataDict[@"donation_id"];
        }
    }];
    [postDataTask resume];

    
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

- (NSUInteger)mapCategory{
    NSUInteger i = 0;
    if([self.donationType isEqualToString:@"BOOKS"]){
        return 1;
    }
    else if([self.donationType isEqualToString:@"CLOTHES"]){
        return 2;
    }
    else if([self.donationType isEqualToString:@"TOYS"]){
        return 3;
    }
    else {
        return i;
    }

    
}

@end
