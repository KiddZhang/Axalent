//
//  Location.m
//  Axalent
//
//  Created by kiddz on 13-3-21.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "Location.h"

@implementation Location

- (void)dealloc
{
    [_uid release];
    [_name release];
    [_icon_id release];
    [_icon_image_name release];
    
    [_rooms release];
    [_devices release];

    [super dealloc];
}


- (id)init
{
    if (!_rooms) {
        _rooms = [[NSMutableArray alloc] init];
    }
    if (!_devices){
        _devices = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
