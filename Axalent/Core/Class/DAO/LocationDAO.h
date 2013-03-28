//
//  LocationDAO.h
//  Axalent
//
//  Created by kiddz on 13-3-21.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAO.h"
#import "Location.h"

@interface LocationDAO : BaseDAO


- (NSMutableArray *)queryAllLocations;
- (Location *)queryLocationWithDeviceId:(NSString *)deviceId;

@end
