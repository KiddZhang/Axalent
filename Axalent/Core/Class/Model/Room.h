//
// Created by kiddz on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

typedef enum {
    RoomSizeBig,
    RoomSizeMiddle,
    RoomSizeSmall
} tRoomSize;

@interface Room : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon_image_name;
@property (nonatomic, copy) NSString *location_id;
@property (nonatomic, copy) NSString *frame_id;
@property (nonatomic, assign) CGRect  frame;
@property (nonatomic, assign) tRoomSize roomSize;

@property (nonatomic, copy) NSMutableArray *devices;

@end