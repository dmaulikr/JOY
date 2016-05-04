//
//  JOYDonation.m
//  Joy
//
//  Created by Anil Giri on 16/10/15.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYDonation.h"
@interface JOYDonation ()

@property (assign, nonatomic) NSNumber *from;
@property (assign, nonatomic) NSNumber *to;


@end

@implementation JOYDonation

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return  @{
              @"donationID" : @"id",
              @"category"   : @"category_name",
              @"status"     : @"status",
              @"numBoxes"   : @"number_of_boxes",
              @"donatee" : @"ngo",
              @"feedBackImgURL" : @"feedback_images",
              @"from" : @"from",
              @"to" : @"to",
              @"donationDate" : @"created_date.date"
              };
}

+ (NSValueTransformer *)fromJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
        
        return [NSNumber numberWithInteger:[obj integerValue]/100];
    }];
}

+ (NSValueTransformer *)donationDateJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
        NSString * dateString = [NSString stringWithFormat: @"%@",obj];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        [df setDateFormat:@"dd"];
        NSString *myDayString = [df stringFromDate:[NSDate date]];
        
        [df setDateFormat:@"MMM"];
        NSString *myMonthString = [df stringFromDate:[NSDate date]];
        
        [df setDateFormat:@"yy"];
        NSString *myYearString = [df stringFromDate:[NSDate date]];
        
        dateString = [NSString stringWithFormat:@"%@ %@'%@", myDayString, myMonthString, myYearString];
        
        return dateString;
    }];
}

+ (NSValueTransformer *)toJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
        
        return [NSNumber numberWithInteger:[obj integerValue]/100];
    }];
}


+ (NSValueTransformer *)categoryJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
        __block JOYAcceptedDonationCategories temp = JOYAcceptedDonationCategoriesUnknown;
            if([obj isEqualToString:@"Book"]) {
                temp = JOYAcceptedDonationCategoriesBooks;
            }
            else if([obj isEqualToString:@"Clothes"]){
                temp = JOYAcceptedDonationCategoriesClothes;
            }
            else if([obj isEqualToString:@"Toys"]){
                temp = JOYAcceptedDonationCategoriesToys;
            }
        return [NSNumber numberWithInteger:temp];
    }];
}

//+ (NSValueTransformer *)numBoxesJSONTransformer{
//    return [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
//        
//            return [NSNumber numberWithInteger:obj];
//    }];
//}

+ (NSValueTransformer *)feedBackImgURLJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
        
        return [obj objectAtIndex:0];
    }];
}


+ (NSValueTransformer *)statusJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
        
        __block JOYDonationStatus temp = JOYDonationStatusUnknown;
        if([obj isEqualToString:@"DELIVERED"]) {
            temp = JOYDonationStatusCompleted;
        }
        else if([obj isEqualToString:@"REJECT_BY_NGO"]){
            temp = JOYDonationStatusRejectByNGO;
        }
        else if([obj isEqualToString:@"REJECT_BY_DONOR"]){
            temp = JOYDonationStatusRejectByUser;
        }
        else if([obj isEqualToString:@"REQUEST"]){
            temp = JOYDonationStatusRequest;
        }
        else if([obj isEqualToString:@"PENDING"]){
            temp = JOYDonationStatusPending;
        }
        else if([obj isEqualToString:@"TRANSIT"]){
            temp = JOYDonationStatusInTransit;
        }
//        else if([obj isEqualToString:@"DELIVERED"]){
//            temp = JOYDonationStatusCompleted;
//        }
        
        return [NSNumber numberWithInteger:temp];
    }];
}

+ (NSValueTransformer *)donateeJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
        
            return [MTLJSONAdapter modelOfClass:JOYDonatee.class fromJSONDictionary:obj error:nil];
    }];
}

- (NSString *)timeSlots {
    
    NSString *combined = [[self.from stringValue] stringByAppendingString:[NSString stringWithFormat:@"-%@",[self.to stringValue]]];
    _timeSlots = combined;
    return combined;
}

- (NSString *)categoryToString {
    NSString *val = @"";
    switch (self.category) {
        case JOYAcceptedDonationCategoriesBooks:
            val = @"books";
            break;
            case JOYAcceptedDonationCategoriesToys:
            val = @"toys";
            break;
            case JOYAcceptedDonationCategoriesClothes:
            val = @"clothes";
            break;
        default:
            break;
    }
    return val;
}
- (NSString *)numBoxesToString {
    NSString *val = @"";
    val = [NSString stringWithFormat:@"%ld", self.numBoxes];
    return val;
}



@end

