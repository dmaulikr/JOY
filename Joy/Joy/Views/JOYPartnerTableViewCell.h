//
//  JOYPartnerTableViewCell.h
//  Joy
//
//  Created by Pritesh Nandgaonkar on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JOYPartnerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *NGOImageView;
@property (weak, nonatomic) IBOutlet UILabel *NGOName;
@property (weak, nonatomic) IBOutlet UILabel *NGODescription;
@property (weak, nonatomic) IBOutlet UILabel *NGODonationType;

@end
