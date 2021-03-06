//
//  JOYDonatee.m
//  Joy
//
//  Created by Anil Giri on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYDonatee.h"
#import "JOYDonateeSlot.h"

@implementation JOYDonatee

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return  @{
                                   @"donateeID"           :           @"ngo_id",
                                   @"name"                :           @"name",
                                   @"descriptionText"     :           @"description",
                                   @"iconImageURL"        :           @"image",
                                   @"url"                 :           @"link",
                                   @"mobileNum"           :           @"phone_no",
                                   @"accpetedDonationCategories" :    @"categories",
                                   @"address" : @"address",
                                   @"slotsArray"            :         @"slots"
                                   };
}

+ (NSValueTransformer *)accpetedDonationCategoriesJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        
        __block JOYAcceptedDonationCategories temp = JOYAcceptedDonationCategoriesUnknown;
        [value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isEqualToString:@"Book"]) {
                temp = temp | JOYAcceptedDonationCategoriesBooks;
            }
            else if([obj isEqualToString:@"Clothes"]){
                temp = temp | JOYAcceptedDonationCategoriesClothes;
            }
            else if([obj isEqualToString:@"Toys"]){
                temp = temp | JOYAcceptedDonationCategoriesToys;
            }
        }];
        return [NSNumber numberWithInteger:temp];
    }];
}

+ (NSValueTransformer *)slotsArrayJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[JOYDonateeSlot class]];
}

@end
