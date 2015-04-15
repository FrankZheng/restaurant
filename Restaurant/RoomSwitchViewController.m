//
//  RoomSwitchViewController.m
//  Restaurant
//
//  Created by zhengxiaoqiang on 15/4/15.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "RoomSwitchViewController.h"

@interface RoomSwitchViewController ()
@property(nonatomic, strong) SlideSwitchView *slideSwitchView;
@property(nonatomic, strong) NSMutableArray *roomViewControllers;
@end

@implementation RoomSwitchViewController

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    
    if(self) {
        _slideSwitchView = [[SlideSwitchView alloc] initWithFrame:frame];
        _slideSwitchView.tabItemNormalColor = [SlideSwitchView colorFromHexRGB:@"868686"];
        _slideSwitchView.tabItemSelectedColor = [SlideSwitchView colorFromHexRGB:@"bb0b15"];
        _slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
        _slideSwitchView.slideSwitchViewDelegate = self;
        
        //setup the right side button
        UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"] forState:UIControlStateNormal];
        [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"]  forState:UIControlStateHighlighted];
        rightSideButton.frame = CGRectMake(0, 0, 20.0f, 44.0f);
        [rightSideButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _slideSwitchView.rigthSideButton = rightSideButton;
        
        self.view = _slideSwitchView;
        
        _roomViewControllers = [[NSMutableArray alloc] init];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_slideSwitchView buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    
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
