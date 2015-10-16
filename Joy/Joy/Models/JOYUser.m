//
//  JOYUser.m
//  Joy
//
//  Created by Anil Giri on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYUser.h"

@implementation JOYUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return  @{
              @"name"                :           @"name",
              @"number"                :           @"number",
              @"isVerified"     :           @"is_verified",
              @"userID"        :           @"user_id",
              @"addOne"                 :           @"address_1",
              @"addTwo"           :           @"address_2",
              @"addThree"                   :            @"address_3",
              @"profileImageURL"   :   @"profile_image_url"
              };
}

+ (JOYUser *)sharedUser
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.isLoggedIn = NO;
    }
    return self;
}

+ (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue
{
    NSError *error;
    JOYUser *new = [MTLJSONAdapter modelOfClass:self.class fromJSONDictionary:dictionaryValue error:&error];
    if (error)
    {
        //error
    }
    return new;
}

@end
