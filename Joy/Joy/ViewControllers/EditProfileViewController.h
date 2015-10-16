//
//  ProfileViewController.h
//  Joy
//
//  Created by SANCHIT GOEL on 16/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *saveChangeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saveChangeButtonBottomConstraint;

@property (weak, nonatomic) IBOutlet UIView *overlayView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIImageView *phoneNumberIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *emailIDIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *addressIconImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *emailIDField;
@property (weak, nonatomic) IBOutlet UITextField *flatNoField;
@property (weak, nonatomic) IBOutlet UITextField *societyNameField;
@property (weak, nonatomic) IBOutlet UITextField *landmarkField;

@property (weak, nonatomic) IBOutlet UIView *profilePicContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;

@property (weak, nonatomic) IBOutlet UIView *cameraIconContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *cameraIconImageView;

@property (weak, nonatomic) IBOutlet UIButton *saveChangesButtonView;
@end
