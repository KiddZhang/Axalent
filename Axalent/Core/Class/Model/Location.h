//
//  Location.h
//  Axalent
//
//  Created by kiddz on 13-3-21.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon_id;
@property (nonatomic, copy) NSString *icon_image_name;

@property (nonatomic, copy) NSMutableArray *rooms;
@property (nonatomic, copy) NSMutableArray *devices;


@end
