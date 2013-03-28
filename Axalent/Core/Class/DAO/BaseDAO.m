//
//  BaseDAO.m
//  Axalent
//
//  Created by kiddz on 13-3-23.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "BaseDAO.h"

@implementation BaseDAO

- (id)init
{
    if (self = [super init]) {
        dbManager = [[DBConnection alloc] init];
        [dbManager initDataBase];
    }
    return self;
}

- (void)dealloc
{
    [dbManager closeDataBase];
    [dbManager release];
    [super dealloc];
}
@end