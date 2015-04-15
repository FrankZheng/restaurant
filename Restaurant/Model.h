//
//  Model.h
//  Restaurant
//
//  Created by zhengxiaoqiang on 15/4/13.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"

@interface Model : NSObject


+(instancetype)shareInstance;

-(void)loadData;
-(void)saveData;

-(NSArray *)getRooms;

-(NSInteger)addRoom:(Room *)room;


@end
