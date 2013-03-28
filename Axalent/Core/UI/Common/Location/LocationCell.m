//
//  LocationCell.m
//  Axalent
//
//  Created by kiddz on 13-3-21.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "LocationCell.h"
@interface LocationCell()
{
    IBOutlet    UIImageView *_bgImageView;
    IBOutlet    UIButton    *_iconBtn;
    IBOutlet    UILabel     *_nameLabel;
    IBOutlet    UIButton    *_lockBtn;
}

@end

@implementation LocationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)applyCellWithLocation:(Location *)location
{
    [_nameLabel setText:location.name];
    [_iconBtn setImage:[UIImage imageNamed:location.icon_image_name] forState:UIControlStateNormal];
    [_lockBtn setImage:[UIImage imageNamed:@"locked"] forState:UIControlStateNormal];
    [_lockBtn setImage:[UIImage imageNamed:@"unlocked"] forState:UIControlStateSelected];
    
    [self updateBackground:NORMAL];
}

- (void)applyCellWithDevice:(Device *)device
{
    [_nameLabel setText:device.displayName];
    [_iconBtn setImage:[UIImage imageNamed:device.icon_image_name] forState:UIControlStateNormal];
    [_lockBtn setImage:[UIImage imageNamed:@"locked"] forState:UIControlStateNormal];
    [_lockBtn setImage:[UIImage imageNamed:@"unlocked"] forState:UIControlStateSelected];
    
    [self updateBackground:UNCONNECTED];
}

- (void)updateBackground:(enum DEVICE_STATUS)deviceStatus
{
    NSString *imageName = @"";
    
    switch (deviceStatus) {
        case NORMAL:
            imageName = @"bg_black";
            break;
        case UNCONNECTED:
            imageName = @"bg_yellow";
            break;
        case ALARMING:
            imageName = @"bg_red";
            break;
        default:
            break;
    }
    
    UIImage *bgImage = [UIImage imageNamed:imageName];
    bgImage = [bgImage stretchableImageWithLeftCapWidth:floorf(bgImage.size.width/2) topCapHeight:floorf(bgImage.size.height/2)];
    [_bgImageView setImage:bgImage];
}

- (IBAction)lockBtnPressed:(UIButton *)sender {
    [_lockBtn setSelected:!sender.selected];
}

@end
