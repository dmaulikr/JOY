//
//  JOYSelectSlotViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 17/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYSelectSlotViewController.h"
#import "JOYDonateeSlot.h"
#import "JOYConfirmAddressViewController.h"

@interface JOYSelectSlotViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray <JOYDonateeSlot *>* slotsArray;
@property (nonatomic) NSInteger selectedRow;
@property (strong, nonatomic) JOYDonateeSlot *slot;

@end

@implementation JOYSelectSlotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.slotsArray = self.donateeNGO.slotsArray;
    self.selectedRow = -1;
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
    UILabel *label1 = (UILabel *)[cell viewWithTag:2000];
    JOYDonateeSlot *slot = self.slotsArray[indexPath.row];
    label1.text = [slot date];
    UILabel *label2 = (UILabel *)[cell viewWithTag:3000];
    label2.text = [slot slot];
    if (indexPath.row == self.selectedRow)
    {
        label1.textColor = [UIColor colorWithRed:0 green:168 blue:182 alpha:1];
        label2.textColor =  [UIColor colorWithRed:0 green:168 blue:182 alpha:1];
    }
    else
    {
        label1.textColor = [UIColor blackColor];
        label2.textColor =  [UIColor blackColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *label1 = (UILabel *)[cell viewWithTag:2000];
    UILabel *label2 = (UILabel *)[cell viewWithTag:3000];
    label1.textColor = [UIColor colorWithRed:0 green:168 blue:182 alpha:1];
    label2.textColor =  [UIColor colorWithRed:0 green:168 blue:182 alpha:1];
    self.selectedRow = indexPath.row;
    self.slot = self.slotsArray[indexPath.row];
    [self.tableView reloadData];
}

- (IBAction)scheduleVisitClicked:(id)sender
{
    if (self.selectedRow < 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"JOY"
                                                        message:@"Please select a slot for pickup"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert show];
        });
    }
    else
        [self performSegueWithIdentifier:@"confirmAddressVC" sender:self];
}

- (IBAction)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    JOYConfirmAddressViewController *vc = segue.destinationViewController;
    vc.donateeNGO = self.donateeNGO;
    vc.slot = self.slot;
    vc.donationType = self.donationType;
    vc.boxCount = self.boxCount;
    vc.slotID = self.slotsArray[self.selectedRow].slotID;   
}


@end
