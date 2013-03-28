//
//  Attribute.m
//  Axalent
//
//  Created by kiddz on 13-3-24.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "Attribute.h"

@implementation Attribute

- (void)dealloc
{
    [_uid release];
    [_name release];
    [_displayName release];
    [_device release];
    [_presistent release];
    [_ts release];
    [_global release];
    [_tsValueType release];
    [_enumeratedAlias release];
    [_value release];
    
    [super dealloc];
}


@end
