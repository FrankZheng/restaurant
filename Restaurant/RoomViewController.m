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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
