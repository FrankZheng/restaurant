//
//  ViewController.m
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "ViewController.h"
#import "RoomViewController.h"


@interface ViewController ()
@property(nonatomic, strong) RoomPickerController *roomPicker;
@property(nonatomic, strong) NSMutableArray *rooms;
@property(nonatomic, strong) UIPopoverController *roomPickerPopover;
@property(nonatomic, strong) RoomViewController *roomViewController;

@end

@implementation ViewController


-(void)setup {
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
    static int count = 0;
    
    DiningTable *table = [[DiningTable alloc] init];
    table.type = (count++ % 2) ? TableTypeSquare : TableTypeRound;
    
    [_roomViewController addTable:table];
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
