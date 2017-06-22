//
//  TBasePassView.h
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPasswordController.h"

@interface TBasePassView : UIView {
    UIButton *_nextBtn;
    int mTime;
}

@property (nonatomic,retain)NSString *phone;
@property (nonatomic,retain)NSString *verifyStr;

/**
 * 构造方法
 * passwordPageType 在密码找回
 */
- (id)initWithFrame:(CGRect)frame andPasswordPageType:(PasswordPageType)passwordPageTyp;

/**
 *  构造一个按钮,开始一个用户行为
 */
- (void) addActionBtn:(PasswordPageType)passwordPageTyp;

/**
 *  设置按钮监听对象
 */
- (void)setTargetAction:(id)target;

/**
 * 获取控件值
 */
- (NSString*)getTextFieldValue;
- (UITextField*)getTextField;


/**
 * 更新控件验证标记
 */
- (BOOL)updateByTextField:(UITextField*)textField;

/**
 * 开始计时
 */
- (void)startTimer;

/**
 * 计时
 */
- (void)timerAdvanced:(NSTimer*)timer;

@end
