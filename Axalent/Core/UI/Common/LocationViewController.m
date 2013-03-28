//
//  LocationViewController.m
//  Axalent
//
//  Created by kiddz on 13-3-21.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationCell.h"
#import "LocationDAO.h"
#import "LocationDetailsViewController.h"

@interface LocationViewController ()
{
    IBOutlet    UITableView     *_locationTableView;
}
@property (nonatomic, strong)  NSMutableArray *locationArray;
@end

@implementation LocationViewController

- (void)dealloc
{
    
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
    // Do any additional setup after loading the view from its nib.'
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
    return self.locationArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Location *location = [self.locationArray objectAtIndex:indexPath.row];
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOCATION_CELL_INDENTIFIER"];
    if (!cell) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"LocationCell" owner:self options:nil];
        for (id aObj in nibArray) {
            if ([aObj isKindOfClass:[LocationCell class]]) {
                cell = (LocationCell *)aObj;
            }
        }
    }
    [cell applyCellWithLocation:location];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Location *location = [self.locationArray objectAtIndex:(NSUInteger)indexPath.row];
    LocationDetailsViewController *vc = [[LocationDetailsViewController alloc] init];
    [vc setLocationID:location.uid];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma  mark- custom methods
- (void)initUI
{
    [self setTitle:@"Location"];
//    [super changeTitleView];
    [self addBgImageView];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                               style:UIBarButtonItemStyleDone
                                                                              target:self
                                                                              action:@selector(editRoom)] autorelease];
    
    
}

- (void)prepareData
{
    LocationDAO *dao = [[[LocationDAO alloc] init] autorelease];
    self.locationArray = [dao queryAllLocations];
    DLog(@"locationcount: %d", self.locationArray.count);
    [_locationTableView reloadData];
}

@end
