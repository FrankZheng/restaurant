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
#import "RoundButton.h"
#import "Utils.h"

#define kBackgroundColor 0x0F0F0F
#define kDividerColor 0x4A4A4A
#define kTopOffset 64.0f
#define kTableEditorWidth 324.0f
#define kBottomBarHeight 70.f
#define kSaveRoomButtonWidth 250.0f
#define kSaveRoomButtonHeight 30.0f
#define kDividerHeight 2.0f
#define kSaveRoomButtonColor 0x1CCA1F


@interface RestaurantLayoutViewController ()
@property(nonatomic, strong) RoomSwitchViewController *roomSwitchViewController;
@property(nonatomic, strong) TablePropertyEditorViewController *tableEditorController;
@property(nonatomic, strong) RoundButton *saveRoomButton;

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
    self.view.backgroundColor = UIColorFromRGB(kBackgroundColor);
    self.view.bounds = CGRectMake(0, -kTopOffset,
                                  CGRectGetWidth(self.view.bounds),
                                  CGRectGetHeight(self.view.bounds) - kTopOffset);
}

-(void)createSubViews {
    //left top / center is room switch view
    //left bottom is room action bar
    //right is the table editor view
    
    CGFloat entireWidth = CGRectGetWidth(self.view.bounds);
    CGFloat entireHeight = CGRectGetHeight(self.view.bounds);

    CGSize tableEditorViewSize = CGSizeMake(kTableEditorWidth, entireHeight);
    
    CGRect tableEditorViewFrame = CGRectMake(entireWidth - tableEditorViewSize.width, 0.0f,
                                             tableEditorViewSize.width, tableEditorViewSize.height);
    CGFloat topPadding = 0.0f;
    CGRect roomSwitchViewFrame = CGRectMake(0, topPadding,
                                            entireWidth - tableEditorViewSize.width,
                                            entireHeight - kBottomBarHeight - topPadding);
    
    CGRect bottomBarFrame = CGRectMake(0, CGRectGetMaxY(roomSwitchViewFrame),
                                       CGRectGetWidth(roomSwitchViewFrame), kBottomBarHeight);
    
    _tableEditorController = [[TablePropertyEditorViewController alloc] initWithFrame:tableEditorViewFrame];
    _roomSwitchViewController = [[RoomSwitchViewController alloc] initWithFrame:roomSwitchViewFrame];
    
    [self.view addSubview:_tableEditorController.view];
    [self.view addSubview:_roomSwitchViewController.view];
    
    //divider between room view / bottom bar
    CGFloat diverHeight = kDividerHeight;
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(0, entireHeight - kBottomBarHeight, roomSwitchViewFrame.size.width, diverHeight)];
    divider.backgroundColor = UIColorFromRGB(kDividerColor);
    [self.view addSubview:divider];
    
    [self createBottomButtons:bottomBarFrame];
}

-(void)createBottomButtons:(CGRect)bottomBarFrame {
    CGRect saveRoomButtonFrame = CGRectMake(0, 0, kSaveRoomButtonWidth, kSaveRoomButtonHeight);
    
    _saveRoomButton = [[RoundButton alloc] initWithFrame:saveRoomButtonFrame];
    [_saveRoomButton setBackgroundColor:UIColorFromRGB(kSaveRoomButtonColor)];
    [_saveRoomButton setTitle:@"Save Room" forState:UIControlStateNormal];
    _saveRoomButton.center = CGPointMake(CGRectGetMidX(bottomBarFrame), CGRectGetMidY(bottomBarFrame));
    [_saveRoomButton setTitleColor:UIColorFromRGB(0xF8F8F8) forState:UIControlStateNormal];
    [_saveRoomButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    [_saveRoomButton addTarget:self action:@selector(saveRoom:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveRoomButton];
}

-(IBAction)saveRoom:(id)sender {
    [[Model shareInstance] saveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
