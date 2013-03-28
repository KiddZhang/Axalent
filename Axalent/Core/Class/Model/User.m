//
//  User.m
//  Axalent
//
//  Created by kiddz on 13-3-21.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "User.h"

@implementation User

- (void)dealloc
{
    [_userId release];
    [_name release];
    [_password release];
    [_securityToken release];

    [super dealloc];
}


@end
