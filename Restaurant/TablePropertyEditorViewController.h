//
//  TablePropertyEditorViewController.h
//  Restaurant
//
//  Created by zhengxiaoqiang on 15/4/15.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBDragDropManager.h"

@interface TablePropertyEditorViewController : UIViewController<OBOvumSource>

@property (weak, nonatomic) IBOutlet UILabel *tableNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *tableSeatsLabel;
@property (weak, nonatomic) IBOutlet UIStepper *tableNumberStepper;
@property (weak, nonatomic) IBOutlet UIStepper *tableSeatsStepper;
@property (weak, nonatomic) IBOutlet UISlider *tableSizeSlider;
@property (weak, nonatomic) IBOutlet UIButton *btnSquare;
@property (weak, nonatomic) IBOutlet UIButton *btnRound;


@property (weak, nonatomic) IBOutlet UISwitch *opposingSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tableTypeSegment;

- (IBAction)tableNumberChanged:(id)sender;
- (IBAction)tableSeatsChanged:(id)sender;
- (IBAction)tableTypeChanged:(id)sender;

- (IBAction)opposingSwitched:(id)sender;
- (IBAction)tableSizeChanged:(id)sender;

- (IBAction)btnClicked:(UIButton *)sender;

- (instancetype)initWithFrame:(CGRect)frame;
@end
