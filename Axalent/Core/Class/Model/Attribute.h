//
//  Attribute.h
//  Axalent
//
//  Created by kiddz on 13-3-24.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attribute : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *device;
@property (nonatomic, copy) NSString *presistent;
@property (nonatomic, copy) NSString *ts;
@property (nonatomic, copy) NSString *global;
@property (nonatomic, copy) NSString *tsValueType;
@property (nonatomic, copy) NSString *enumeratedAlias;
@property (nonatomic, copy) NSString *value;

@end
