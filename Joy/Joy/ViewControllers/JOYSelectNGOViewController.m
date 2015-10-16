//
//  JOYSelectNGOViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 17/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYSelectNGOViewController.h"
#import "JOYPartnerTableViewCell.h"
#import "JOYDonatee.h"
#import "UIImageView+WebCache.h"

@interface JOYSelectNGOViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *NGOArray;
@property (strong, nonatomic) NSArray *NGODisplayArray;
@property (strong, nonatomic) JOYDonatee *donatee;

@end

static NSString * const kPartnerCellIdentifier = @"PartnerCell";

@implementation JOYSelectNGOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.NGOArray = [NSArray array];
    self.NGOArray = self.NGODisplayArray;
    [self fetchNGOListings];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"" sender:self];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    self.NGODisplayArray = self.NGOArray;
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
    if([searchText isEqualToString:@""]){
        self.NGODisplayArray = self.NGOArray;
    }
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

- (void)fetchNGOListings{
    NSURLSessionDataTask *ngoLists = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://bhargavs-macbook-pro.local/hackathon/api/v1/ngos"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error || !data) return;
        NSMutableArray *array = [NSMutableArray array];
        NSArray *dataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        [dataDict enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JOYDonatee *donatee = [MTLJSONAdapter modelOfClass:JOYDonatee.class fromJSONDictionary:obj error:nil];
            [array addObject:donatee];
        }];
        
        self.NGOArray = array;
        self.NGODisplayArray = self.NGOArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [ngoLists resume];
}

- (IBAction)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end
