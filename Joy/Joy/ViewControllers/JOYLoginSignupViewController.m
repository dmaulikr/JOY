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
@property (nonatomic) BOOL firstTime;


@end

@implementation JOYLoginSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeToSignUp:nil];
    self.firstTime = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppers:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappers:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillAppers:(NSNotification *)notif
{
    NSDictionary* info = [notif userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.signInButtonBottomConstraint.constant = kbSize.height;
    self.createAccountButtonBottomConstraint.constant = kbSize.height;;
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
    self.firstTime = YES;
}

- (IBAction)changeToSignUp:(id)sender
{
    self.signInButton.hidden = YES;
    self.createAccountButton.hidden = NO;
    self.changeToSignInButton.titleLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    self.changeToSignUpButton.titleLabel.textColor = [UIColor whiteColor];
    self.signupView.hidden = NO;
    self.signinView.hidden = YES;
    self.firstTime = YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat height = 0;
    CGFloat lastHeight = self.scrollView.contentOffset.y;
    if (self.signInButton.hidden)//signup
    {
        height = lastHeight;
        if (self.firstTime)
            height = 120.0;
        
    }
    else//signin
    {
        height = lastHeight;
    }
    self.scrollView.contentOffset = CGPointMake(0, height);
    self.firstTime = NO;
}


- (IBAction)signInButtonClicked:(id)sender
{
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    
    NSURL * url = [NSURL URLWithString:@"http://bhargavs-macbook-pro.local/hackathon/api/v1/login"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.signinEmailTextField.text forKey:@"email"];
    [param setObject:self.signinPasswordTextField.text forKey:@"password"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:kNilOptions error:nil];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:data];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (dict && [dict[@"status"] isEqualToString:@"ok"])
        {
            
        }
        else
        {
            //show error
        }
        NSLog(@"%@", dict);
        
        
    }];
    [dataTask resume];
}

- (IBAction)createAccountButtonClicked:(id)sender
{
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    
    NSURL * url = [NSURL URLWithString:@"http://bhargavs-macbook-pro.local/hackathon/api/v1/login"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.signupEmailTextField.text forKey:@"email"];
    [param setObject:self.signunPasswordTextField.text forKey:@"password"];
    [param setObject:self.signupNameTextField.text forKey:@"name"];
    [param setObject:self.signupNumberTextField.text forKey:@"number"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:kNilOptions error:nil];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:data];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (dict && [dict[@"status"] isEqualToString:@"ok"])
        {
            
        }
        else
        {
            //show error
        }
        NSLog(@"%@", dict);
        
        
    }];
    [dataTask resume];
}



@end
