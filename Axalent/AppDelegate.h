//
//  AppDelegate.h
//  Axalent
//
//  Created by kiddz on 13-3-23.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"
#import "CustomTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CustomNavigationBar *customNavigationBar;
@property (nonatomic, strong) CustomTabBarController  *tabbarController;
@end
