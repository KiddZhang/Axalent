//
//  LocationDetailsViewController.h
//  Axalent
//
//  Created by kiddz on 13-3-22.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationDetailsViewController : UIViewController <UITextFieldDelegate>

- (IBAction)addRoomButtonTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *LocationNameLabel;
@property (retain, nonatomic) IBOutlet UIScrollView *roomsLayout;
@property (retain, nonatomic) NSString *locationID;


- (IBAction)pushToDetails:(id)sender;

@end
