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

static NSString * const kRemoteAPIBaseURL = @"http://bhargavs-macbook-pro.local";


typedef NS_ENUM(NSUInteger, JOYDonationStatus) {
    JOYDonationStatusUnknown,
    JOYDonationStatusRequest,
    JOYDonationStatusPending,
    JOYDonationStatusInTransit,
    JOYDonationStatusCompleted,
    JOYDonationStatusRejectByNGO,
    JOYDonationStatusRejectByUser
};

typedef NS_OPTIONS(NSUInteger, JOYAcceptedDonationCategories) {
    JOYAcceptedDonationCategoriesUnknown = 0,
    JOYAcceptedDonationCategoriesBooks = 1 << 1,
    JOYAcceptedDonationCategoriesClothes = 1 << 2,
    JOYAcceptedDonationCategoriesToys = 1 << 3
};

typedef NS_ENUM(NSUInteger, JOYUserRole) {
    JOYUserRoleUnknown,
    JOYUserRoleDonor,
    JOYUserRoleDonatee
};

#endif /* JOYConstants_h */
