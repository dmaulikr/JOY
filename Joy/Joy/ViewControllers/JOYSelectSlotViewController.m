//
//  JOYSelectSlotViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 17/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYSelectSlotViewController.h"
#import "JOYDonateeSlot.h"

@interface JOYSelectSlotViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray <JOYDonateeSlot *>* slotsArray;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation JOYSelectSlotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.slotsArray = self.donateeNGO.slotsArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.slotsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:2000];
    JOYDonateeSlot *slot = self.slotsArray[indexPath.row];
    label.text = [NSString stringWithFormat:@"%@ %@", [slot date], [slot slot]];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:3000];
    imageView.image = [UIImage imageNamed:@""];
    if ([indexPath isEqual:self.selectedIndexPath])
        imageView.image = [UIImage imageNamed:@""];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [self.tableView reloadData];
}

- (IBAction)scheduleVisitClicked:(id)sender
{
    [self performSegueWithIdentifier:@"confirmAddressVC" sender:self];
}

- (IBAction)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
