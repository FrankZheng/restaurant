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

@interface RoomSwitchViewController ()
@property(nonatomic, strong) SlideSwitchView *slideSwitchView;
@property(nonatomic, strong) NSMutableArray *roomViewControllers;
@property(nonatomic, strong) Model* model;
@end

@implementation RoomSwitchViewController

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    
    if(self) {
        _slideSwitchView = [[SlideSwitchView alloc] initWithFrame:frame];
        _slideSwitchView.tabItemNormalColor = UIColorFromRGB(0x5f5c59);
        _slideSwitchView.tabItemSelectedColor = UIColorFromRGB(0xffffff);
        _slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
        _slideSwitchView.slideSwitchViewDelegate = self;
        //_slideSwitchView.backgroundColor = [UIColor greenColor];
        
        //setup the right side button
        UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightSideButton setImage:[UIImage imageNamed:@"icon_add_button.png"] forState:UIControlStateNormal];
        //[rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"]  forState:UIControlStateHighlighted];
        rightSideButton.frame = CGRectMake(0, 0, 42.0f, 42.0f);
        [rightSideButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _slideSwitchView.rigthSideButton = rightSideButton;
        
        // Do any additional setup after loading the view.
        [_slideSwitchView buildUI];
        
        self.view = _slideSwitchView;
        
        _roomViewControllers = [[NSMutableArray alloc] init];
        _model = [Model shareInstance];
        
    }
    return self;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
