//
//  DrawUtil.h
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Drawer : NSObject

-(instancetype)initWithContext:(CGContextRef)context;

-(void)fillRect:(CGRect)rect withColor:(UIColor *)color;

-(void)strokeRect:(CGRect)rect withColor:(UIColor *)color lineWidth:(CGFloat)lineWidth;

-(void)fillEllipse:(CGRect)rect withColor:(UIColor *)color;

-(void)strokePath:(CGFloat)lineWidth
            start:(CGPoint) startPoint end:(CGPoint)endPoint
        withColor:(UIColor*)color;


@end
