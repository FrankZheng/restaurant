//
//  RestaurantLayoutViewController.m
//  Restaurant
//
//  Created by zhengxiaoqiang on 15/4/15.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "RestaurantLayoutViewController.h"
#import "RoomSwitchViewController.h"
#import "TablePropertyEditorViewController.h"
#import "RoomViewController.h"


@interface RestaurantLayoutViewController ()
@property(nonatomic, strong) RoomSwitchViewController *roomSwitchViewController;
@property(nonatomic, strong) TablePropertyEditorViewController *tableEditorController;

@end

@implementation RestaurantLayoutViewController

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
    CGFloat bottomBarHeight = 60.0f;
    CGSize tableEditorViewSize = CGSizeMake(300, 600); //need change when xib size changed.
    CGFloat entireWidth = CGRectGetWidth(self.view.frame);
    CGFloat entireHeight = CGRectGetHeight(self.view.frame);
    CGRect tableEditorViewFrame = CGRectMake(entireWidth - tableEditorViewSize.width, 0,
                                             tableEditorViewSize.width, tableEditorViewSize.height);
    CGFloat topPadding = 10.0f;
    CGRect roomSwitchViewFrame = CGRectMake(0, topPadding,
                                            entireWidth - tableEditorViewSize.width,
                                            entireHeight - bottomBarHeight - topPadding);
    
    _tableEditorController = [[TablePropertyEditorViewController alloc] initWithFrame:tableEditorViewFrame];
    _roomSwitchViewController = [[RoomSwitchViewController alloc] initWithFrame:roomSwitchViewFrame];
    
    [self.view addSubview:_tableEditorController.view];
    [self.view addSubview:_roomSwitchViewController.view];
    
#if 0
    [self addChildViewController:_tableEditorController];
    [self addChildViewController:_roomSwitchViewController];
#endif
    
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
