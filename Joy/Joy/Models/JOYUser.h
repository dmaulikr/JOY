//
//  JOYUser.h
//  Joy
//
//  Created by Anil Giri on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "MTLModel.h"

@interface JOYUser : MTLModel

@property (assign, nonatomic, readonly) JOYUserRole role;   // Assume JOYUserRoleDonor always in this implementation.
@property (copy, nonatomic, readonly) NSString *profileImageURL;
@property (copy, nonatomic, readonly) NSString *name;
@property (copy, nonatomic, readonly) NSString *mobileNumber;
@property (copy, nonatomic, readonly) NSString *emailID;
@property (copy, nonatomic, readonly) NSString *address;

@end
