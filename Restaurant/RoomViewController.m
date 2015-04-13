//
//  RoomViewController.m
//  Restaurant
//
//  Created by Frank Zheng on 15/4/12.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "RoomViewController.h"
#import "RoomView.h"

@interface RoomViewController()

@property(nonatomic, assign) CGRect frame;

@end

@implementation RoomViewController

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
        _frame = frame;
    }
    return self;
}

-(void)loadView {
    self.view = [[RoomView alloc] initWithFrame:_frame];
    self.view.backgroundColor  = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadRoom:(Room *)room {
    self.room = room;
    //load the tables from room, and create tableviews, and load the table views 
}

-(void)addTable:(DiningTable *)table {
    //add a new table
    //create a table view if necessary
}

@end
