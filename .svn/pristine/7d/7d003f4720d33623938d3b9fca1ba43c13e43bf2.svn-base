//
//  TPasswordController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TPasswordController.h"
#import "TInputPhoneView.h"
#import "TInputVerifyView.h"
#import "TRestPassView.h"
#import "TBasePassView.h"
#import "WCAlertView.h"
#import "TServerFactory.h"
#import "TUserCenterServer.h"
#import "TUtilities.h"
#import "TLoginController.h"

#define Navigation_H    40

@implementation TPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentDisplayPage = passType_Input_Phone;
    
    UIImageView *lineView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 1)]autorelease];
    [lineView setImage:[UIImage imageNamed:@"password_line_top.png"]];
    [self.contentView addSubview:lineView];
    
    CGRect menuRect = CGRectMake(0, lineView.frame.size.height, self.contentView.frame.size.width, Navigation_H);
    _menuView = [[[TPasswordMenuView alloc]initWithFrame:menuRect]autorelease];
    [_menuView setBackgroundColor:[UIColor colorWithRed:67/255.0 green:177/255.0 blue:119/255.0 alpha:1.0]];
    [self.contentView addSubview:_menuView];
    
    CGRect mainRect = CGRectMake(0, Navigation_H+lineView.frame.size.height, self.contentView.frame.size.width, self.contentView.frame.size.height-Navigation_H-lineView.frame.size.height);
    _mainView = [[TPassScrollView alloc]initWithFrame:mainRect];
    _mainView.delegate = self;
    [self.contentView addSubview:_mainView];
    
    UIView *theView = [_mainView getPageByIndex:passType_Input_Phone];
    CGRect inputPhoneRect = CGRectMake(0, 0, theView.frame.size.width, theView.frame.size.height);
    TInputPhoneView *inputPhoneView = [[[TInputPhoneView alloc]initWithFrame:inputPhoneRect andPasswordPageType:passType_Input_Phone]autorelease];
    [inputPhoneView setTargetAction:self];
    [theView addSubview:inputPhoneView];

    theView = [_mainView getPageByIndex:passType_Input_Verify];
    CGRect inputVerifyRect = CGRectMake(0, 0, theView.frame.size.width, theView.frame.size.height);
    TInputVerifyView *inputVerifyView = [[[TInputVerifyView alloc]initWithFrame:inputVerifyRect andPasswordPageType:passType_Input_Verify]autorelease];
    [inputVerifyView setTargetAction:self];
    [theView addSubview:inputVerifyView];
    
    theView = [_mainView getPageByIndex:passType_Reset_Password];
    CGRect restPassRect = CGRectMake(0, 0, theView.frame.size.width, theView.frame.size.height);
    TRestPassView *restPassView = [[[TRestPassView alloc]initWithFrame:restPassRect andPasswordPageType:passType_Reset_Password]autorelease];
    [restPassView setTargetAction:self];
    [theView addSubview:restPassView];
}



- (void) textFieldDidChange:(UITextField *) textField{
    int pageindex = textField.tag;
    
    if (textField.tag == passType_Input_Phone) {
        
        TInputPhoneView *inputPhoneView = (TInputPhoneView*)[_mainView getContentPageByIndex:pageindex];
        if (textField == [inputPhoneView getTextField]) { // 手机号
            [inputPhoneView updateByTextField:textField];
        }
    } else if (textField.tag == passType_Input_Verify) {
        TInputVerifyView *verifyPhoneView = (TInputVerifyView*)[_mainView getContentPageByIndex:pageindex];
        if (textField == [verifyPhoneView getTextField]) { // 验证码
            [verifyPhoneView updateByTextField:textField];
        }
    } else  {
        TInputVerifyView *verifyView = (TInputVerifyView*)[_mainView getContentPageByIndex:pageindex];
        [verifyView updateByTextField:textField];
    }
}


