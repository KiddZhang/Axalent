//
//  BaseDAO.h
//  Axalent
//
//  Created by kiddz on 13-3-23.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBConnection.h"

@interface BaseDAO : NSObject
{
    DBConnection    *dbManager;
}

@end