//
//  Device.m
//  Axalent
//
//  Created by kiddz on 13-3-24.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "Device.h"
#import "CoreService.h"

@implementation Device

- (void)dealloc
{
    [_devId release];
    [_devName release];
    [_displayName release];
    [_typeId release];
    [_sleepMode release];
    [_icon_id release];
    [_icon_image_name release];
    [_room_id release];
    [_password release];
    [_attributeArray release];
    [_state release];
    
    [super dealloc];
}

- (id)init{
    _attributeArray = [[NSMutableArray alloc] init];
    return  self;
}

- (void)updateTriggersEnableStateByDevice:(BOOL)enable
{
    NSString *enableStr = @"1";
    if(!enable){
        enableStr = @"0";
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@", RequestURLPrefix, UpdateTriggersEnableStateByDevice, nil];
    NSMutableDictionary *argumentsDic = [[[NSMutableDictionary alloc] init] autorelease];
    [argumentsDic setObject:_devId forKey:@"devId"];
    [argumentsDic setObject:[[[CoreService sharedCoreService] currentUser] securityToken] forKey:@"secToken"];
    [argumentsDic setObject:enableStr forKey:@"enable"];
    
    [[CoreService sharedCoreService] loadHttpURL:urlString
                                      withParams:argumentsDic
                             withCompletionBlock:^(id data) {
                                    //TODO handle with error code
                            }
                                  withErrorBlock:nil];
    
}

@end
