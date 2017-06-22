//
//  TLoginView.h
//  DBuyer
//
//  Created by dilei liu on 14-3-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDbuyerFieldController.h"

/**
 *登录组件UI封装类
 */
@interface TLoginView : UIView {
    UIButton *_registerBtn;
    UIButton *_loginBtn;
    UIButton *_forgetBtn;
}

@property(nonatomic,retain) TDbuyerFieldController *accountControl;
@property(nonatomic,retain) TDbuyerFieldController *passwordControl;

/**
 * 设置dbuyertextfield代理实现对象
 */
- (void)setTargetAction:(id)target;

/**
 * 通过验证值来更新LoginView UI
 */
- (BOOL)updateByTextField:(UITextField*)field;

/**
 * 获取用户手机号
 */
- (NSString*)getUserName;

/**
 * 接收用户密码
 */
- (NSString*)getPassword;


/**
 * 关闭视图上打开的键盘
 */
- (void)cancelKeyboard;

/**
 * 每次打开登录界面时,匹配下本地帐号是否存在，如果有自动填入帐号输入框中
 */
- (void) setPhoneAccount;

/**
 * 清理表单控件值
 */
- (void) cleanTextFieldValue;

@end
