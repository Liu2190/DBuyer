//
//  TRegisterController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRegisterController.h"
#import "AgreementViewController.h"
#import "TServerFactory.h"
#import "TUserCenterServer.h"
#import "WCAlertView.h"
#import "TUtilities.h"
#import "TLoginController.h"

#define top_margin      20
#define left_margin     20

@implementation TRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
    
    CGRect mainRect = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    UIScrollView *mainScrollView = [[[UIScrollView alloc]initWithFrame:mainRect]autorelease];
    [mainScrollView setContentSize:CGSizeMake(mainScrollView.frame.size.width, mainScrollView.frame.size.height+1)];
    [mainScrollView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
    mainScrollView.delegate = self;
    [self.contentView addSubview:mainScrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    tap.numberOfTouchesRequired = 1;
    [mainScrollView addGestureRecognizer:tap];
    
    CGRect registerRect = CGRectMake(left_margin, top_margin, mainRect.size.width-2*left_margin, mainRect.size.height/2);
    _registerView = [[TRegisterView alloc]initWithFrame:registerRect];
    [_registerView setTargetAction:self];
    [mainScrollView addSubview:_registerView];
    
}

- (void)rightButtonAction {
    [super rightButtonAction];
    [_registerView cancelKeyboard];
    BOOL isValida = YES;
    
    isValida = [_registerView updateByTextField:[_registerView getPhoneToTextField]];
    isValida = [_registerView updateByTextField:[_registerView getPasswordToTextField]];
    isValida = [_registerView updateByTextField:[_registerView getRePasswordToTextField]];
    if (!isValida) return;
    
    
    NSString *code= [_registerView getVerifyCode];
    if (![code isEqualToString:_storeVerify]) {
        [WCAlertView showAlertWithTitle:@"警告" message:@"验证码输入不正确,请重新输入!" customizationBlock:^(WCAlertView * alertView1) {
            alertView1.style=WCAlertViewStyleBlack;
        }completionBlock:^(NSUInteger buttonIndex,WCAlertView * alertView){
        }cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        return;
    }
    
    
    BOOL boolValue = [_registerView getAgreementBoolValue];
    if (!boolValue) {
        [WCAlertView showAlertWithTitle:@"警告" message:@"您还没有选择同意注册协议!" customizationBlock:^(WCAlertView * alertView1) {
            alertView1.style=WCAlertViewStyleBlack;
        }completionBlock:^(NSUInteger buttonIndex,WCAlertView * alertView){
        }cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        return ;
    }

    NSString *username = [_registerView getPhoneToTextField].text;
    NSString *password = [_registerView getPasswordToTextField].text;
    [[TUtilities getInstance]popTarget:self.contentView];
    [[TServerFactory getServerInstance:@"TUserCenterServer"]doRegisterDbuyerByUserName:username
                                                                           andpassword:password andCode:code
                                                                           andCallback:^(NSString *verifyStr) {
                                                                               [WCAlertView showAlertWithTitle:@"恭喜" message:@"注册成功!" customizationBlock:^(WCAlertView * alertView1) {
                                                                                   alertView1.style=WCAlertViewStyleBlack;
                                                                               }completionBlock:^(NSUInteger buttonIndex,WCAlertView * alertView){
                                                                                   if(buttonIndex==0){
                                                                                       NSArray *controlles = self.navigationController.viewControllers;
                                                                                       for (UIViewController *contrller in controlles) {
                                                                                           if ([contrller isKindOfClass:[TLoginController class]]) {
                                                                                               [self.navigationController popToViewController:contrller animated:YES];
                                                                                           }
                                                                                       }
                                                                                       
                                                                                   }
                                                                               }cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                                                                           } failureCallback:^(NSString *resp) {
                                                                               [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.0];
                                                                           }];
    
    
}

- (void)handleTap {
    [_registerView cancelKeyboard];
}

/**
 *  查看注册协议
 */
- (void)protocolSelected {
    AgreementViewController *xie=[[[AgreementViewController alloc]init]autorelease];
    [self.navigationController pushViewController:xie animated:YES];
}

/**
 *   赞同按钮被点击
 */
- (void)agreementBtnClicked:(id)sender {
    [_registerView changeAgreementButtonImage];
}

/**
 * 获取验证码
 */
- (void)theValidaBtnClicked:(id)sender {
    NSString *phoneValue = [_registerView getPhoneToTextField].text;
    BOOL isValida = [_registerView updateByTextField:[_registerView getPhoneToTextField]];
    [_registerView cancelKeyboard];
    if (!isValida) {
        return;
    }
    
    [[TUtilities getInstance]popTarget:self.contentView];
    [[TServerFactory getServerInstance:@"TUserCenterServer"]doSendVerifyByUserName:phoneValue and:1
                                                                        andCallback:^(NSString *verifyStr) {
        [[TUtilities getInstance]dismiss];
        
        _storeVerify = verifyStr;
        [_registerView startTimer];
    } failureCallback:^(NSString *resp) {
        [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.0];
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_registerView cancelKeyboard];
}

#pragma mark -
#pragma mark UITextViewDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [_registerView updateByTextField:textField];
}

- (void) textFieldDidChange:(UITextField *) textField{
    [_registerView updateByTextField:textField];
}



@end
