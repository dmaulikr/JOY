//
//  JOYDonateeSlot.h
//  Joy
//
//  Created by SANCHIT GOEL on 17/10/2015.
//  Copyright © 2015 Pirates of Powai. All rights reserved.
//

#import "MTLModel.h"

@interface JOYDonateeSlot : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSInteger weekDay;
@property (nonatomic, strong) NSNumber *to;
@property (nonatomic, strong) NSNumber *from;

- (NSString *)date;
- (NSString *)slot;

@end
