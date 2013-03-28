//
//  LocationCell.h
//  Axalent
//
//  Created by kiddz on 13-3-21.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "Device.h"

@interface LocationCell : UITableViewCell

- (void)applyCellWithLocation:(Location *)location;
- (void)applyCellWithDevice:(Device *)device;

- (void)updateBackground:(enum DEVICE_STATUS)deviceStatus;

@end
