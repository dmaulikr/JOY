//
//  JOYLoginSignupViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 16/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYLoginSignupViewController.h"
#import "JOYUser.h"

static NSString * const kHSGUserPersistenceKey = @"HSGUserInstance";

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
    [self checkForLoggedIn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppers:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappers:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeToSignUp:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    NSURL * url = [NSURL URLWithString:[kRemoteAPIBaseURL stringByAppendingString:@"/hackathon/api/v1/login"]];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.signinEmailTextField.text forKey:@"email"];
    [param setObject:self.signinPasswordTextField.text forKey:@"password"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:kNilOptions error:nil];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:data];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSDictionary *dict = nil;
        if (data) {
            dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        }
        if (dict && [dict[@"status"] isEqualToString:@"ok"])
        {
            JOYUser *new = [JOYUser initWithDictionary:dict[@"data"]];
            JOYUser *user = [JOYUser sharedUser];
            user.name = new.name;
            user.userID = new.userID;
            user.number = new.number;
            user.addOne = new.addOne;
            user.addTwo = new.addTwo;
            user.addThree = new.addThree;
            user.emailID = new.emailID;
            user.isVerified = new.isVerified;
            user.profileImageURL = new.profileImageURL;
            user.isLoggedIn = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self startMainFlow];
            });
            [self saveUser];
            NSLog(@"here");
        }
        else
        {
            NSInteger errorCode = [dict[@"error_code"] integerValue];
            NSString *message;
            if (errorCode == 1001)
            {
                message = @"Please verify your Email Address to login.";
            }
            else if (errorCode == 1002)
            {
                message = @"You are not registered. Please register to continue.";
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"JOY"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert show];
                [self changeToSignUp:nil];
                self.signinEmailTextField.text = @"";
                self.signinPasswordTextField.text = @"";
            });

            //show error
        }
        NSLog(@"%@", dict);
        
        
    }];
    [dataTask resume];
}

- (IBAction)createAccountButtonClicked:(id)sender
{
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    
    NSURL * url = [NSURL URLWithString:[kRemoteAPIBaseURL stringByAppendingString:@"/hackathon/api/v1/register"]];
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
        
        NSDictionary *dict = nil;
        if (data) {
            dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        }
        
        if (dict && [dict[@"status"] isEqualToString:@"ok"])
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"JOY"
                                                            message:@"Verify your Email Address to login"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert show];
                [self changeToSignIn:nil];
            });
        }
        else
        {
            //show error
            NSString *errorString = [dict[@"errors"] firstObject];
            if (errorString.length == 0)
                errorString = @"Please try again later.";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                            message:errorString
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert show];
            });
        }

        NSLog(@"%@", dict);
        
        
    }];
    [dataTask resume];
}

- (void)startMainFlow
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"tabVC"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)saveUser
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:[JOYUser sharedUser]] forKey:kHSGUserPersistenceKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)checkForLoggedIn
{
    NSData *savedUserData = [[NSUserDefaults standardUserDefaults] objectForKey:kHSGUserPersistenceKey];
    JOYUser *new ;
    if(savedUserData) {
        new = [NSKeyedUnarchiver unarchiveObjectWithData:savedUserData];
        JOYUser *user = [JOYUser sharedUser];
        user.name = new.name;
        user.userID = new.userID;
        user.number = new.number;
        user.addOne = new.addOne;
        user.addTwo = new.addTwo;
        user.addThree = new.addThree;
        user.emailID = new.emailID;
        user.isVerified = new.isVerified;
        user.profileImageURL = new.profileImageURL;
        user.isLoggedIn = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self startMainFlow];
        });
    }
}


@end
