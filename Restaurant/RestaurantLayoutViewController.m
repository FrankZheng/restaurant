//
//  RestaurantLayoutViewController.m
//  Restaurant
//
//  Created by zhengxiaoqiang on 15/4/15.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "RestaurantLayoutViewController.h"
#import "SlideSwitchView.h"
#import "TablePropertyEditorViewController.h"
#import "RoomViewController.h"


@interface RestaurantLayoutViewController ()
@property(nonatomic, strong) Model* model;
@property(nonatomic, strong) SlideSwitchView *roomSwitchView;
@property(nonatomic, strong) TablePropertyEditorViewController *tableEditorController;
@property(nonatomic, strong) NSMutableArray *roomViewControllers;

@end

@implementation RestaurantLayoutViewController

-(instancetype)initWithModel:(Model *)model {
    self = [super init];
    if(self) {
        _model = model;
        _roomViewControllers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self createSubViews];
}

-(void)setup {
    //set the title on the navigation bar
    self.title = @"Restaurant Layout";
    //adjust the bounds to avoid the subview overlapped with navigationbar
    float NavBarHeight = self.navigationController.navigationBar.frame.size.height;
    self.view.bounds = CGRectOffset(self.view.bounds, 0, -NavBarHeight);
    
    
}

-(void)createSubViews {
    //left top / center is room switch view
    //left bottom is room action bar
    //right is the table editor view
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
