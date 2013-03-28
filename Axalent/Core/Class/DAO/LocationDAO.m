//
//  LocationDAO.m
//  Axalent
//
//  Created by kiddz on 13-3-21.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "LocationDAO.h"
#import "Location.h"
#import "Room.h"
#import "RoomDAO.h"
#import "Device.h"
#import "DeviceDAO.h"

@implementation LocationDAO

- (BOOL)addLocation:(Location *)location
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO 'location' ('name', 'icon_id') values ('%@', '%@');", location.name, location.icon_id];
    return [dbManager.mainDB executeUpdate:sql];
}

- (BOOL)removeLocation:(Location *)location
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FORM 'location' WHERE uid = %@);", location.uid];
    return [dbManager.mainDB executeUpdate:sql];
}

- (NSMutableArray *)queryAllLocations
{
    NSMutableArray *results = [[[NSMutableArray alloc] init]autorelease];
    RoomDAO *roomDAO = [[[RoomDAO alloc] init] autorelease];
    NSString *sql = @"SELECT location.*, icon.image_name  FROM location, icon WHERE location.icon_id=icon.uid";;
    FMResultSet *rs = [[dbManager mainDB] executeQuery:sql];
    while (rs.next) {
        Location *location = [[Location alloc] init];
        [location setUid:[rs stringForColumn:@"uid"]];
        [location setName:[rs stringForColumn:@"name"]];
        [location setIcon_id:[rs stringForColumn:@"icon_id"]];
        [location setIcon_image_name:[rs stringForColumn:@"image_name"]];
        [location setRooms:[roomDAO queryAllRoomsWithLocationID:location.uid]];
        [results addObject: location];
        [location release];
    }
    
    
    return results;
}


- (Location *)queryLocationWithDeviceId:(NSString *)deviceId
{
    Location *location = [[[Location alloc] init] autorelease];
    NSString *sql = [NSString stringWithFormat:@"SELECT l.* FROM location l, (SELECT d.uid as devId, r.location_id FROM Device d, Room r where d.room_id=r.uid)  t where l.uid= t.location_id and t.devId=%@", deviceId];
    FMResultSet *rs = [[dbManager mainDB] executeQuery:sql];
    while (rs.next) {
        [location setUid:[rs stringForColumn:@"uid"]];
        [location setName:[rs stringForColumn:@"name"]];
        [location setIcon_id:[rs stringForColumn:@"icon_id"]];
        [location setIcon_image_name:[rs stringForColumn:@"image_name"]];
    }
    return location;
}


@end
