//
//  ProfileViewController.m
//  Joy
//
//  Created by SANCHIT GOEL on 16/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupObservers];
    [self setupGestureRecognizers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupStyles];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeStyles];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [self removeObservers];
}

#pragma mark Setup Methods
- (void)setupViews {
    self.saveChangeButton.enabled = NO;
}


- (void)setupGestureRecognizers {
    self.overlayView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizerForOverlay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOrChoosePicture)];
    [self.overlayView addGestureRecognizer:tapGestureRecognizerForOverlay];
    
    self.cameraIconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizersForCamera = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOrChoosePicture)];
    [self.cameraIconImageView addGestureRecognizer:tapGestureRecognizersForCamera];
}

- (void)setupStyles {
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.profilePicContainerView.layer.cornerRadius = 50;
    self.profilePicContainerView.layer.masksToBounds = YES;
    self.overlayView.layer.cornerRadius = 50;
    self.overlayView.layer.masksToBounds = YES;
    [self.overlayView setAlpha:0.5f];
}

- (void)removeStyles {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)setupObservers  {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark IBAction Methods
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveChangeButtonPressed:(UIButton *)sender {
    
}

#pragma mark Action Methods
- (void)redirectToCamera {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickerView animated:YES completion:nil];
    }
}

- (void)redirectToGallery {
    UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
    pickerView.allowsEditing = YES;
    pickerView.delegate = self;
    pickerView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerView animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    // Writing image to the disk
    NSString* path = [NSHomeDirectory() stringByAppendingString:@"/Documents/myImage.png"];
    
    BOOL ok = [[NSFileManager defaultManager] createFileAtPath:path
                                                      contents:nil attributes:nil];
    
    if (!ok)
    {
        NSLog(@"Error creating file %@", path);
    }
    else
    {
        NSFileHandle* myFileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [myFileHandle writeData:UIImagePNGRepresentation(image)];
        [myFileHandle closeFile];
    }
    
    // Retrieving the image from disk
    NSFileHandle* myFileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    UIImage* loadedImage = [UIImage imageWithData:[myFileHandle readDataToEndOfFile]];
    
    // Setting the retrieved imafge
    self.profilePicImageView.image = loadedImage;
    self.saveChangeButton.enabled = YES;
}

#pragma mark Selector Methods
- (void)clickOrChoosePicture {
    UIAlertController *choosePictureController = [UIAlertController alertControllerWithTitle:@"PLEASE CHOOSE A METHOD" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self redirectToCamera];
        });
        
        [choosePictureController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *gallery = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self redirectToGallery];
        });
        
        [choosePictureController dismissViewControllerAnimated:YES completion:nil];
    }];
    [choosePictureController addAction:camera];
    [choosePictureController addAction:gallery];
    [self presentViewController:choosePictureController animated:YES completion:nil];
    
    
}

#pragma mark Selector Listener Methods

- (void)textFieldChanged:(NSNotification *)notif {
    if([self areAllFieldsEmpty]){
        self.saveChangeButton.enabled = NO;
    }else{
        self.saveChangeButton.enabled = YES;
    }
}

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

- (BOOL)areAllFieldsEmpty {
    if([self.phoneNumberField.text  isEqual: @""] && [self.emailIDField.text  isEqual: @""] && [self.flatNoField.text  isEqual: @""] && [self.societyNameField.text  isEqual: @""] && [self.landmarkField.text  isEqual: @""]) {
        return true;
    }else {
        return false;
    }
}

@end
