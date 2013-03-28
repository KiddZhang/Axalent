//
//  LocationDetailsViewController.m
//  Axalent
//
//  Created by kiddz on 13-3-22.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "LocationDetailsViewController.h"
#import "RoomDetailsViewController.h"
#import "RoomDAO.h"
#import "RoomView.h"

@interface LocationDetailsViewController ()
{
    UIView *addRoomView;
    UITextField *roomNameTextField;

    BOOL editable;
    float destinationY;
}

@property (nonatomic, strong)  NSMutableArray *roomArray;
@end

@implementation LocationDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Location"];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                               style:UIBarButtonItemStyleDone
                                                                              target:self
                                                                              action:@selector(editRoom)] autorelease];
    [self prepareData];
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareData
{
    RoomDAO *dao = [[[RoomDAO alloc] init] autorelease];
    self.roomArray = [dao queryAllRoomsWithLocationID:_locationID];
    DLog(@"locationcount: %d", self.roomArray.count);
//    [_locationTableView reloadData];
}

- (void)initUI {
    for (int i = 0; i < self.roomArray.count; i++) {
        RoomView *roomView = [[RoomView alloc] init];
        [roomView setRoom:[self.roomArray objectAtIndex:i]];
        [roomView setFrame:CGRectMake(0, 0, 150, 150)];
        [roomView setBackgroundColor:[UIColor redColor]];
        /*
        *  set room property ...
        */
        UIPanGestureRecognizer* pgr = [[UIPanGestureRecognizer alloc]
                initWithTarget:self
                        action:@selector(handlePan:)];
        [roomView addGestureRecognizer:pgr];
        [pgr release];
        [self.roomsLayout addSubview:roomView];
        [roomView release];
    }
}

- (void)dealloc {
    [_LocationNameLabel release];
    [_roomsLayout release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setLocationNameLabel:nil];
    [self setRoomsLayout:nil];
    [super viewDidUnload];
}

-(void)handlePan:(UIPanGestureRecognizer*)pgr; {
    if (!editable) {
        return;
    }

    if (pgr.state == UIGestureRecognizerStateChanged) {
        CGPoint center = pgr.view.center;
        CGPoint translation = [pgr translationInView:pgr.view];
        center = CGPointMake(center.x + translation.x,
                center.y + translation.y);
        pgr.view.center = center;
        [pgr setTranslation:CGPointZero inView:pgr.view];
    }
    if (pgr.state == UIGestureRecognizerStateEnded) {
        CGPoint center = pgr.view.center;
        if (pgr.view.center.x > 160) {
            center.x = 240;
        } else {
            center.x = 80;
        }
        pgr.view.center = center;
        RoomView *roomView = (RoomView *)pgr.view;
        [roomView.room setFrame:pgr.view.frame];
    }
}

- (void)reArrangeRoom
{

}

- (void)editRoom
{
    editable = YES;
    UIBarButtonItem *rightBtnItem = self.navigationItem.rightBarButtonItem;
    [rightBtnItem setTitle:@"Save"];
    [rightBtnItem setAction:@selector(saveRoom)];
}

- (void)saveRoom
{
    UIBarButtonItem *rightBtnItem = self.navigationItem.rightBarButtonItem;
    [rightBtnItem setTitle:@"Edit"];
    [rightBtnItem setAction:@selector(editRoom)];
    editable = NO;

    for (int i = 0; i < self.roomArray.count; i++) {
        /*
        / DAO update
         */
    }
}

- (IBAction)addRoomButtonTapped:(id)sender {
    addRoomView = [[UIView alloc] initWithFrame:CGRectMake(10, 60, 300, 180)];
    [addRoomView setBackgroundColor:[UIColor redColor]];
    roomNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 15, 280, 44)];
    [roomNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [roomNameTextField setPlaceholder:@"Room Name"];
    [addRoomView addSubview:roomNameTextField];
    [roomNameTextField release];

    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addButton setFrame:CGRectMake(10, 130, 280, 40)];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addRoomAction) forControlEvents:UIControlEventTouchUpInside];
    [addRoomView addSubview:addButton];

    [self.view addSubview:addRoomView];
    [addRoomView release];
}

- (void)addRoomAction
{
    RoomDAO *dao = [[RoomDAO alloc] init];
    Room *room = [[Room alloc] init];
    [room setLocation_id:self.locationID];
    [room setName:roomNameTextField.text];
    [dao addRoom:room];
    [room release];
    [dao release];

    [addRoomView removeFromSuperview];
}

- (IBAction)pushToDetails:(id)sender
{
    RoomDetailsViewController *vc = [[[RoomDetailsViewController alloc] init] autorelease];
    //TODO
//    vc setCurrentRoom:<#(Room *)#>
    [self.navigationController pushViewController:vc animated:YES];
}

@end
