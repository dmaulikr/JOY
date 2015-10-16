//
//  ProfileViewController.m
//  Joy
//
//  Created by Tejas Nikumbh on 10/16/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileViewControllerTableViewCell.h"

@interface ProfileViewController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUserInfo];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupStyles];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeStyles];
}


#pragma mark Styling Methods
- (void)setupUserInfo {
    
    // Retrieving the image from disk
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/myImage.png"];
    NSFileHandle* myFileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    UIImage* loadedImage = [UIImage imageWithData:[myFileHandle readDataToEndOfFile]];
    //Setting the image as the profile image
    self.profilePicImageView.image = loadedImage;
    
    if(self.user != nil){
        self.userName.text = self.user.name;
    }else{
        self.userName.text = @"Vivek Ravi";
    }
}
- (void)setupStyles {
    self.profilePicContainerView.layer.cornerRadius = 50;
    self.profilePicContainerView.layer.masksToBounds = YES;
    self.navigationController.navigationBarHidden = YES;
}

- (void)removeStyles {
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark TableView DataSource Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileViewControllerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileViewCell"];

    switch (indexPath.row) {
        case 0:
            cell.title.text = @"Edit Profile";
            break;
        case 1:
            cell.title.text = @"About Us";
            break;
        case 2:
            cell.title.text = @"Feedback";
            break;
        case 3:
            cell.title.text = @"Rate";
            break;
        default:
            cell.title.text = @"Default";
            break;
    }
    
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

#pragma mark TableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0: // Edit Profile is clicked
            [self performSegueWithIdentifier:@"showEditProfile" sender:nil];
            break;
        default:
            break;
    }
}
@end
