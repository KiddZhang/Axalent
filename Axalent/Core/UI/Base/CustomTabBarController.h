//
//  CustomTabBarController.h
//  InstaPrint
//
//  Created by 吴 旭东 on 12-5-3.
//  Copyright (c) 2012年 上海兕维信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarController : UITabBarController

- (UIViewController *)currentViewController;
- (void)setSelectedTab:(NSUInteger)index;
- (NSUInteger)getTabClickCount:(NSUInteger)index;
- (void) saveState:(NSInteger)locatIndex withNewTagIndexArray:(NSArray *)indexArray;
- (void) resumeState;
@end
