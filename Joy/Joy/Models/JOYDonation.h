//
//  JOYDonation.h
//  Joy
//
//  Created by Anil Giri on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "MTLModel.h"

@interface JOYDonation : MTLModel

@property (assign, nonatomic, readonly) JOYDonationItemCategory category;
@property (assign, nonatomic, readonly) JOYDonationStatus status;
@property (copy, nonatomic, readonly) NSString*  donateeID;
@property (assign, nonatomic, readonly) NSUInteger minQuantity;
@property (assign, nonatomic, readonly) NSUInteger maxQuantity;
@property (copy, nonatomic, readonly) NSString*  descriptionText;

@end
