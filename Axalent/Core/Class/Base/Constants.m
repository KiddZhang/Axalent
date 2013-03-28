//
//  Constants.m
//  Axalent
//
//  Created by kiddz on 13-3-23.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "Constants.h"

//APP config
NSString *const NotRecallTabbar =  @"NotRecallTabbar";
NSInteger const DeviceInfoDetectTimeInterval = 30;

//System Account Info
NSString *const SystemAccountName = @"devkit1101";
NSString *const SystemAccountPassword = @"gquM34F!Ag";

//Server Info
NSString *const ServerAddress =  @"https://axalent-api.arrayent.com:8081";
NSString *const MiddlePath = @"zdk/services/zamapi";

//API-Login
NSString *const SystemLogin =  @"systemLogin";
NSString *const UserLogin =  @"userLogin";

//API-Device
NSString *const GetDeviceList = @"getDeviceList";
NSString *const GetDevicePresenceInfo =  @"getDevicePresenceInfo";
NSString *const GetDeviceAttributesWithValues =  @"getDeviceAttributesWithValues";
NSString *const SetDeviceAttribute = @"setDeviceAttribute";
NSString *const SetMultiDeviceAttributes2 = @"setMultiDeviceAttributes2";
//API-Trigger
NSString *const GetTrigger = @"getTrigger";
NSString *const GetTriggerDetailListByDevice = @"getTriggerDetailListByDevice";
NSString *const GetTriggerDetailListByUser = @"getTriggerDetailListByUser";
NSString *const UpdateTriggerEnableState = @"updateTriggerEnableState";
NSString *const UpdateTriggersEnableStateByDevice = @"updateTriggersEnableStateByDevice";

@implementation Constants

@end
