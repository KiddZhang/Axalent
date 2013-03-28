//
// Created by kiddz on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BaseDAO.h"
#import "Room.h"


@interface RoomDAO : BaseDAO

- (BOOL)addRoom:(Room *)room;
- (NSMutableArray *)queryAllRoomsWithLocationID:(NSString *)locationID;

@end