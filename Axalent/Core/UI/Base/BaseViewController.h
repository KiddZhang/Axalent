//
//  BaseViewController.h
//  Axalent
//
//  Created by kiddz on 13-3-23.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"

@interface BaseViewController : UIViewController
@property (nonatomic, retain) UIImageView *titleImage;

- (void)addBgImageView;
- (void)changeTitleView;


@end
