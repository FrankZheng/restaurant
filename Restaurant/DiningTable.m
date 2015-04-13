//
//  Table.m
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "DiningTable.h"

#define kNumber @"number"
#define kType @"type"
#define kRect @"rect"
#define kSeats @"seats"
#define kSizeRatio @"sizeRatio"


@implementation DiningTable

-(instancetype)init {
    if (self = [super init]) {
        //do initialization here
    }
    return self;
}

//persistence
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _number = [aDecoder decodeIntegerForKey:kNumber];
        _type = [aDecoder decodeIntegerForKey:kType];
        _rect = [aDecoder decodeCGRectForKey:kRect];
        _seats = [aDecoder decodeIntegerForKey:kSeats];
        _sizeRatio = [aDecoder decodeFloatForKey:kSizeRatio];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeInteger:_number forKey:kNumber];
    [encoder encodeInteger:_type forKey:kType];
    [encoder encodeCGRect:_rect forKey:kRect];
    [encoder encodeInteger:_seats forKey:kSeats];
    [encoder encodeFloat:_sizeRatio forKey:kSizeRatio];
}



@end
