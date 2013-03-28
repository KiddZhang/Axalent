//
//  Device.h
//  Axalent
//
//  Created by kiddz on 13-3-24.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject

@property (nonatomic, copy) NSString *devId;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *icon_id;
@property (nonatomic, copy) NSString *icon_image_name;
@property (nonatomic, copy) NSString *room_id;

@property (nonatomic, copy) NSString *devName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *typeId;
@property (nonatomic, copy) NSString *sleepMode;
@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSMutableArray *attributeArray;


- (void)updateTriggersEnableStateByDevice:(BOOL)enable;

@end
