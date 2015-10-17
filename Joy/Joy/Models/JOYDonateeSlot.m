//
//  JOYDonateeSlot.m
//  Joy
//
//  Created by SANCHIT GOEL on 17/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "JOYDonateeSlot.h"

@implementation JOYDonateeSlot

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"weekDay" : @"week_day",
             @"to" : @"to",
             @"from":@"from"
    };
}

- (NSString *)date
{
    NSDate *currentdate = [NSDate date];
    NSInteger seconds = 60*60*24*self.weekDay;
    NSDate *slotDate = [NSDate dateWithTimeInterval:seconds sinceDate:currentdate];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setDateFormat:@"dd"];
    NSString *myDayString = [df stringFromDate:slotDate];
    
    [df setDateFormat:@"MMM"];
    NSString *myMonthString = [df stringFromDate:slotDate];
    
    [df setDateFormat:@"yy"];
    NSString *myYearString = [df stringFromDate:slotDate];
    
    NSString *dateString = [NSString stringWithFormat:@"%@ %@'%@", myDayString, myMonthString, myYearString];
    
    return dateString;

}

- (NSString *)slot
{
    NSString *combined = [[self.from stringValue] stringByAppendingString:[NSString stringWithFormat:@"-%@",[self.to stringValue]]];
    return combined;
}

@end
