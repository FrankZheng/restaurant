//
//  RoomViewController.h
//  Restaurant
//
//  Created by Frank Zheng on 15/4/12.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
#import "DiningTable.h"
#import "OBDragDrop.h"


@interface RoomViewController : UIViewController<OBDropZone>

@property(nonatomic, strong) Room *room;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)loadRoom:(Room *)room;

-(void)addTable:(DiningTable *)table;




@end
