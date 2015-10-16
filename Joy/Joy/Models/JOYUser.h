//
//  JOYUser.h
//  Joy
//
//  Created by Anil Giri on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "MTLModel.h"
#import "UIImage+MultiFormat.h"

@interface JOYUser : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic, readonly) JOYUserRole role;   // Assume JOYUserRoleDonor always in this implementation.
@property (copy, nonatomic) NSString *profileImageURL;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *number;
@property (copy, nonatomic) NSString *emailID;
@property (copy, nonatomic) NSString *addOne;
@property (copy, nonatomic) NSString *addTwo;
@property (copy, nonatomic) NSString *addThree;
@property (assign, nonatomic) BOOL isVerified;
@property (copy, nonatomic) NSString *userID;
@property (nonatomic) BOOL isLoggedIn;

+ (JOYUser *)sharedUser;
+ (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue;
@end
