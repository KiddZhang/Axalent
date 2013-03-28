//
//  Trigger.h
//  Axalent
//
//  Created by kiddz on 13-3-24.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trigger : NSObject

@property (nonatomic, copy) NSString *triggerId;
@property (nonatomic, copy) NSString *devId;
@property (nonatomic, copy) NSString *action;
@property (nonatomic, copy) NSString *attrName;
@property (nonatomic, copy) NSString *operation;
@property (nonatomic, copy) NSString *threshold;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *autoDisarm;
@property (nonatomic, copy) NSString *disarmed;
@property (nonatomic, copy) NSString *autoDelete;
@property (nonatomic, copy) NSString *autoDisable;
@property (nonatomic, copy) NSString *enable;



@end
