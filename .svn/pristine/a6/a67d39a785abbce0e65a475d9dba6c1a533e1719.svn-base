//
//  TLoginController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TLoginController.h"
#import "TServerFactory.h"
#import "TUserCenterServer.h"
#import "TDbuyerUser.h"
#import "TUtilities.h"

#import "TRegisterController.h"
#import "TPasswordController.h"

@implementation TLoginController

#define top_margin      20
#define left_margin     20

- (id)initWithNavigationTitle:(NSString *)title {
    [super initWithNavigationTitle:title];
    self.isPushOpen = NO;
    
    return self;
}

- (id)init {
    self = [super init];
    self.hasNavi = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect mainRect = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    UIScrollView *mainScrollView = [[[UIScrollView alloc]initWithFrame:mainRect]autorelease];
    [mainScrollView setContentSize:CGSizeMake(mainScrollView.frame.size.width, mainScrollView.frame.size.height+1)];
    [mainScrollView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
    mainScrollView.delegate = self;
    [self.contentView addSubview:mainScrollView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    CGRect loginRect = CGRectMake(left_margin, top_margin, mainScrollView.frame.size.width-2*left_margin, 180);
    _loginView = [[TLoginView alloc]initWithFrame:loginRect];
    [_loginView setTargetAction:self];
    [mainScrollView addSubview:_loginView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_loginView cleanTextFieldValue];
    [_loginView setPhoneAccount];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.leveyTabBarController hidesTabBar:NO  animated:NO];
}

- (void)setNavigationTitle {
    self.titleAttached = @"登录";
    self.hasBackAction = YES;
    [super setNavigationTitle];
}


- (void)leftButtonAction {
    [super leftButtonAction];
}

/**
 *  注册按钮被点击,跳转注册界面
 */
- (void)registerBtnAction:(id)sender {
    TRegisterController *registerController = [[TRegisterController alloc]initWithNavigationTitle:@"注册" andRightAttached:@"Register_Action.png"];
    registerController.rightAttachedImage = @"Register_Action_Clicked.png";
    [self.navigationController pushViewController:registerController animated:YES];
}

/**
 *  登录按钮被点击,发送登录请求
 */
- (void)loginBtnAction:(id)sender {
    BOOL isYES = YES;
    
    NSString *username = [_loginView getUserName];
    NSString *password = [_loginView getPassword];
    
    isYES = [_loginView updateByTextField:[_loginView.accountControl getDbuyerTextField]];
    isYES = [_loginView updateByTextField:[_loginView.accountControl getDbuyerTextField]];
    
    if (!isYES) return;
    
    
    // 发送登录请求
    [_loginView cancelKeyboard];
    [[TUtilities getInstance]popTarget:self.view];
    [[TServerFactory getServerInstance:@"TUserCenterServer"]doLoginByUserName:username andPassword:password
                                                                  andCallback:^(TDbuyerUser*dbuyerUser) {
                                         [[self mainDelegate]submitProToNet];//登录成功获取用户购物车数量
                                                                                                [[TUtilities getInstance]popMessage:@"登录成功!" target:self.view delayTime:1.f];
                                                                                                  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:dbuyerUser,@"userobject", nil];
                                                                      [self.delegate loginSuccess:dbuyerUser];
                                                                      [[NSNotificationCenter defaultCenter]postNotificationName:@"Notification_DbuyerLoginSucess" object:self userInfo:dict];
                                                                      
                                                                      [[TUtilities getInstance] storeUserInfo:username andPassword:password andUserId:dbuyerUser.serverId];
                                                                      [self leftButtonAction];
                                                                      
                                                                  } failureCallback:^(NSString *resp) {
                                                                      [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:1.f];
                                                                  }];
}

/**
 *  忘记密码按钮被点击，跳转重置密码界面
 */
- (void)forgetBtnAction:(id)sender {
    TPasswordController *passwordController = [[[TPasswordController alloc]initWithNavigationTitle:@"密码找回"]autorelease];
    [self.navigationController pushViewController:passwordController animated:YES];
}


- (void)registerSuccess:(TDbuyerUser*)dbuyerUser {
    [self.delegate loginSuccess:dbuyerUser];
    [self leftButtonAction];
}


- (void)handleTap {
    [_loginView cancelKeyboard];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_loginView cancelKeyboard];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textView {
    [_loginView updateByTextField:textView];
}

- (void) textFieldDidChange:(UITextField *) textField{
    [_loginView updateByTextField:textField];
}

- (void)dealloc {
    [super dealloc];
    
    [_loginView release];
    _loginView = nil;
}




@end
