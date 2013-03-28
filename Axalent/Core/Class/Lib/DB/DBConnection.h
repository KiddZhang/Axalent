//
//  DBConnection.h
//  ibaodao
//
//  Created by JimmyZhang on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

#define NumberConvert(_int) [NSNumber numberWithInt:(_int)]

@interface DBConnection : NSObject

@property (nonatomic, readonly) FMDatabase *mainDB;

- (BOOL)initDataBase;
- (void)closeDataBase;

@end
