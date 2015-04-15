//
//  Model.m
//  Restaurant
//
//  Created by zhengxiaoqiang on 15/4/13.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "Model.h"

#define kRooms @"rooms"

@interface Model()
@property(nonatomic, strong) NSMutableArray *rooms;

@end

@implementation Model

+(instancetype)shareInstance {
    static Model *shareInstance = nil;
    
    @synchronized(self) {
        if(shareInstance == nil) {
            shareInstance = [[self alloc] init];
        }
    }
    return shareInstance;
}

-(void)loadData {
    //now load data in synchronized way
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kRooms];
    _rooms = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(_rooms == nil) {
        _rooms = [[NSMutableArray alloc] init];
    }
}

-(void)saveData {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_rooms];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kRooms];
}

-(NSArray *)getRooms {
    return [_rooms copy];
}

-(NSInteger)addRoom:(Room *)room {
    [_rooms addObject:room];
    return _rooms.count-1;
}


@end
