//
//  ProfileViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 16/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupObservers];
    [self setupStyles];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [self removeObservers];
}

#pragma mark Setup Methods
- (void)setupStyles {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)setupObservers  {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark Listener Methods 
- (void)keyboardWillShow:(NSNotification *)notif {
    [self setContentInsetForScrollView:notif];
    [self animateSaveButton:notif];
}

- (void)keyboardWillHide:(NSNotification *)notif {
    [self setContentInsetForScrollView:notif];
    [self animateSaveButton:notif];
}

#pragma mark Utility Methods
- (void)animateSaveButton: (NSNotification *) notif{
    NSDictionary* userInfo = [notif userInfo];
    // Keyboard animation attributes from the userInfo object
    CGRect keyboardEventualFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSUInteger animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    // The change in attributes
    if (notif.name == UIKeyboardWillShowNotification){
        self.saveChangeButtonBottomConstraint.constant = keyboardEventualFrame.size.height;
    }else {
        self.saveChangeButtonBottomConstraint.constant = 0;
    }
    
    //Creating the animation!
    [self.view setNeedsUpdateConstraints];
    [UIView animateKeyframesWithDuration:animationDuration delay:0 options:animationCurve animations:^(void){
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)setContentInsetForScrollView:(NSNotification *)notif{
    NSDictionary* userInfo = [notif userInfo];
    // Keyboard animation attributes from the userInfo object
    CGRect keyboardEventualFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (notif.name == UIKeyboardWillShowNotification){
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardEventualFrame.size.height, 0);
    }else {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    
}

#pragma mark IBAction Methods
- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
