//
//  JOYNGODetailViewController.m
//  Joy
//
//  Created by Pritesh Nandgaonkar on 17/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYNGODetailViewController.h"

@interface JOYNGODetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *about;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *donationType;
@property (weak, nonatomic) IBOutlet UILabel *phoneNo;
@property (weak, nonatomic) IBOutlet UILabel *link;
@property (weak, nonatomic) IBOutlet UIImageView *NGOImage;
@property (weak, nonatomic) IBOutlet UILabel *NGOName;

@end

@implementation JOYNGODetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshViewForDonateeObject];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.topItem.title = @"Confirm Organization";
//    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [customButton setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
//    [customButton sizeToFit];
//    UIBarButtonItem* customBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
//    self.navigationItem.leftBarButtonItem = customBarButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)donatePressed:(id)sender {
    
}

- (void)setDonatee:(JOYDonatee *)donatee {
    
    _donatee = donatee;
    
}

- (void)refreshViewForDonateeObject {
    self.about.text = self.donatee.descriptionText;
    self.address.text = self.donatee.address;
    self.phoneNo.text = self.donatee.mobileNum;
    self.link.text = self.donatee.url;
    
    NSString *donationString = @"";
    switch (_donatee.accpetedDonationCategories) {
        case JOYAcceptedDonationCategoriesBooks:
            donationString = @"Books";
            break;
        case JOYAcceptedDonationCategoriesToys:
            donationString = @"Toys";
            break;
        case JOYAcceptedDonationCategoriesClothes:
            break;
        case JOYAcceptedDonationCategoriesToys | JOYAcceptedDonationCategoriesBooks:
            donationString = @"Toys & Books";
            break;
        case JOYAcceptedDonationCategoriesToys | JOYAcceptedDonationCategoriesClothes:
            donationString = @"Toys & Clothes";
            break;
        case JOYAcceptedDonationCategoriesBooks | JOYAcceptedDonationCategoriesClothes:
            donationString = @"Books & Clothes";
            break;
        case JOYAcceptedDonationCategoriesBooks | JOYAcceptedDonationCategoriesClothes | JOYAcceptedDonationCategoriesToys:
            donationString = @"Books & Clothes & Toys";
        default:
            break;
    }
    self.donationType.text = donationString;
    self.NGOName.text = self.donatee.name;
    [self.NGOImage sd_setImageWithURL:[NSURL URLWithString:self.donatee.iconImageURL]];
}


@end
