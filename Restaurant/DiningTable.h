//
//  Table.h
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>




typedef NS_ENUM(NSInteger, TableType)
{
    TableTypeSquare = 0,
    TableTypeRound = 1
};

@interface DiningTable : NSObject <NSCoding>

@property(nonatomic, assign) NSInteger number;
@property(nonatomic, assign) TableType type;
@property(nonatomic, assign) CGRect rect;
@property(nonatomic, assign) NSInteger seats;
@property(nonatomic, assign) CGFloat sizeRatio;


@end
