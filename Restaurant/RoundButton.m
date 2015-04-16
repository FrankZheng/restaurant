//
//  RoundButton.m
//  Restaurant
//
//  Created by Frank Zheng on 15/4/16.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "RoundButton.h"

#define kCornerRadius 4.0f

@implementation RoundButton

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    self.layer.cornerRadius = kCornerRadius;
}

@end
