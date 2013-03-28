//
//  CoreService.m
//  Axalent
//
//  Created by kiddz on 13-3-23.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "CoreService.h"
#import "GDataXMLNode.h"
#import "XMLReader.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "Attribute.h"
#import <objc/runtime.h>

#define MaxConcurrentOperationCount 3
@interface CoreService()
{

}
@property (nonatomic, strong) ASINetworkQueue   *networkQueue;
@property (nonatomic, strong) NSTimer           *autoUpdateDeviceAttributesTimer;
@end

@implementation CoreService

- (void)dealloc
{
    if (_networkQueue) {
        [_networkQueue cancelAllOperations];
        [_networkQueue release];
    }
//    if (self.autoUpdateDeviceAttributesTimer) {
//        [_autoUpdateDeviceAttributesTimer invalidate];
//        [_autoUpdateDeviceAttributesTimer release];
//    }
    [_systemInfo release];
    [_currentUser release];
    [_existsDeviceArray release];
    [_triggerArray release];
    [_alarmingDeviceArray release];
    [_unconnectedDeviceArray release];
    
    [super dealloc];
}

+ (CoreService *)sharedCoreService
{
    static CoreService *coreService = nil;
    if (!coreService) {
        coreService = [[CoreService alloc] init];
    }
    return coreService;
}

- (id)init
{
    _networkQueue = [[ASINetworkQueue alloc] init];
    [_networkQueue setMaxConcurrentOperationCount:MaxConcurrentOperationCount];
    [_networkQueue setShouldCancelAllRequestsOnFailure:NO];
    
    _systemInfo = [[SystemInfo alloc] init];
    return self;
}

- (void)loadHttpURL:(NSString *)urlString withParams:(NSMutableDictionary *)dic withCompletionBlock:(void (^)(id data))completionHandler withErrorBlock:(void (^)(NSError *error))errorHandler
{
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request;
    if (dic && [dic.allKeys count]>0) {
        request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        for (NSString *key in dic.allKeys) {
            [((ASIFormDataRequest *)request) addPostValue:[dic objectForKey:key] forKey:key];
        }
    }else{
        request = [ASIHTTPRequest requestWithURL:url];
    }
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        completionHandler(responseString);
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        DLog(@"%@",[error description]);
        if (errorHandler) {
            errorHandler(error);
        }
    }];
    [request setShouldAttemptPersistentConnection:NO];
    [request setValidatesSecureCertificate:NO];
    [self.networkQueue addOperation:request];
    
    if ([self.networkQueue isSuspended]) {
        [self.networkQueue go];
    }
}

- (NSMutableArray *)getPropertyList:(Class)clazz
{
    NSMutableArray *propertyArray = [[[NSMutableArray alloc] init] autorelease];
    unsigned int nCount;
    objc_property_t *properties = class_copyPropertyList(clazz, &nCount);
    for (int i = 0; i < nCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithFormat:@"%s",property_getName(property)];
        [propertyArray addObject:propertyName];
        //        DLog(@"class name is = %s && attr = %s", property_getName(property), property_getAttributes(property));
    }
    return propertyArray;
}

- (NSDictionary *)convertXml2Dic:(NSString *)xmlString withError:(NSError **)errorPointer
{
    return [XMLReader dictionaryForXMLString:xmlString error:errorPointer];
}

- (id)convertXml2Obj:(NSString *)xmlString withClass:(Class)clazz
{
    NSMutableArray *propertyList = [self getPropertyList:clazz];
    NSError *error;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:1 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    
    id obj = [[[clazz alloc] init] autorelease];
    if ([rootElement elementsForName:@"id"] && [propertyList containsObject:@"uid"]) {
        id propertyValue = [[[rootElement elementsForName:@"id"] objectAtIndex:0]stringValue];
        [obj setValue:propertyValue forKey:@"uid"];
    }
    for (NSString *propertyName in propertyList) {
        if ([rootElement elementsForName:propertyName]) {
            id propertyValue = [[[rootElement elementsForName:propertyName] objectAtIndex:0]stringValue];
            [obj setValue:propertyValue forKey:propertyName];
        }
    }
    
    return obj;
}

