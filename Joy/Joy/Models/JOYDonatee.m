//
//  JOYDonatee.m
//  Joy
//
//  Created by Anil Giri on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYDonatee.h"

@implementation JOYDonatee

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return  @{
                                   @"donateeID"           :           @"ngo_id",
                                   @"name"                :           @"name",
                                   @"descriptionText"     :           @"description",
                                   @"iconImageURL"        :           @"image_path",
                                   @"url"                 :           @"link",
                                   @"mobileNum"           :           @"phone_no"
                                   };
}


@end
