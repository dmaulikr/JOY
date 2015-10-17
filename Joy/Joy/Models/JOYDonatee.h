//
//  JOYDonatee.h
//  Joy
//
//  Created by Anil Giri on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "MTLModel.h"

@interface JOYDonatee : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *donateeID;
@property (copy, nonatomic, readonly) NSString *address;
@property (copy, nonatomic, readonly) NSString *iconImageURL;
@property (copy, nonatomic, readonly) NSString *url;
@property (copy, nonatomic, readonly) NSString *mobileNum;
@property (copy, nonatomic, readonly) NSString *name;
@property (copy, nonatomic, readonly) NSString *slogan;
@property (copy, nonatomic, readonly) NSString *descriptionText;
@property (assign, nonatomic, readonly) JOYAcceptedDonationCategories accpetedDonationCategories;
@property (copy, nonatomic, readonly) NSArray *slotsArray;

@end
