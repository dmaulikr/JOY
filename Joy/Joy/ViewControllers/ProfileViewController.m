//
//  ProfileViewController.m
//  Joy
//
//  Created by Tejas Nikumbh on 10/16/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileViewControllerTableViewCell.h"
#import "JOYUser.h"
@interface ProfileViewController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupUserInfo];
    [self setupStyles];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeStyles];
}


#pragma mark Styling Methods
- (void)setupUserInfo {
    
    if([JOYUser sharedUser].profileImageURL != nil){
//        [self.profilePicImageView sd_setImageWithURL:[NSURL URLWithString:[JOYUser sharedUser].profileImageURL ] placeholderImage:[UIImage imageNamed:@"profilepic"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (image == nil)
//                image = [UIImage imageNamed:@"profilepic"];
//        }];
    }else {
        // Writing image to the disk
        NSString* path = [NSHomeDirectory() stringByAppendingString:@"/Documents/myImage.png"];
        
        // Retrieving the image from disk
        NSFileHandle* myFileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
        UIImage* loadedImage = [UIImage imageWithData:[myFileHandle readDataToEndOfFile]];
        
        // Setting the retrieved imafge
        if (loadedImage)
            self.profilePicImageView.image = loadedImage;
    }
    
    if([JOYUser sharedUser].name){
        self.userName.text = [JOYUser sharedUser].name;
    }else{
        self.userName.text = @"Vivek Ravi";
    }
}
- (void)setupStyles {
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
