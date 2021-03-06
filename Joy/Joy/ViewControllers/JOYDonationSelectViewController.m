//
//  JOYDonationSelectViewController.m
//  Joy
//
//  Created by Pritesh Nandgaonkar on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYDonationSelectViewController.h"
#import "JOYDonationSelectTableViewCell.h"
#import "JOYSelectQuantityViewController.h"

@interface JOYDonationSelectViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewDonation;
@property (strong, nonatomic) NSArray *donationTypes;
@property (nonatomic) NSInteger selectedRow;

@end

static NSString * const kDonationSelectCellIdentifier = @"donationCell";

@implementation JOYDonationSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.donationTypes = [NSArray arrayWithObjects:@"CLOTHES", @"BOOKS", @"TOYS", nil];
    self.tableViewDonation.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.donationTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JOYDonationSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDonationSelectCellIdentifier forIndexPath:indexPath];
    cell.donationType.text = self.donationTypes[indexPath.row];
    NSString *imagename = [NSString stringWithFormat:@"%@-1",self.donationTypes[indexPath.row]];
    cell.neImageView.image = [UIImage imageNamed:imagename];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"selectQuantity" sender:self];
}

- (IBAction)BackButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JOYSelectQuantityViewController *vc = segue.destinationViewController;
    vc.donationType = self.donationTypes[self.selectedRow];
}



@end
