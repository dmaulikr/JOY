//
//  JOYLoginSignupViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 16/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYLoginSignupViewController.h"

@interface JOYLoginSignupViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *signupView;
@property (weak, nonatomic) IBOutlet UIView *signinView;
@property (weak, nonatomic) IBOutlet UITextField *signinEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *signinPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *signupNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *signunPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *signupEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *signupNumberTextField;

@property (weak, nonatomic) IBOutlet UIButton *changeToSignInButton;
@property (weak, nonatomic) IBOutlet UIButton *changeToSignUpButton;


@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signInButtonBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *createAccountButtonBottomConstraint;


@end

@implementation JOYLoginSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeToSignUp:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppers:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappers:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillAppers:(NSNotification *)notif
{
    NSDictionary* info = [notif userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.signInButtonBottomConstraint.constant = kbSize.height - self.signInButton.frame.size.height;
    self.createAccountButtonBottomConstraint.constant = kbSize.height - self.createAccountButton.frame.size.height;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
    
}

- (void)keyboardWillDisappers:(NSNotification *)notif
{
    self.signInButtonBottomConstraint.constant = 0;
    self.createAccountButtonBottomConstraint.constant = 0;
    self.scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)changeToSignIn:(id)sender
{
    self.signInButton.hidden = NO;
    self.createAccountButton.hidden = YES;
    self.changeToSignInButton.titleLabel.textColor = [UIColor whiteColor];
    self.changeToSignUpButton.titleLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    self.signinView.hidden = NO;
    self.signupView.hidden = YES;
}

- (IBAction)changeToSignUp:(id)sender
{
    self.signInButton.hidden = YES;
    self.createAccountButton.hidden = NO;
    self.changeToSignInButton.titleLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    self.changeToSignUpButton.titleLabel.textColor = [UIColor whiteColor];
    self.signupView.hidden = NO;
    self.signinView.hidden = YES;
}

- (IBAction)signInButtonClicked:(id)sender
{
}

- (IBAction)createAccountButtonClicked:(id)sender
{
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat height = 0;
    if (self.signInButton.hidden)//signup
    {
        if (textField == self.signunPasswordTextField)
            height = 100.0;
        else if (textField == self.signupNumberTextField)
            height = 40.0;
        else if (textField == self.signupEmailTextField)
            height = 90.0;
        else if (textField == self.signupNameTextField)
            height = 20.0;
    }
    else//signin
    {
        if (textField == self.signinEmailTextField)
            height = 20.0;
        else if (textField == self.signinPasswordTextField)
            height = 40.0;
    }
    self.scrollView.contentOffset = CGPointMake(0, height);
}



@end
