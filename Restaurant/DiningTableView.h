//
//  TableView.h
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiningTable.h"

@interface DiningTableView : UIView

@property(nonatomic, assign) TableType tableType;
@property(nonatomic, strong) DiningTable *table;

-(void)select;
-(void)unselect;

-(instancetype) initWithTable:(DiningTable *)table;


@end
