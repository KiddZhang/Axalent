//
//  BaseViewController.m
//  Axalent
//
//  Created by kiddz on 13-3-23.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark- custom methods
- (void)addBgImageView
{
    UIImageView *bgImageView = [[[UIImageView alloc] initWithFrame:self.view.frame] autorelease];
    [bgImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
    [self.view insertSubview:bgImageView atIndex:0];
}

- (void)changeTitleView
{
    UIView *titleView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    if (_titleImage) {
        [_titleImage setFrame:CGRectMake(0, 0, 320, 44)];
        [titleView addSubview:_titleImage];
    } else {
        UILabel *lblView = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)] autorelease];
        //        [lblView setBackgroundColor:[UIColor colorWithRed:1 green:0.95 blue:0.93 alpha:1.0]];
        [lblView setBackgroundColor:[UIColor clearColor]];
        [lblView setTextColor:[UIColor whiteColor]];
        [lblView setTextAlignment:UITextAlignmentCenter];
        [lblView setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:20]];
        [lblView setText:[self title]];
        [titleView addSubview:lblView];
        [lblView setCenter:[titleView center]];
    }
    
    [[self navigationItem] setTitleView:titleView];
}

@end
