//
//  ViewController.m
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "ViewController.h"
#import "DiningTableView.h"
#import "RoomViewController.h"



#define kPadding 10.0f
#define kTableDefaultWidth  60.0f
#define kTableDefaultHeight 60.0f
#define kTableXSpacing 20.0f
#define kTableYSpacing 20.0f



@interface ViewController ()
@property(nonatomic, assign) BOOL roomHasNoSpace;
@property(nonatomic, strong) NSMutableArray *tableViews;
@property(nonatomic, strong) DiningTableView *selectedTable;
@property(nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property(nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property(nonatomic, strong) RoomPickerController *roomPicker;
@property(nonatomic, strong) NSMutableArray *rooms;
@property(nonatomic, strong) UIPopoverController *roomPickerPopover;
@property(nonatomic, strong) RoomViewController *roomViewController;

@end

@implementation ViewController


-(void)setup {
    _tableViews = [[NSMutableArray alloc] init];
    // Create and initialize a tap gesture
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    _tapRecognizer.numberOfTapsRequired = 1;
    
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    _rooms = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addTable:(id)sender {
    
#if 0
    NSLog(@"roomView, %@", NSStringFromCGRect(self.roomView.frame));
    
    static CGFloat startX = kPadding;
    static CGFloat startY = kPadding;
    
    
    CGFloat maxWidth = CGRectGetWidth(self.roomView.frame);
    CGFloat maxHeight = CGRectGetHeight(self.roomView.frame);
    
    if(startX + kTableXSpacing + kTableDefaultWidth > maxWidth) {
        //no space for new table
        return;
    }
    
    DiningTableView *table = [[DiningTableView alloc] init];
    table.frame = CGRectMake(startX, startY, kTableDefaultWidth, kTableDefaultHeight);
    table.tableType = _tableViews.count % 2 == 0 ? TableTypeSquare : TableTypeRound;
    
    // Add the tap gesture recognizer to the view
    [table addGestureRecognizer:_tapRecognizer];
    [table addGestureRecognizer:_panRecognizer];
    
    
    [self.roomView addSubview:table];
    [_tableViews addObject:table];
    [table setTag:_tableViews.count-1];
    
    if(startY + kTableYSpacing + kTableDefaultHeight > maxHeight) {
        //no space to put table vertically, move to another column
        startX += kTableXSpacing + kTableDefaultWidth;
        startY = kPadding;
    } else {
        startY += kTableYSpacing + kTableDefaultHeight;
    }
#endif
}

-(void)handleTap:(UITapGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"tapped, %ld", sender.view.tag);
        if(sender.view != _selectedTable) {
            [_selectedTable unselect];
            _selectedTable = (DiningTableView *)sender.view;
            [_selectedTable select];
        }
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    NSLog(@"handlePan, %ld", recognizer.state);
#if 0
    
    CGPoint translation = [recognizer translationInView:self.roomView];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.roomView];
#endif
}

- (void)addRoom:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create a Room" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    alert.delegate = self;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *txtField = [alertView textFieldAtIndex:0];
    
    NSString *title = txtField.text;
    NSLog(@"The name is %@",title);
    if([title length] > 0) {
        Room *room = [[Room alloc] init];
        room.name = title;
        [_rooms addObject:room];
    }
}

- (IBAction)pickRoom:(id)sender {
    if(_rooms == nil) return;
    
    if(_roomPicker == nil) {
        _roomPicker = [[RoomPickerController alloc] initWithStyle:UITableViewStylePlain];
        _roomPicker.delegate = self;
    }
    
    if (_roomPickerPopover == nil) {
        NSArray* copyRooms = [_rooms copy];
        [_roomPicker setRooms:copyRooms];
        
        _roomPickerPopover = [[UIPopoverController alloc] initWithContentViewController:_roomPicker];
        _roomPickerPopover.delegate = self;
        
        [_roomPickerPopover presentPopoverFromRect:_btnPickRoom.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
    } else {
        [_roomPickerPopover dismissPopoverAnimated:YES];
        _roomPickerPopover = nil;
    }
}

-(void)selectedRoom:(Room *)room {
    //set the btn text
    [_btnPickRoom setTitle:room.name forState:UIControlStateNormal];
    
    //Dismiss the popover if it's showing.
    if (_roomPickerPopover) {
        [_roomPickerPopover dismissPopoverAnimated:YES];
        _roomPickerPopover = nil;
    }
    
    if( _roomViewController == nil) {
        //Create the room view and add it into current view
        _roomViewController = [[RoomViewController alloc] initWithFrame:_roomViewPlaceHolder.frame];
        [self.view addSubview:_roomViewController.view];
    }
    
    if(_roomViewController.room != room) {
        [_roomViewController loadRoom:room];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    NSLog(@"popover did dismissed");
    _roomPickerPopover = nil;
}

@end