- (void)doNextPage:(id)sender {
    UIButton *btn = (UIButton*)sender;
    
    if (btn.tag == passType_Input_Phone) { //
        TInputPhoneView *inputPhone = (TInputPhoneView*)[_mainView getContentPageByIndex:btn.tag];
        [inputPhone cancellKeyboard];
        BOOL isValida = [inputPhone updateByTextField:[inputPhone getTextField]];
        if (!isValida)return;
        
        NSString *phoneValue = [inputPhone getTextFieldValue];
        // 发送请求，验证录入的手机号已被注册过
        [[TUtilities getInstance]popTarget:_mainView];
        [[TServerFactory getServerInstance:@"TUserCenterServer"]doSendVerifyByUserName:phoneValue and:0
                                                                           andCallback:^(NSString *verifyStr) {
                                                                               _currentDisplayPage = btn.tag + 1;
                                                                               [self goNextPage:_currentDisplayPage];
                                                                               
                                                                               TInputVerifyView *verifyView = (TInputVerifyView*)[_mainView getContentPageByIndex:_currentDisplayPage];

                                                                               verifyView.phone = phoneValue;
                                                                               verifyView.verifyStr = verifyStr;
                                                                               
                                                                               [verifyView startTimer];
                                                                           } failureCallback:^(NSString *resp) {
                                                                               [[TUtilities getInstance]popMessageError:resp target:_mainView delayTime:1.0];
                                                                           }];
    }
    
    if (btn.tag == passType_Input_Verify) { //
        // 获取验证码是否与手机号接收的一致，如果不一致提示用户重新输入，如果一致成功跳转到密码重置界面
        TInputVerifyView *verifyView = (TInputVerifyView*)[_mainView getContentPageByIndex:btn.tag];
        NSString *verifyValue = [verifyView getTextFieldValue];
        BOOL isValida = [verifyView updateByTextField:[verifyView getTextField]];
        if (!isValida)return;
        
        if (![verifyValue isEqualToString:verifyView.verifyStr]) {
            [verifyView.validaTextField changeValidationValue:Input_NO andText:@"输入的验证码不匹配"];
            return;
        }

        _currentDisplayPage = btn.tag + 1;
        [self goNextPage:_currentDisplayPage];
        
        TRestPassView *restPassView = (TRestPassView*)[_mainView getContentPageByIndex:_currentDisplayPage];
        restPassView.phone = verifyView.phone;
        restPassView.verifyStr = verifyView.verifyStr;
    }
    
    
    if (btn.tag == passType_Reset_Password) { //
        TRestPassView *restPassView = (TRestPassView*)[_mainView getContentPageByIndex:btn.tag];
        BOOL isValida = [restPassView updateByTextField:[restPassView getPasswordTextField]];
        isValida = [restPassView updateByTextField:[restPassView getRePasswordTextField]];
        if (!isValida) return;
        
        [[TUtilities getInstance]popTarget:_mainView];
        [restPassView cancelKeyboard];
        [[TServerFactory getServerInstance:@"TUserCenterServer"]updatePasswordByUserName:restPassView.phone
                                                                             andpassword:[restPassView getPasswordTextField].text
                                                                                 andCode:restPassView.verifyStr
                                                                            andCallback:^(NSString *verifyStr) {
                                                                                NSArray *controlles = self.navigationController.viewControllers;
                                                                                for (UIViewController *contrller in controlles) {
                                                                                    if ([contrller isKindOfClass:[TLoginController class]]) {
                                                                                        [self.navigationController popToViewController:contrller animated:YES];
                                                                                    }
                                                                                }
                                                                                [[TUtilities getInstance]storeUserInfo:restPassView.phone andPassword:[restPassView getPasswordTextField].text ];
                                                                             } failureCallback:^(NSString *resp) {
                                                                                 [[TUtilities getInstance]popMessageError:resp target:_mainView delayTime:1.0];
                                                                             }];
    }
}

- (void)goNextPage:(int)page {
    [_mainView goPageByIndex:page];
    [_menuView goPageByindex:page];
}

- (void)dealloc {
    [super dealloc];
    
    [_menuView release];
    _menuView = nil;
    
    [_mainView release];
    _mainView = nil;
}


@end
