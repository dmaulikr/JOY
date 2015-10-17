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
@property (weak, nonatomic) IBOutlet UIImageView *chotaImage;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonHeight;

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
    
    [self sendPostRequest];
}

- (void)sendPostRequest{
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://bhargavs-macbook-pro.local/hackathon/api/v1/donation/%@/cancel",self.donation.donationID];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    //    NSDictionary *mapData = [NSDictionary dictionaryWithObject:@(isLoggedIn) forKey:@"logged"];
//    NSDictionary *mapData = [NSDictionary dictionaryWithObjects:@[@([self mapCategory]),[JOYUser sharedUser].userID,self.donateeNGO.donateeID, @(self.slotID), @(self.boxCount),@"blabla",self.addOneTF.text, self.addTwoTF.text,self.addThreeTF.text] forKeys:@[@"category_id",@"user_id",@"ngo_id",@"slot_id",@"number_of_boxes",@"notes",@"address_1",@"address_2",@"address_3"]];
//    
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:nil];
//    [request setHTTPBody:postData];
//    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error){
            NSLog(@"got error while fetching cards data %@", error);
        }
        if(data && !error){
            UIAlertView *alertEmpty = [[UIAlertView alloc] initWithTitle:@"JOY" message:@"Cancelled Your Request" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [alertEmpty show];
            });
        }
    }];
    [postDataTask resume];
    
    
}


- (void)refreshView {
    
    self.NGOName.text = self.donation.donatee.name;
    self.contactNo.text = self.donation.donatee.mobileNum;
    self.itemLabel.text = [NSString stringWithFormat:@"%i Boxes of %@",(int)self.donation.numBoxes, [self.donation categoryToString]];
    if(!self.donation.slot.slot){
        self.pickUpTime.text = [NSString stringWithFormat:@"%@,%@",self.donation.timeSlots, self.donation.donationDate];
    }
    else {
        self.pickUpTime.text = [NSString stringWithFormat:@"%@,%@",self.donation.slot.slot, self.donation.slot.date];
    }
    switch (self.donation.status) {
        case JOYDonationStatusCompleted:
            [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:self.donation.feedBackImgURL]];
            self.chotaImage.hidden = YES;
            self.buttonHeight.constant = 0;
            break;
        case JOYDonationStatusInTransit:
            self.buttonHeight.constant = 0;
            break;
        case JOYDonationStatusPending:
        case JOYDonationStatusRequest:
            break;
        case JOYDonationStatusRejectByNGO:
        case JOYDonationStatusRejectByUser:
            self.pickUpTime.text = @"cancelled";
            self.buttonHeight.constant = 0;
            break;
            
        default:
            break;
    }
   }
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
