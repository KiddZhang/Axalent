//
//  CoreService.h
//  Axalent
//
//  Created by kiddz on 13-3-23.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "SystemInfo.h"
#import "Device.h"
#import "Trigger.h"

#define RequestURLPrefix                    [NSString stringWithFormat:@"%@/%@/", ServerAddress, MiddlePath]

@interface CoreService : NSObject

@property (nonatomic, strong) User              *currentUser;
@property (nonatomic, strong) SystemInfo        *systemInfo;
@property (nonatomic, strong) NSMutableArray    *triggerArray;
@property (nonatomic, strong) NSMutableArray    *existsDeviceArray;
@property (nonatomic, strong) NSMutableArray    *alarmingDeviceArray;
@property (nonatomic, strong) NSMutableArray    *unconnectedDeviceArray;


+ (CoreService *)sharedCoreService;
- (void)loadHttpURL:(NSString *)urlString withParams:(NSMutableDictionary *)dic withCompletionBlock:(void (^)(id data))completionHandler withErrorBlock:(void (^)(NSError *error))errorHandler;

- (id)convertXml2Obj:(NSString *)xmlString withClass:(Class)clazz;
- (NSMutableArray *)convertXml2Objs:(NSString *)xmlString withClass:(Class)clazz;


- (void)systemLogin;
- (void)startDetecting;
@end
