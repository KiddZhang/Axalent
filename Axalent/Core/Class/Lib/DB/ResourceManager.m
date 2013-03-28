//
//  ResourceManager.m
//  TAGH1886
//
//  Created by Robert.Qiu on 10-9-5.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ResourceManager.h"
#import "UIDevice-Hardware.h"

static ResourceManager *_instance = nil;

@implementation ResourceManager

+ (ResourceManager*)defaultManager{

    @synchronized(_instance){
        
        if(!_instance){
            _instance = [[ResourceManager alloc] init];
        }
    }
    return _instance;
}

- (id)init{
    if(self = [super init]){
		NSString* st = [[UIDevice currentDevice] platformString];
        NSLog(@"======== on device: %@, %@", [UIDevice currentDevice].model, st);
        if([[UIDevice currentDevice].model isEqualToString:@"iPad"]){
            deviceType = iPad;
        } else if ([st isEqualToString:IPHONE_4_NAMESTRING]) {
			deviceType = iPad;
		} else if ([st isEqualToString:IPHONE_SIMULATOR_NAMESTRING]) {
			deviceType = iPad;
		} else {
            deviceType = iPhone;
        }
    }
    return self;
}

- (UIImage*)imageWithName:(NSString*)name{
    NSString *path;
    if([self isIPad]){
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    }
    else {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    }
    return [UIImage imageWithContentsOfFile:path];
}

- (NSString*)videoPathWithName:(NSString*)name{
    NSString *path;
    if([self isIPad]){
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
    }
    else {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
    }
    return path;
}

- (NSString*)audioPathWithName:(NSString*)name{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    return path;
}

- (BOOL)isIPad{
    return deviceType == iPad;
}

- (UIFont*)boldFontOfSize:(int)size{
    if([self isIPad]){
        return [UIFont boldSystemFontOfSize:size*2];
    }
    else {
        return [UIFont boldSystemFontOfSize:size];
    }
}

- (int)thePointValue:(int) size {
	if([self isIPad]) {
		return	size*2;
	}
	return size;
}
    
@end
