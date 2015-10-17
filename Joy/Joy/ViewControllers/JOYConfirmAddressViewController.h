//
//  JOYConfirmAddressViewController.h
//  Joy
//
//  Created by SANCHIT GOEL on 17/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JOYDonatee.h"

@interface JOYConfirmAddressViewController : UIViewController

@property (strong, nonatomic) JOYDonatee *donateeNGO;
@property (nonatomic) NSInteger boxCount;
@property (nonatomic, strong) NSString *donationType;
@property (nonatomic) NSInteger slotID;

@end
