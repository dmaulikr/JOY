//
//  ProfileViewController.h
//  Joy
//
//  Created by Tejas Nikumbh on 10/16/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JOYUser.h"

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *profilePicContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) JOYUser *user;
@end
