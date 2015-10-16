//
//  PartnersViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 16/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "PartnersViewController.h"
#import "JOYPartnerTableViewCell.h"
#import "JOYDonatee.h"
#import "UIImageView+WebCache.h"

@interface PartnersViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *NGOArray;
@property (strong, nonatomic) NSArray *NGODisplayArray;
@property (strong, nonatomic) JOYDonatee *donatee;

@end

static NSString * const kPartnerCellIdentifier = @"PartnerCell";

@implementation PartnersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.NGOArray = [NSArray array];
//    self.NGODisplayArray = [NSArray array];
    self.donatee = [[JOYDonatee alloc] init];
    self.donatee.name = @"Avanti Fellow";
    self.donatee.descriptionText = @"Avanti Fellow description";
    self.donatee.iconImageURL = @"https://images-housing.s3.amazonaws.com/static_assets/cards/hdpi/profile.png";
    self.donatee.accpetedDonationCategories = JOYAcceptedDonationCategoriesBooks | JOYAcceptedDonationCategoriesToys;
    
    self.NGODisplayArray = [NSArray arrayWithObjects:self.donatee, self.donatee, self.donatee, self.donatee, self.donatee, self.donatee, self.donatee, self.donatee, self.donatee, self.donatee, nil];
    self.NGOArray = self.NGODisplayArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.NGODisplayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JOYPartnerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPartnerCellIdentifier];
    cell.NGOName.text = ((JOYDonatee *)self.NGODisplayArray[indexPath.row]).name;
    cell.NGODescription.text = ((JOYDonatee *)self.NGODisplayArray[indexPath.row]).descriptionText;
    NSString *donationString = @"";
    
    switch (((JOYDonatee *)self.NGODisplayArray[indexPath.row]).accpetedDonationCategories) {
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
    cell.NGODonationType.text = donationString;
    NSString *imgURL = ((JOYDonatee *)self.NGODisplayArray[indexPath.row]).iconImageURL;
    [cell.NGOImageView sd_setImageWithURL:[NSURL URLWithString:imgURL]];

    return cell;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    if(self.NGODisplayArray.count == 0){
        self.NGODisplayArray = self.NGOArray;
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.searchBar layoutIfNeeded];
    } completion:^(BOOL finished) {
        [searchBar resignFirstResponder];
        [self.tableView reloadData];
        self.searchBar.text = @"";
    }];

}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.NGODisplayArray = [NSMutableArray arrayWithArray:[self.NGOArray filteredArrayUsingPredicate:predicate]];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
   
    searchBar.showsCancelButton = NO;

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.searchBar layoutIfNeeded];
    } completion:^(BOOL finished) {
        [searchBar resignFirstResponder];
    }];

}

@end
