//
//  HomeViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 16/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "HomeViewController.h"
#import "JOYPreviousDonationsTableViewCell.h"
#import "JOYMakeDonationTableViewCell.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *noDonationsView;
@property (weak, nonatomic) IBOutlet UIView *donationsView;

@property (strong, nonatomic) NSArray *donationsArray;
- (IBAction)makeDonationButtonClicked:(UIButton *)button;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noDonationsView.hidden = YES;
    self.donationsView.hidden = NO;
    self.donationsArray = @[@"abc", @"def", @"ghi", @"as", @"asas", @"qwiyd", @"duqw"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITAbleView Delegate/Datasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    else
        return self.donationsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0)
    {
        JOYMakeDonationTableViewCell *makeDonationCell = (JOYMakeDonationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"makeDonationCell" forIndexPath:indexPath];
        [makeDonationCell.makeDonationButton addTarget:self action:@selector(makeDonationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell = makeDonationCell;
        cell.backgroundColor = [UIColor redColor];
    }
    else
    {
        JOYPreviousDonationsTableViewCell *previousDonationCell = (JOYPreviousDonationsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ngoCell" forIndexPath:indexPath];
        
        cell = previousDonationCell;
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return 250.0;
    else
        return 110.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
        return 50;
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;
    if (section == 0)
    {
        headerView = [[UIView alloc] initWithFrame:CGRectZero];
        headerView.backgroundColor = [UIColor grayColor];
    }
    else
    {
        headerView = [[UIView alloc] initWithFrame:CGRectZero];
        CGRect frame = CGRectZero;
        frame.size.width = self.tableView.bounds.size.width;
        frame.size.height = 50.0;
        headerView.frame = frame;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"PREVIOUS DONATIONS";
        label.font = [UIFont systemFontOfSize:14.0];
        [label sizeToFit];
        [headerView addSubview:label];
        headerView.backgroundColor = [UIColor grayColor];
    }
    return headerView;
}

#pragma mark - IBAction Methods

- (IBAction)makeDonationButtonClicked:(UIButton *)button
{
    
}

@end
