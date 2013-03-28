//
//  LoginViewController.m
//  Axalent
//
//  Created by kiddz on 13-3-21.
//  Copyright (c) 2013年 Kiddz. All rights reserved.
//

#import "LoginViewController.h"
#import "CoreService.h"
#import "User.h"

@interface LoginViewController ()
{
    IBOutlet    UITextField     *_usernameField;
    IBOutlet    UITextField     *_passwordField;
    IBOutlet    UIButton        *_rememberBtn;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self prepareData];
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(UIButton *)sender {
    
    #ifdef NO_LOGIN
    [self dismissModalViewControllerAnimated:YES];
    #else
    NSString *urlString = [NSString stringWithFormat:@"%@%@", RequestURLPrefix, UserLogin, nil];
    NSMutableDictionary *argumentsDic = [[[NSMutableDictionary alloc] init] autorelease];
    [argumentsDic setObject:_usernameField.text forKey:@"name"];
    [argumentsDic setObject:_passwordField.text forKey:@"password"];
    [argumentsDic setObject:[[[CoreService sharedCoreService] systemInfo] appId] forKey:@"appId"];
    [[CoreService sharedCoreService] loadHttpURL:urlString
                                      withParams:argumentsDic
                             withCompletionBlock:^(id data) {
                                 User *user = [[CoreService sharedCoreService] convertXml2Obj:data withClass:[User class]];
                                 if (user.securityToken) {
                                     [[CoreService sharedCoreService] setCurrentUser:user];
                                     [[CoreService sharedCoreService] startDetecting];
                                     [self dismissModalViewControllerAnimated:YES];
                                 }

                             } withErrorBlock:nil];
    
    #endif
    
    
}

- (void)prepareData
{

}

- (void)initUI
{
    [self addBgImageView];
    
    [_rememberBtn setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:UIControlStateNormal];
    [_rememberBtn setImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateSelected];
    [_rememberBtn setSelected:YES];

}

- (IBAction)rememberBtnSelected:(UIButton *)sender {
    [_rememberBtn setSelected:!sender.selected];
    
}


@end
