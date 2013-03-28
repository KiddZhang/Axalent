//
//  DBConnection.m
//  ibaodao
//
//  Created by JimmyZhang on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DBConnection.h"

#define DB_NAME                 @"/axalent_db.sqlite"

@implementation DBConnection 

@synthesize mainDB;

- (void)dealloc
{
    [self closeDataBase];
    [mainDB release];
    [super dealloc];
}


- (void) closeDataBase
{
    [mainDB close];
}

- (BOOL)initDataBase
{
    BOOL success = YES;
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingString:DB_NAME];
    
    
    if ( mainDB ) {
        return YES;
    }
    
    if ( [[NSFileManager defaultManager] fileExistsAtPath:writableDBPath]) {
        mainDB = [[FMDatabase databaseWithPath:writableDBPath] retain];
        if ([mainDB open]) {
            [mainDB setShouldCacheStatements:YES];
            success = YES;
        } else {
            NSLog(@"Failed to open database.");
            success = NO;
        }

    }
    
    return success;
}

@end
