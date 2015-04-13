//
//  ViewController.h
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomView.h"
#import "RoomPickerController.h"

@interface ViewController : UIViewController<RoomPickerDelegate, UIPopoverControllerDelegate>

@property(nonatomic, weak) IBOutlet UIView *roomViewPlaceHolder;
@property(nonatomic, weak) IBOutlet UIButton *btnPickRoom;


-(IBAction)addTable:(id)sender;

-(IBAction)addRoom:(id)sender;

-(IBAction)pickRoom:(id)sender;


@end

