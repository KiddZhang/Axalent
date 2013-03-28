//
//  DeviceDAO.m
//  Axalent
//
//  Created by kiddz on 13-3-24.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "DeviceDAO.h"

@implementation DeviceDAO

- (NSMutableArray *)queryAllDevice
{
    NSMutableArray *results = [[[NSMutableArray alloc] init]autorelease];
    NSString *sql = [NSString stringWithFormat:@"SELECT device.*, icon.image_name  FROM device, icon WHERE device.icon_id=icon.uid"];
    FMResultSet *rs = [[dbManager mainDB] executeQuery:sql];
    while (rs.next) {
        Device *device = [[[Device alloc] init] autorelease];
        [device setDevId:[rs stringForColumn:@"uid"]];
        [device setDevName:[rs stringForColumn:@"name"]];
        [device setIcon_image_name:[rs stringForColumn:@"image_name"]];
        [device setPassword:[rs stringForColumn:@"password"]];
        [device setTypeId:[rs stringForColumn:@"type_id"]];
        [device setRoom_id:[rs stringForColumn:@"room_id"]];
        
        [results addObject:device];
    }
    return results;
}


- (NSMutableArray *)queryDeviceWithRoomId:(NSString *)roomId
{
    NSMutableArray *results = [[[NSMutableArray alloc] init]autorelease];
    NSString *sql = [NSString stringWithFormat:@"SELECT device.*, icon.image_name  FROM device, icon WHERE device.icon_id=icon.uid and device.room_id=%@", roomId];
    FMResultSet *rs = [[dbManager mainDB] executeQuery:sql];
    while (rs.next) {
        Device *device = [[[Device alloc] init] autorelease];
        [device setDevId:[rs stringForColumn:@"uid"]];
        [device setDevName:[rs stringForColumn:@"name"]];
        [device setDisplayName:[rs stringForColumn:@"display_name"]];
        [device setIcon_image_name:[rs stringForColumn:@"image_name"]];
        [device setPassword:[rs stringForColumn:@"password"]];
        [device setTypeId:[rs stringForColumn:@"type_id"]];
        [device setRoom_id:[rs stringForColumn:@"room_id"]];
        
        [results addObject:device];
    }
    return results;
}

@end
