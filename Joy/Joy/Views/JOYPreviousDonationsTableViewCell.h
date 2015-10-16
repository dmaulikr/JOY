//
//  JOYPreviousDonationsTableViewCell.h
//  Joy
//
//  Created by SANCHIT GOEL on 16/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JOYPreviousDonationsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ngoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *donationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *donationImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

@end
