//
//  TableView.m
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "DiningTableView.h"
#import "Drawer.h"

@interface DiningTableView()

@property(nonatomic, assign) BOOL isSelected;

@end

@implementation DiningTableView

-(instancetype) initWithTable:(DiningTable *)table {
    if (self = [super init]) {
        _table = table;
    }
    return self;
}

-(instancetype) init {
    if(self = [super init]) {
        //self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(CGRect) getTableFrame {
    static const CGFloat padding = 20.0;
    CGRect rect = CGRectInset(self.bounds, padding, padding);
    
    return rect;
}

-(void) drawRoundTable:(CGContextRef)context {
    Drawer *drawer = [[Drawer alloc] initWithContext:context];
    [drawer fillEllipse:[self getTableFrame] withColor:[UIColor whiteColor]];
}

-(void) drawSquareTable:(CGContextRef)context {
    Drawer *drawer = [[Drawer alloc] initWithContext:context];
    [drawer fillRect:[self getTableFrame] withColor:[UIColor whiteColor]];
}

-(void) drawBorder:(CGContextRef) context {
    Drawer *drawer = [[Drawer alloc] initWithContext:context];
    [drawer strokeRect:[self bounds] withColor:[UIColor redColor] lineWidth:1.0];
}

-(void) drawChairs:(CGContextRef) context {
    static const CGFloat chairWidth = 10.0;
    static const CGFloat chairHeight = 5.0;
    
    CGRect tableFrame = [self getTableFrame];
    
    //draw chairs from top -> right -> bottom -> left
    CGFloat tableWidth = CGRectGetWidth(tableFrame);
    CGFloat tableHeight = CGRectGetHeight(tableFrame);
    
    CGPoint topLeft = tableFrame.origin;
    CGPoint topRight = CGPointMake(topLeft.x + tableWidth-1, topLeft.y);
    CGPoint bottomLeft = CGPointMake(topLeft.x, topLeft.y + tableHeight-1);
    
    CGFloat start = (tableWidth - chairWidth) / 2; //consider one chair on each side for now.
    
    CGRect rt1 = CGRectMake(topLeft.x + start, topLeft.y - chairHeight + 1, chairWidth, chairHeight);
    CGRect rt2 = CGRectMake(topRight.x, topLeft.y + start, chairHeight, chairWidth);
    CGRect rt3 = CGRectMake(bottomLeft.x + start, bottomLeft.y, chairWidth, chairHeight);
    CGRect rt4 = CGRectMake(topLeft.x - start + 1, topLeft.y + start, chairHeight, chairWidth);
    
    CGRect chairRects[] = { rt1, rt2, rt3, rt4 };
    
    Drawer *drawer = [[Drawer alloc] initWithContext:context];
    UIColor *chairColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
    UIColor *chairSelectedColor = [UIColor colorWithRed:0 green:0.6 blue:0.86 alpha:1.0];
    
    if(_isSelected) {
        for (int i = 0; i < sizeof(chairRects) / sizeof(CGRect); i++) {
            [drawer fillRect:chairRects[i] withColor:chairSelectedColor];
        }
    } else {
        for (int i = 0; i < sizeof(chairRects) / sizeof(CGRect); i++) {
            [drawer strokeRect:chairRects[i] withColor:chairColor lineWidth:1.0];
        }
    }
    
    
    
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"drawRect, %@", NSStringFromCGRect(rect));
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
#if 1
    //draw border
    [self drawBorder:contextRef];
#endif
    
    [self drawChairs:contextRef];
    
    if(self.tableType == TableTypeRound) {
        [self drawRoundTable:contextRef];
    } else if(self.tableType == TableTypeSquare){
        [self drawSquareTable:contextRef];
    }
}

-(void)select {
    _isSelected = YES;
    [self setNeedsDisplay];
}

-(void)unselect {
    _isSelected = NO;
    [self setNeedsDisplay];
}



@end
