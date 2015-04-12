//
//  DrawUtil.m
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "Drawer.h"

@interface Drawer()
@property(nonatomic, assign)CGContextRef context;

@end

@implementation Drawer
@synthesize context = _context;



-(instancetype)initWithContext:(CGContextRef)context {
    if (self = [super init]) {
        _context = context;
    }
    return self;
}

-(void)fillRect:(CGRect)rect withColor:(UIColor *)color {
    CGContextSetFillColorWithColor(_context, color.CGColor);
    //CGContextSetStrokeColorWithColor(_context, color.CGColor);
    
    CGContextFillRect(_context, rect);
}

-(void)strokeRect:(CGRect)rect withColor:(UIColor *)color lineWidth:(CGFloat) lineWidth{
    CGContextSetLineWidth(_context, lineWidth);
    CGContextSetStrokeColorWithColor(_context, color.CGColor);
    CGContextStrokeRect(_context, rect);
}

-(void)fillEllipse:(CGRect)rect withColor:(UIColor *)color {
    // Set the border width
    //CGContextSetLineWidth(_context, 1.0);
    
    // Set the circle fill color to white
    CGContextSetFillColorWithColor(_context, color.CGColor);
    
    // Set the cicle border color to white
    //CGContextSetStrokeColorWithColor(_context, color.CGColor);
    
    // Fill the circle with the fill color
    CGContextFillEllipseInRect(_context, rect);
    
    // Draw the circle border
    //CGContextStrokeEllipseInRect(_context, rect);
}

-(void)strokePath:(CGFloat)lineWidth
            start:(CGPoint) startPoint end:(CGPoint)endPoint
        withColor:(UIColor*)color {
    
    CGContextSetStrokeColorWithColor(_context, color.CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(_context, lineWidth);
    
    CGContextMoveToPoint(_context, startPoint.x, startPoint.y); //start at this point
    
    CGContextAddLineToPoint(_context, endPoint.x, endPoint.y); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(_context);
    
}



@end
