//
//  Trigger.m
//  Axalent
//
//  Created by kiddz on 13-3-24.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "Trigger.h"

@implementation Trigger

- (void)dealloc
{
    [_triggerId release];
    [_devId release];
    [_action release];
    [_attrName release];
    [_operation release];
    [_threshold release];
    [_address release];
    [_msg release];
    [_autoDisarm release];
    [_disarmed release];
    [_autoDelete release];
    [_autoDisable release];
    [_enable release];
    
    [super dealloc];
}




@end
