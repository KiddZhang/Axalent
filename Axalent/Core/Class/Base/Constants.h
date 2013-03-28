//
//  Constants.h
//  Axalent
//
//  Created by kiddz on 13-3-23.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#define     NO_LOGIN
#define     NO_SELECTED_ROOM

#if defined(__cplusplus)
#define AX_EXTERN extern "C"
#else
#define AX_EXTERN extern
#endif

enum CELL_TYPE {
    LOCATION = 1,
    ROOM,
    DEVICE
};

enum DEVICE_STATUS {
    NORMAL = 1,
    UNCONNECTED,
    ALARMING
};

@interface Constants : NSObject
//AX_EXTERN NSInteger MaxRequestOperationCount;
//APP config
AX_EXTERN NSString *const NotRecallTabbar;
AX_EXTERN NSInteger const DeviceInfoDetectTimeInterval;   //seconds


//System Account Info
AX_EXTERN NSString *const SystemAccountName;
AX_EXTERN NSString *const SystemAccountPassword;

// Service Info
AX_EXTERN NSString *const ServerAddress;
AX_EXTERN NSString *const MiddlePath;

// API-Login
AX_EXTERN NSString *const SystemLogin;
AX_EXTERN NSString *const UserLogin;
//API-Device
AX_EXTERN NSString *const GetDeviceList;
AX_EXTERN NSString *const GetDevicePresenceInfo;
AX_EXTERN NSString *const GetDeviceAttributesWithValues;
AX_EXTERN NSString *const SetDeviceAttribute;
AX_EXTERN NSString *const SetMultiDeviceAttributes2;
//API-Trigger
AX_EXTERN NSString *const GetTrigger;
AX_EXTERN NSString *const GetTriggerDetailListByDevice;
AX_EXTERN NSString *const GetTriggerDetailListByUser;
AX_EXTERN NSString *const UpdateTriggersEnableStateByDevice;



@end