- (NSMutableArray *)convertXml2Objs:(NSString *)xmlString withClass:(Class)clazz
{
    NSMutableArray *propertyList = [self getPropertyList:clazz];
    NSMutableArray *objectArray = [[[NSMutableArray alloc] init] autorelease];
    NSError *error;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:1 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    DLog(@"rootElement name = %@ , childrenCount = %d", [rootElement name], [rootElement childCount]);
    NSArray *childrenArray = [rootElement children];
    for (GDataXMLElement *childElement in childrenArray) {
        id obj = [[clazz alloc] init];
        if ([childElement elementsForName:@"id"] && [propertyList containsObject:@"uid"]) {
            id propertyValue = [[[childElement elementsForName:@"id"] objectAtIndex:0]stringValue];
            [obj setValue:propertyValue forKey:@"uid"];
        }
        for (NSString *propertyName in propertyList) {
            if ([childElement elementsForName:propertyName]) {
                id propertyValue = [[[childElement elementsForName:propertyName] objectAtIndex:0]stringValue];
                [obj setValue:propertyValue forKey:propertyName];
            }
        }
        [objectArray addObject:obj];
        [obj release];
    }
    
    return objectArray;
}

- (void)systemLogin
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", RequestURLPrefix, SystemLogin, nil];
    NSMutableDictionary *argumentsDic = [[[NSMutableDictionary alloc] init] autorelease];
    [argumentsDic setObject:SystemAccountName forKey:@"name"];
    [argumentsDic setObject:SystemAccountPassword forKey:@"password"];
    [self loadHttpURL:urlString
           withParams:argumentsDic
  withCompletionBlock:^(id data) {
      self.systemInfo = [self convertXml2Obj:data withClass:[SystemInfo class]];
      
  } withErrorBlock:nil];
}

- (void)getExistsDevices
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", RequestURLPrefix, GetDeviceList, nil];
    NSMutableDictionary *argumentsDic = [[[NSMutableDictionary alloc] init] autorelease];
    [argumentsDic setObject:self.currentUser.userId forKey:@"userId"];
    [argumentsDic setObject:self.currentUser.securityToken forKey:@"secToken"];
    [self loadHttpURL:urlString
           withParams:argumentsDic
  withCompletionBlock:^(id data) {
      self.existsDeviceArray = [self convertXml2Objs:data withClass:[Device class]];
      for (Device *device in self.existsDeviceArray) {
          [self getDeviceAttributesWithValues:device];
          [self getDevicePresenceInfo:device];
      }
      [self filterAlarmingDevices];
      [self filterUnconnectedDevices];
      
  } withErrorBlock:nil];
}

- (void)getTriggerDetailListByUser
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", RequestURLPrefix, GetTriggerDetailListByUser, nil];
    NSMutableDictionary *argumentsDic = [[[NSMutableDictionary alloc] init] autorelease];
    [argumentsDic setObject:self.currentUser.userId forKey:@"userId"];
    [argumentsDic setObject:self.currentUser.securityToken forKey:@"secToken"];
    [self loadHttpURL:urlString
           withParams:argumentsDic
  withCompletionBlock:^(id data) {
      self.triggerArray = [self convertXml2Objs:data withClass:[Trigger class]];
  } withErrorBlock:nil];
}

- (void)getDeviceAttributesWithValues:(Device *)device
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", RequestURLPrefix, GetDeviceAttributesWithValues, nil];
    NSMutableDictionary *argumentsDic = [[[NSMutableDictionary alloc] init] autorelease];
    [argumentsDic setObject:device.devId forKey:@"devId"];
    [argumentsDic setObject:device.typeId forKey:@"deviceTypeId"];
    [argumentsDic setObject:self.currentUser.securityToken forKey:@"secToken"];
    [self loadHttpURL:urlString
           withParams:argumentsDic
  withCompletionBlock:^(id data) {
      NSMutableArray *attributeArray = [self convertXml2Objs:data withClass:[Attribute class]];
      [attributeArray removeObjectAtIndex:0];
      [attributeArray removeObjectAtIndex:0];
      [device setAttributeArray:attributeArray];

  } withErrorBlock:nil];
}

