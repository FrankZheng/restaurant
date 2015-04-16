//
//  RoomSwitchViewController.m
//  Restaurant
//
//  Created by zhengxiaoqiang on 15/4/15.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "RoomSwitchViewController.h"
#import "RoomViewController.h"
#import "Model.h"
#import "Utils.h"

#define kSwitchViewItemColor 0x5F5C59
#define kSwithViewItemSelectedColor 0xFFFFFF

@interface RoomSwitchViewController ()
@property(nonatomic, strong) SlideSwitchView *slideSwitchView;
@property(nonatomic, strong) NSMutableArray *roomViewControllers;
@property(nonatomic, strong) Model* model;
@end

@implementation RoomSwitchViewController

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    
    if(self) {
        //initialization
        _model = [Model shareInstance];
        _roomViewControllers = [[NSMutableArray alloc] init];
        
        //init switch view
        [self initSwitchView:frame];

        //load rooms
        [self loadRooms];
    }
    return self;
}

-(void)initSwitchView:(CGRect)frame {
    
    //setup switch view
    _slideSwitchView = [[SlideSwitchView alloc] initWithFrame:frame];
    _slideSwitchView.tabItemNormalColor = UIColorFromRGB(kSwitchViewItemColor);
    _slideSwitchView.tabItemSelectedColor = UIColorFromRGB(kSwithViewItemSelectedColor);
    _slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                    stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    //setup the right side button
    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_add_button.png"] forState:UIControlStateNormal];
    //[rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"]  forState:UIControlStateHighlighted];
    rightSideButton.frame = CGRectMake(0, 0, 42.0f, 42.0f);
    [rightSideButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _slideSwitchView.rigthSideButton = rightSideButton;
    
    _slideSwitchView.slideSwitchViewDelegate = self;
    self.view = _slideSwitchView;
}


-(void)loadRooms {
    //load rooms
    NSArray* rooms = [_model getRooms];
    if(rooms.count > 0) {
        for (Room *room in rooms) {
            RoomViewController* roomViewController = [[RoomViewController alloc] init];
            [_roomViewControllers addObject:roomViewController];
            [roomViewController loadRoom:room];
        }
        
        [_slideSwitchView buildUI];
        [_slideSwitchView selectTab:0]; //select the first one
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create a Room" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    alert.delegate = self;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *txtField = [alertView textFieldAtIndex:0];
    
    NSString *title = txtField.text;
    
    //create a new room
    if([title length] > 0) {
        [self addRoom:title];
    }
}

- (void)addRoom:(NSString *)title {
    
    Room *room = [[Room alloc] init];
    room.name = title;
    
    NSInteger index = [_model addRoom:room];
    
    RoomViewController* roomViewController = [[RoomViewController alloc] init];
    [_roomViewControllers addObject:roomViewController];
    [roomViewController loadRoom:room];
    
    [_slideSwitchView reloadData];
    [_slideSwitchView selectTab:index];
}


#pragma mark - SlideSwitchViewDelegate
- (NSUInteger)numberOfTab:(SlideSwitchView *)view {
    return _roomViewControllers.count;
}

- (UIViewController *)slideSwitchView:(SlideSwitchView *)view viewOfTab:(NSUInteger)number {
    return [_roomViewControllers  objectAtIndex:number];
}

- (void)slideSwitchView:(SlideSwitchView *)view didSelectTab:(NSUInteger)number {
    NSLog(@"didSelectTab, %ld", (long)number);
}

@end
