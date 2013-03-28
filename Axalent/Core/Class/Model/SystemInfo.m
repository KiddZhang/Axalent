//
//  SystemInfo.m
//  Axalent
//
//  Created by kiddz on 13-3-21.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "SystemInfo.h"

@implementation SystemInfo

- (void)dealloc
{
    [_appId release];
    [_securityToken release];
    
    [super dealloc];
}

@end
