//
//  TablePropertyEditorViewController.m
//  Restaurant
//
//  Created by zhengxiaoqiang on 15/4/15.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "TablePropertyEditorViewController.h"
#import "Utils.h"
#import "OBDragDropManager.h"

#define kBorderColor 0x000000

@interface TablePropertyEditorViewController ()

@end

@implementation TablePropertyEditorViewController

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithNibName:@"TablePropertyEditorView" bundle:nil];
    if(self) {
        //set the frame of view
        self.view.frame = frame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBorder];
    
    [self setupDragDrop];
    
    _tableNumberStepper.minimumValue = 1;
    _tableNumberStepper.maximumValue = 10;
    [_tableNumberLabel setText:@(1).stringValue];
    
    _tableSeatsStepper.minimumValue = 1;
    _tableSeatsStepper.maximumValue = 10;
    [_tableSeatsLabel setText:@(4).stringValue];
    
    _opposingSwitch.on = NO;
    
    _tableSizeSlider.minimumValue = 1.0f;
    _tableSizeSlider.maximumValue = 4.0f;
    _tableSizeSlider.value = 1;
}

-(void)setupDragDrop {
    OBDragDropManager *dragDropManager = [OBDragDropManager sharedManager];
    
    NSArray *btns = @[_btnSquare, _btnRound];
    for (UIButton *btn in btns) {
        // Drag and drop using long press
        //UILongPressGestureRecognizer *dragDropRecognizer = [dragDropManager createLongPressDragDropGestureRecognizerWithSource:self];
        //[view addGestureRecognizer:dragDropRecognizer];
        
        // Drag and drop using pan
        UIGestureRecognizer *panRecognizer = [dragDropManager createDragDropGestureRecognizerWithClass:[UIPanGestureRecognizer class] source:self];
        [btn addGestureRecognizer:panRecognizer];
    }
}

-(void) createBorder {
    //create left border
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 0.0f, 2.0, CGRectGetHeight(self.view.frame));
    leftBorder.backgroundColor = UIColorFromRGB(kBorderColor).CGColor;
    [self.view.layer addSublayer:leftBorder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tableNumberChanged:(id)sender {
    _tableNumberLabel.text = @(_tableNumberStepper.value).stringValue;
}

- (IBAction)tableSeatsChanged:(id)sender {
    _tableSeatsLabel.text = @(_tableSeatsStepper.value).stringValue;
}

- (IBAction)tableTypeChanged:(id)sender {
    NSLog(@"table type changed, %ld", (long)_tableTypeSegment.selectedSegmentIndex);
}

- (IBAction)opposingSwitched:(id)sender {
    NSLog(@"opposing swtiched, %d", _opposingSwitch.on);
}

- (IBAction)tableSizeChanged:(id)sender {
    NSLog(@"table size changed, %f", _tableSizeSlider.value);
}

- (IBAction)btnClicked:(UIButton *)sender {
    NSArray *buttons = @[_btnRound, _btnSquare];
    
    if(!sender.selected) {
        sender.selected = YES;
        for( UIButton *button in buttons) {
            if(button != sender) {
                button.selected = NO;
            }
        }
    }
}

#pragma mark - drag & drop 
-(OBOvum *) createOvumFromView:(UIView*)sourceView {
    OBOvum *ovum = [[OBOvum alloc] init];
    UIButton *sourceButton = (UIButton *)sourceView;
    ovum.dataObject = sourceButton.titleLabel.text;
    NSLog(@"ovum.dataObject is %@", ovum.dataObject);
    return ovum;
}

// Create the UIView that will follow a user's touch while it moves around the screen
-(UIView *) createDragRepresentationOfSourceView:(UIView *)sourceView inWindow:(UIWindow*)window {
    UIButton *btn = (UIButton *)sourceView;
    NSString *btnText = btn.titleLabel.text;
    
    CGRect frame = [sourceView convertRect:sourceView.bounds toView:sourceView.window];
    frame = [window convertRect:frame fromWindow:sourceView.window];
    
    UIImage *image = nil;
    if([btnText isEqualToString:@"square"]) {
        image = [UIImage imageNamed:@"square_selected"];
    } else if([btnText isEqualToString:@"round"]) {
        image = [UIImage imageNamed:@"round_selected"];
    }
    CGRect dragFrame = CGRectMake(CGRectGetMidX(frame), 0, image.size.width, image.size.height);
    
    UIImageView *dragView = [[UIImageView alloc] initWithFrame:dragFrame];
    dragView.image = image;
    return dragView;
}



//-(BOOL) shouldCreateOvumFromView:(UIView*)sourceView;

//-(void) dragViewWillAppear:(UIView *)dragView inWindow:(UIWindow*)window atLocation:(CGPoint)location;

// In all honesty, the above delegate method could also serve as a 'will begin' message
// but adding this here to be a little more explicit
//-(void) ovumDragWillBegin:(OBOvum*)ovum;

// The following allows an ovum source to react appropriate if an ovum that originated from it
// was dropped. For example, if the drag drop action is move, the source can remove the source view
//-(void) ovumWasDropped:(OBOvum*)ovum withDropAction:(OBDropAction)dropAction;

// Called regardless of whether the ovum drop was successful or cancelled
//-(void) ovumDragEnded:(OBOvum*)ovum;

// If this delegate method is implemented, OBDragDropManager will not automatically animate the returning of the ovum to the source
//-(void)handleReturningToSourceAnimationForOvum:(OBOvum*)ovum completion:(void (^)(void))completion;

//@end

@end