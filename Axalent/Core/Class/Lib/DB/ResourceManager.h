//
//  ResourceManager.h
//  TAGH1886
//
//  Created by Robert.Qiu on 10-9-5.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    iPhone,
    iPad
} DeviceType;
@interface ResourceManager : NSObject {

    DeviceType deviceType;
}

+ (ResourceManager*)defaultManager;
- (UIImage*)imageWithName:(NSString*)name;
- (NSString*)videoPathWithName:(NSString*)name;
- (NSString*)audioPathWithName:(NSString*)name;
- (BOOL)isIPad;
- (UIFont*)boldFontOfSize:(int)size;
- (int)thePointValue:(int)size;

@end
