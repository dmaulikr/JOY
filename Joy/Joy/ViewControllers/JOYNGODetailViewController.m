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

@end

@implementation JOYNGODetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)donatePressed:(id)sender {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
