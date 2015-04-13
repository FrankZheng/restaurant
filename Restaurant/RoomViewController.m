//
//  RoomViewController.m
//  Restaurant
//
//  Created by Frank Zheng on 15/4/12.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "RoomViewController.h"
#import "RoomView.h"
#import "DiningTableView.h"

#define kPadding 10.0f
#define kTableDefaultWidth  60.0f
#define kTableDefaultHeight 60.0f
#define kTableXSpacing 20.0f
#define kTableYSpacing 20.0f

@interface RoomViewController()

@property(nonatomic, assign) CGRect frame;
@property(nonatomic, strong) NSMutableArray *tableViews;

@end

@implementation RoomViewController

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
        _frame = frame;
        _tableViews = [[NSMutableArray alloc] init];
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
    NSLog(@"roomView, %@", NSStringFromCGRect(self.view.frame));
    
    static CGFloat startX = kPadding;
    static CGFloat startY = kPadding;
    
    
    CGFloat maxWidth = CGRectGetWidth(self.view.frame);
    CGFloat maxHeight = CGRectGetHeight(self.view.frame);
    
    if(startX + kTableXSpacing + kTableDefaultWidth > maxWidth) {
        //no space for new table
        return;
    }
    
    DiningTableView *tableView = [[DiningTableView alloc] initWithTable:table];
    tableView.frame = CGRectMake(startX, startY, kTableDefaultWidth, kTableDefaultHeight);
    
    //add table view to room view
    [self.view addSubview:tableView];
    [_tableViews addObject:table];
    
    //add table to room
    [_room addTable:table];
    
    if(startY + kTableYSpacing + kTableDefaultHeight > maxHeight) {
        //no space to put table vertically, move to another column
        startX += kTableXSpacing + kTableDefaultWidth;
        startY = kPadding;
    } else {
        startY += kTableYSpacing + kTableDefaultHeight;
    }

}

@end
