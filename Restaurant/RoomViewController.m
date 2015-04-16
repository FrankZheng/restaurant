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

-(instancetype)init {
    if(self = [super init]) {
        [self setup];
    }
    return self;
}

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
    
    self.view.dropZoneHandler = self;
    //self.view.backgroundColor = [UIColor yellowColor];
}

-(void)loadView {
    self.view = [[RoomView alloc] initWithFrame:_frame];
    
    //setup the view properties
    //self.view.backgroundColor  = [UIColor blackColor];
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
    if(_room != room) {
        _room = room;
        
        //set title
        self.title = _room.name;
        //load the tables from room, and create tableviews, and load the table views
        
        for (DiningTable *table in _room.getTables) {
            [self addTable:table];
        }
    }
    
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
    [self.view bringSubviewToFront:recognizer.view];
    //if we create a pan gesture recognizer for each table view
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}



-(void)addTable:(DiningTable *)table {
    
    DiningTableView *tableView = [[DiningTableView alloc] initWithTable:table];
    
    //add a pan gesture recognizer for each table view.
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [tableView addGestureRecognizer:panRecognizer];
    
    tableView.frame = table.rect;
    
    //for now, only increase the number
    if(table.number == 0) {
        table.number = [_room getTablesCount] + 1 ; //start from 1
    }
    
    //add table view to room view
    [self.view addSubview:tableView];
    [_tableViews addObject:tableView];
    [tableView setTag:_tableViews.count-1];
    
    //add table to room
    if(![_room hasTheTable:table]) {
        [_room addTable:table];
    }
}

#pragma mark - drag & drop

-(OBDropAction) ovumEntered:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
    //NSLog(@"entered, %@", NSStringFromCGPoint(location));
    //self.view.backgroundColor = [UIColor redColor];
    return OBDropActionCopy;    // Return OBDropActionNone if view is not currently accepting this ovum
}

#if 0
-(OBDropAction) ovumMoved:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
    //NSLog(@"moved, %@", NSStringFromCGPoint(location));
    return OBDropActionMove;
}
#endif

-(void) ovumExited:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
    //self.view.backgroundColor = [UIColor clearColor];
}



-(void) ovumDropped:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
    //NSLog(@"dropped, %@", NSStringFromCGPoint(location));
    // Handle the drop action
    //NSLog(@"dropped, %@", ovum.dataObject);
    NSString *tableType = ovum.dataObject;
    DiningTable *table = [[DiningTable alloc] init];
    table.rect = CGRectMake(location.x - kTableDefaultWidth/2,
                            location.y - kTableDefaultHeight/2,
                            kTableDefaultWidth, kTableDefaultHeight);
    
    if([tableType isEqualToString:@"square"]) {
        table.type = TableTypeSquare;
    } else if([tableType isEqualToString:@"round"]) {
        table.type = TableTypeRound;
    }
    
    [self addTable:table];
}


@end
