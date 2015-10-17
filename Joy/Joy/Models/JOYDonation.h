//
//  JOYDonation.h
//  Joy
//
//  Created by Anil Giri on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "MTLModel.h"
#import "JOYDonatee.h"
#import "JOYDonateeSlot.h"

@class Donatee;

@interface JOYDonation : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *donationID;
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) JOYAcceptedDonationCategories category;
@property (assign, nonatomic) JOYDonationStatus status;
@property (assign, nonatomic) NSUInteger numBoxes;
@property (nonatomic, strong) NSString *feedBackImgURL;

@property (nonatomic, strong, getter = timeSlots) NSString *timeSlots;
@property (nonatomic, strong) NSString *donationDate;

@property (strong, nonatomic) JOYDonatee *donatee;
@property (nonatomic) NSUInteger slotId;
@property (strong, nonatomic) JOYDonateeSlot *slot;

- (NSString *)categoryToString;
- (NSString *)numBoxesToString;

@end
