//
//  RoomDetailsViewController.m
//  Axalent
//
//  Created by kiddz on 13-3-24.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "RoomDetailsViewController.h"
#import "RoomDAO.h"
#import "DeviceDAO.h"
#import "LocationCell.h"

@interface RoomDetailsViewController ()
{
    IBOutlet    UITextField     *_roomNameField;
    IBOutlet    UITableView     *_deviceTalbeView;
}
@property (nonatomic, strong)  NSMutableArray  *deviceArray;
@end

@implementation RoomDetailsViewController

- (void)dealloc
{
    [_currentRoom release];
    [super dealloc];
}

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
    [self prepareData];
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- tableview datasource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Device *device = [self.deviceArray objectAtIndex:indexPath.row];
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOCATION_CELL_INDENTIFIER"];
    if (!cell) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"LocationCell" owner:self options:nil];
        for (id aObj in nibArray) {
            if ([aObj isKindOfClass:[LocationCell class]]) {
                cell = (LocationCell *)aObj;
            }
        }
    }
    [cell applyCellWithDevice:device];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma  mark- custom methods
- (void)initUI
{
    [self setTitle:@"Room"];
    //    [super changeTitleView];
    [self addBgImageView];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                               style:UIBarButtonItemStyleDone
                                                                              target:self
                                                                              action:@selector(editRoom)] autorelease];
    [_roomNameField setText:self.currentRoom.name];
    
}

- (void)prepareData
{
#ifdef NO_SELECTED_ROOM
    Room *room = [[[Room alloc] init] autorelease];
    [room setUid:@"1"];
    [room setName:@"Bedroom"];
    [room setIcon_image_name:@"office"];
    self.currentRoom = room;
#endif
    DeviceDAO *dao = [[[DeviceDAO alloc] init] autorelease];
    self.deviceArray = [dao queryDeviceWithRoomId:self.currentRoom.uid];
    [_deviceTalbeView reloadData];
}



@end
