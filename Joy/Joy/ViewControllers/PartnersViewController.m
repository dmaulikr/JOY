//
//  PartnersViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 16/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "PartnersViewController.h"
#import "JOYPartnerTableViewCell.h"

@interface PartnersViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *NGOArray;
@property (strong, nonatomic) NSArray *NGODisplayArray;

@end

static NSString * const kPartnerCellIdentifier = @"PartnerCell";

@implementation PartnersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.NGOArray = [NSArray array];
    self.NGODisplayArray = self.NGOArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.NGODisplayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JOYPartnerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPartnerCellIdentifier];
    return cell;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.NGODisplayArray = [NSMutableArray arrayWithArray:[self.NGOArray filteredArrayUsingPredicate:predicate]];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

@end
