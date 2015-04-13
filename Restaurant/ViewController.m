//
//  ViewController.m
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "ViewController.h"
#import "RoomViewController.h"
#import "Model.h"


@interface ViewController ()
@property(nonatomic, strong) RoomPickerController *roomPicker;
@property(nonatomic, strong) UIPopoverController *roomPickerPopover;
@property(nonatomic, strong) RoomViewController *roomViewController;
@property(nonatomic, weak) Model *model;

@end

@implementation ViewController


-(void)setup {
    _model = [Model shareInstance];
}

-(void)setupViews {
    NSArray *rooms = [_model getRooms];
    if(rooms.count > 0) {
        //load the first room by default
        [self setupRoomViewController:[rooms objectAtIndex:0]];
    } else {
        //hide the pick room button
        [_btnPickRoom setHidden:YES];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
}

#if 0
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
#endif

-(void)viewDidLayoutSubviews {
    [self setupViews];
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
        
        [_model addRoom:room];
        
        [self setupRoomViewController:room];
    }
}

- (void)setupRoomViewController:(Room *)room {
    
    if( _roomViewController == nil) {
        //Create the room view and add it into current view
        _roomViewController = [[RoomViewController alloc] initWithFrame:_roomViewPlaceHolder.frame];
        [self.view addSubview:_roomViewController.view];
    }
    
    if(_roomViewController.room != room) {
        [_roomViewController loadRoom:room];
    }
    
    //set the btn text
    [_btnPickRoom setHidden:NO];
    [_btnPickRoom setTitle:room.name forState:UIControlStateNormal];
}

- (IBAction)pickRoom:(id)sender {
    
    if(_roomPicker == nil) {
        _roomPicker = [[RoomPickerController alloc] initWithStyle:UITableViewStylePlain];
        _roomPicker.delegate = self;
    }
    
    if (_roomPickerPopover == nil) {
        
        [_roomPicker setRooms:[_model getRooms]];
        
        _roomPickerPopover = [[UIPopoverController alloc] initWithContentViewController:_roomPicker];
        _roomPickerPopover.delegate = self;
        
        [_roomPickerPopover presentPopoverFromRect:_btnPickRoom.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
    } else {
        [_roomPickerPopover dismissPopoverAnimated:YES];
        _roomPickerPopover = nil;
    }
}

-(void)selectedRoom:(Room *)room {
    
    //Dismiss the popover if it's showing.
    if (_roomPickerPopover) {
        [_roomPickerPopover dismissPopoverAnimated:YES];
        _roomPickerPopover = nil;
    }
    
    [self setupRoomViewController:room];
    
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    NSLog(@"popover did dismissed");
    _roomPickerPopover = nil;
}

@end
