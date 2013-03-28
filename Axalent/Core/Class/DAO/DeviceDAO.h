//
//  DeviceDAO.h
//  Axalent
//
//  Created by kiddz on 13-3-24.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAO.h"
#import "Device.h"

@interface DeviceDAO : BaseDAO


- (NSMutableArray *)queryAllDevice;
- (NSMutableArray *)queryDeviceWithRoomId:(NSString *)roomId;



@end
