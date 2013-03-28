//
// Created by kiddz on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Room.h"


@implementation Room {

}

- (void)dealloc {
    [_uid release];
    [_name release];
    [_location_id release];
    [_frame_id release];
    [_devices release];
    [_icon_image_name release];

    [super dealloc];
}
@end