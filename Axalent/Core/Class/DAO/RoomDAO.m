//
// Created by kiddz on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RoomDAO.h"
#import "DeviceDAO.h"
#import "Device.h"

@implementation RoomDAO {

}

- (BOOL)addRoom:(Room *)room
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO 'room' ('name', 'location_id') values ('%@', '%@');", room.name, room.location_id];
    return [dbManager.mainDB executeUpdate:sql];
}

- (BOOL)removeRoom:(Room *)room
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FORM 'room' WHERE uid = %@);", room.uid];
    return [dbManager.mainDB executeUpdate:sql];
}

- (NSMutableArray *)queryAllRoomsWithLocationID:(NSString *)locationID
{
    NSMutableArray *results = [[[NSMutableArray alloc] init] autorelease];
    DeviceDAO *deviceDAO = [[[DeviceDAO alloc] init] autorelease];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ROOM where location_id = %@", locationID];
    FMResultSet *rs = [[dbManager mainDB] executeQuery:sql];
    while (rs.next) {
        Room *room = [[Room alloc] init];
        [room setUid:[rs stringForColumn:@"uid"]];
        [room setName:[rs stringForColumn:@"name"]];
        [room setLocation_id:[rs stringForColumn:@"location_id"]];
        [room setFrame_id:[rs stringForColumn:@"frame_id"]];
        [room setDevices:[deviceDAO queryDeviceWithRoomId:room.uid]];
        [results addObject: room];
        [room release];
    }
    return results;
}
@end