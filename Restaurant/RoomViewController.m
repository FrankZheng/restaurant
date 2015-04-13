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
@property(nonatomic, strong) DiningTableView *selectedTableView;
@property(nonatomic, strong) UITapGestureRecognizer *tapRecognizer;


@end

@implementation RoomViewController

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
        _frame = frame;
        [self setup];
    }
    return self;
}

-(void)setup {
    _tableViews = [[NSMutableArray alloc] init];
    //create tap recognizer to handle tap
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    _tapRecognizer.numberOfTapsRequired = 1;
}

-(void)loadView {
    self.view = [[RoomView alloc] initWithFrame:_frame];
    
    //setup the view properties
    self.view.backgroundColor  = [UIColor blackColor];
    [self.view addGestureRecognizer:_tapRecognizer];
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

-(void)handleTap:(UITapGestureRecognizer *)recognizer {
    
    //get tapped child view
    UIView* view = recognizer.view;
    CGPoint loc = [recognizer locationInView:view];
    UIView* subview = [view hitTest:loc withEvent:nil];
    
    if([subview isKindOfClass:[DiningTableView class]]) {
        if(subview != _selectedTableView) {
            //clear the current selection
            [_selectedTableView unselect];
            
            _selectedTableView = (DiningTableView *)subview;
            [_selectedTableView select];
        }
    }
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
#if 0
    //if we only use one pan gesture recognizer for all table views
    //get panned child view
    UIView* view = recognizer.view;
    CGPoint loc = [recognizer locationInView:view];
    UIView* subview = [view hitTest:loc withEvent:nil];
    NSLog(@"subview id - %ld", subview.tag);
    
    if(subview != nil && subview != self.view) {
        CGPoint translation = [recognizer translationInView:self.view];
        subview.center = CGPointMake(subview.center.x + translation.x, subview.center.y + translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:subview];
    }
#else
    //if we create a pan gesture recognizer for each table view
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

#endif
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
    
    //add a pan gesture recognizer for each table view.
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [tableView addGestureRecognizer:panRecognizer];
    
    //set a default frame for now
    tableView.frame = CGRectMake(startX, startY, kTableDefaultWidth, kTableDefaultHeight);
    
    //add table view to room view
    [self.view addSubview:tableView];
    [_tableViews addObject:tableView];
    [tableView setTag:_tableViews.count-1];
    
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
