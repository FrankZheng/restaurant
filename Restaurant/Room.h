//
//  Room.h
//  Restaurant
//
//  Created by Frank Zheng on 15/4/12.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiningTable.h"

@interface Room : NSObject <NSCoding>


@property(nonatomic, strong) NSString *name;

-(void)addTable:(DiningTable *)table;
-(NSArray*)getTables;

@end
