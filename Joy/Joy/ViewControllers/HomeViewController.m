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
#import "JOYUser.h"
#import "JOYDonation.h"
#import "JOYDonationSummaryCancelPickUp.h"


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *noDonationsView;
@property (weak, nonatomic) IBOutlet UIView *donationsView;
@property (strong, nonatomic) JOYDonation *selectedDonation;
@property (strong, nonatomic) NSArray *donationsArray;
- (IBAction)makeDonationButtonClicked:(UIButton *)button;

@end

static NSString * const kSelectDonationSegueKey = @"selectDonation";

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noDonationsView.hidden = YES;
    self.donationsView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.noDonationsView.hidden = YES;
    self.donationsView.hidden = YES;
    [self fetchData];

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
    }
    else
    {
        JOYPreviousDonationsTableViewCell *previousDonationCell = (JOYPreviousDonationsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ngoCell" forIndexPath:indexPath];
        ((UILabel *)[previousDonationCell viewWithTag:1]).text = ((JOYDonation *)self.donationsArray[indexPath.row]).donatee.name;
        ((UILabel *)[previousDonationCell viewWithTag:2]).text = [NSString stringWithFormat:@"%@ %@ donations",[((JOYDonation *)self.donationsArray[indexPath.row]) numBoxesToString], [((JOYDonation *)self.donationsArray[indexPath.row]) categoryToString]];
        ((UILabel *)[previousDonationCell viewWithTag:3]).text = [NSString stringWithFormat:@"donation made on %@ at %@ ", ((JOYDonation *)self.donationsArray[indexPath.row]).donationDate, ((JOYDonation *)self.donationsArray[indexPath.row]).timeSlots];
        UIImageView *imageView = (UIImageView *)[previousDonationCell viewWithTag:4];
        [imageView sd_setImageWithURL:[NSURL URLWithString:((JOYDonation *)self.donationsArray[indexPath.row]).donatee.iconImageURL]];

        UIImageView *imageView1 = (UIImageView *)[previousDonationCell viewWithTag:5];
        imageView1.image = [UIImage imageNamed:[((JOYDonation *)self.donationsArray[indexPath.row]) categoryToString]];
        if(((JOYDonation *)self.donationsArray[indexPath.row]).status == JOYDonationStatusRejectByNGO || ((JOYDonation *)self.donationsArray[indexPath.row]).status == JOYDonationStatusRejectByUser){
            ((UILabel *)[previousDonationCell viewWithTag:3]).text = @"CANCELLED";
        }
        
        cell = previousDonationCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        self.selectedDonation = self.donationsArray[indexPath.row];
        [self performSegueWithIdentifier:@"donationsHomeSummary" sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return 232.0;
    else
        return 110.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - IBAction Methods

- (IBAction)makeDonationButtonClicked:(UIButton *)button
{
    [self performSegueWithIdentifier:kSelectDonationSegueKey sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:kSelectDonationSegueKey]) {
        
    }
    else if([[segue identifier] isEqualToString:@"donationsHomeSummary"]){
        JOYDonationSummaryCancelPickUp *vc = segue.destinationViewController;
        vc.donation = self.selectedDonation;
    }
}

- (void)fetchData
{
    NSString *postURLString = [kRemoteAPIBaseURL stringByAppendingString:@"/hackathon/api/v1/user/%@/donations"];

    NSURLSessionDataTask *ngoLists = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[ NSString stringWithFormat:postURLString, [JOYUser sharedUser].userID]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error || !data) return;
        
       __block NSMutableArray *array = [NSMutableArray array];
        NSArray *dataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        [dataDict enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            JOYDonation *donation = [MTLJSONAdapter modelOfClass:JOYDonation.class fromJSONDictionary:obj error:nil];
            NSLog(@"Donation, %@", donation);
            [array addObject:donation];
        }];
        
        if (array.count == 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.noDonationsView.hidden = NO;
                self.donationsView.hidden = YES;
            });
        }
        else
        {
            self.donationsArray = [NSArray arrayWithArray:array];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.noDonationsView.hidden = YES;
                self.donationsView.hidden = NO;
                [self.tableView reloadData];

            });
        }
        }];

    [ngoLists resume];

}

@end
