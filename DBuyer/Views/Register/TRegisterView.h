//
//  TRegisterView.h
//  DBuyer
//
//  Created by dilei liu on 14-3-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDbuyerTextField.h"
#import "TDbuyerFieldController.h"

@interface TRegisterView : UIView {
    TDbuyerFieldController *_phoneField;
    TDbuyerFieldController *_passwordField;
    TDbuyerFieldController *_repasswordField;
    TDbuyerFieldController *_validaField;
    
    UIButton *_agreementButton;
    UILabel *_protocolLabel;
    // UIButton *_getValidaBtn;
    UILabel *_getValidaBtn;
    
    BOOL _isTimer;
    
    int mTime;
}
/**
 *  事件传递
 */
- (void)setTargetAction:(id)target;

/**
 *  取消键盘
 */
- (void)cancelKeyboard;

/**
 *  更新控件验证标记
 */
- (BOOL)updateByTextField:(UITextField*)textField;

/**
 *  是否赞同注册协议
 */
- (void)changeAgreementButtonImage;

/**
 *  获取输入控件对象
 */
- (UITextField*)getPhoneToTextField;
- (UITextField*)getPasswordToTextField;
- (UITextField*)getRePasswordToTextField;

- (NSString*)getVerifyCode;
- (BOOL)getAgreementBoolValue;

- (void)startTimer;


@end
