//
//  RoomPickerController.h
//  Restaurant
//
//  Created by Frank Zheng on 15/4/12.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@protocol RoomPickerDelegate <NSObject>
@required
-(void)selectedRoom:(Room *)room;

@end

@interface RoomPickerController : UITableViewController

@property(nonatomic, weak) id<RoomPickerDelegate> delegate;

-(void)setRooms:(NSArray*)rooms;



@end