- (void)getDevicePresenceInfo:(Device *)device
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", RequestURLPrefix, GetDevicePresenceInfo, nil];
    NSMutableDictionary *argumentsDic = [[[NSMutableDictionary alloc] init] autorelease];
    [argumentsDic setObject:device.devId forKey:@"devId"];
    [argumentsDic setObject:self.currentUser.securityToken forKey:@"secToken"];
    [self loadHttpURL:urlString
           withParams:argumentsDic
  withCompletionBlock:^(id data) {
      NSDictionary *result = [self convertXml2Dic:data withError:nil];
      NSString *state = [[[result objectForKey:@"ns1:getDevicePresenceInfoResponse"] objectForKey:@"state"] objectForKey:@"text"];
      [device setState:state];
  } withErrorBlock:nil];
}

- (void)startDetecting
{
    if (!_autoUpdateDeviceAttributesTimer) {
        self.autoUpdateDeviceAttributesTimer = [NSTimer scheduledTimerWithTimeInterval:DeviceInfoDetectTimeInterval
                                                                                target:self
                                                                              selector:@selector(detecting)
                                                                              userInfo:nil
                                                                               repeats:YES];
    }
}

- (void)detecting
{
    DLog(@"detecting");
    [self getExistsDevices];
    [self getTriggerDetailListByUser];
}

- (void)filterUnconnectedDevices
{
    if (self.existsDeviceArray.count > 0) {
        self.unconnectedDeviceArray = [[[NSMutableArray alloc] init] autorelease];
        for (Device *device in self.unconnectedDeviceArray ) {
            if (device.state && [device.state isEqualToString:@"0"]) {
                [self.unconnectedDeviceArray addObject:device];
            }
        }
    }
}

- (void)filterAlarmingDevices
{
    if (self.existsDeviceArray.count > 0 && self.triggerArray.count > 0) {
        self.alarmingDeviceArray = [[[NSMutableArray alloc] init] autorelease];
        for (Device *device in self.existsDeviceArray) {
            for (Trigger *trigger in self.triggerArray) {
                if ([self isAlarmingDevice:device withTrigger:trigger]) {
                    [self.alarmingDeviceArray addObject:device];
                }
            }
        }
    }
}

- (BOOL)isAlarmingDevice:(Device *)device withTrigger:(Trigger *)trigger
{
    if ([device.devId isEqualToString:trigger.devId]) {
        for (Attribute *attribute in device.attributeArray) {
            if([attribute.name isEqualToString: trigger.attrName]){
                return [self isFitOperation:trigger.operation withValue:attribute.value withThreshold:trigger.threshold];
            }
        }
    }
    return NO;
}

- (BOOL)isFitOperation:(NSString *)operation withValue:(NSString *)value withThreshold:(NSString *)threshold
{
    DLog(@"operation: %@,  value: %@, threshold: %@ ", operation, value, threshold );
    if([operation isEqualToString:@">"]){
        return [value doubleValue] > [threshold doubleValue];
    }
    if([operation isEqualToString:@">="]){
        return [value doubleValue] >= [threshold doubleValue];
    }
    if([operation isEqualToString:@"=="]){
        return [value doubleValue] == [threshold doubleValue];
    }
    if([operation isEqualToString:@"<"]){
        return [value doubleValue] < [threshold doubleValue];
    }
    if([operation isEqualToString:@"<="]){
        return [value doubleValue] <= [threshold doubleValue];
    }
    DLog(@"can't recognize operation!!");
    return NO;
}


@end

