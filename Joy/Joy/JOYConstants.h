//
//  JOYConstants.h
//  Joy
//
//  Created by Anil Giri on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef JOYConstants_h
#define JOYConstants_h


typedef NS_ENUM(NSUInteger, JOYDonationStatus) {
    JOYDonationStatusUnknown,
    JOYDonationStatusScheduled,
    JOYDonationStatusInTransit,
    JOYDonationStatusDelivered,
    JOYDonationStatusFeedbackReceived
};

typedef NS_ENUM(NSUInteger, JOYDonationItemCategory) {
    JOYDonationItemCategoryUnknown,
    JOYDonationItemCategoryBooks,
    JOYDonationItemCategoryClothes,
    JOYDonationItemCategoryToys
};

typedef NS_ENUM(NSUInteger, JOYUserRole) {
    JOYUserRoleUnknown,
    JOYUserRoleDonor,
    JOYUserRoleDonatee
};

#endif /* JOYConstants_h */
